-- Creation de la base de données
-- CREATE USER Anthony WITH PASSWORD 'root';
-- GRANT ALL PRIVILEGES ON DATABASE produits_agricoles TO Anthony;
drop database produits_agricoles;
CREATE DATABASE produits_agricoles;

-- Connexion à la base de données
\c produits_agricoles;

-- Table des utilisateurs
CREATE TABLE Utilisateurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    motDePasse VARCHAR(255) NOT NULL,
    telephone VARCHAR(20),
    dateInscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role VARCHAR(20) DEFAULT 'client' -- 'admin' ou 'client'
);

CREATE TABLE Remise(
    id SERIAL PRIMARY KEY,
    pourcentage DECIMAL(10, 2) NOT NULL,
    prixatteint DECIMAL(10, 2) NOT NULL
);

INSERT INTO Remise (pourcentage,prixatteint) VALUES (15,6000);
-- Table des Types
CREATE TABLE Types (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Table des catégories
CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) UNIQUE NOT NULL,
    typeId INT REFERENCES types(id) ON DELETE CASCADE,
    description TEXT
);

-- Table des catégories
CREATE TABLE Saisons (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) UNIQUE NOT NULL
);

-- Table des produits
CREATE TABLE Produits (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    image BYTEA, -- Utilisation de BYTEA au lieu de BLOB
    unite VARCHAR(20),
    categorieId INT REFERENCES categories(id) ON DELETE CASCADE,
    saisonId INT REFERENCES saisons(id) ON DELETE CASCADE,
    dateAjout TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Promotions(
    id SERIAL PRIMARY KEY,
    produitId INT REFERENCES produits(id) ON DELETE CASCADE,
    pourcentage DECIMAL(10, 2) NOT NULL,
    debut TIMESTAMP,
    fin TIMESTAMP
);

-- Table de gestion des stocks
CREATE TABLE Stock (
    id SERIAL PRIMARY KEY,
    produitId INT REFERENCES produits(id) ON DELETE CASCADE,
    quantiteDisponible INT NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    typemvt int, -- 0 entree 1 sortie
    dateAjout TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from stock where produitId = 1 ORDER BY dateAjout Desc;

-- cree moi un view stockRestant en determinant le reste de stock entree - sortie 
DROP TABLE Commandes CASCADE;

-- Table des commandes
CREATE TABLE Commandes (
    id SERIAL PRIMARY KEY,
    utilisateurId INT REFERENCES utilisateurs(id) ON DELETE CASCADE,
    statut VARCHAR(50) DEFAULT 'En attente',
    total DECIMAL(10, 2) NOT NULL,
    remise DECIMAL(10, 2) NOT NULL,
    dateCommande TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE DetailsCommande CASCADE;
-- Table des détails de commande
CREATE TABLE DetailsCommande(
    id SERIAL PRIMARY KEY,
    commandeId INT REFERENCES commandes(id) ON DELETE CASCADE,
    produitId INT REFERENCES produits(id) ON DELETE CASCADE,
    quantite DECIMAL(10, 2) NOT NULL,
    prixUnitaire DECIMAL(10, 2) NOT NULL
);

-- Table des Types
CREATE TABLE MethodesPayement (
    id SERIAL PRIMARY KEY,
    methode VARCHAR(100) UNIQUE NOT NULL
);

-- Table des paiements
CREATE TABLE Paiements (
    id SERIAL PRIMARY KEY,
    commandeId INT REFERENCES commandes(id) ON DELETE CASCADE,
    methodePayementId INT REFERENCES MethodesPayement(id) ON DELETE CASCADE,
    montant DECIMAL(10, 2) NOT NULL,
    statut VARCHAR(50) DEFAULT 'En attente',
    datePaiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des livraisons
CREATE TABLE Livraisons (
    id SERIAL PRIMARY KEY,
    commandeId INT REFERENCES commandes(id) ON DELETE CASCADE,
    adresseLivraison VARCHAR(255) NOT NULL,
    ville VARCHAR(100),
    codePostal VARCHAR(10),
    dateLivraison TIMESTAMP,
    statut VARCHAR(50) DEFAULT 'En préparation'
);

-- Table des avis des clients
CREATE TABLE Avis (
    id SERIAL PRIMARY KEY,
    utilisateurId INT REFERENCES utilisateurs(id) ON DELETE CASCADE,
    produitId INT REFERENCES produits(id) ON DELETE CASCADE,
    note INT,
    commentaire TEXT,
    dateAvis TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP VIEW IF EXISTS StockRestant;
CREATE OR REPLACE VIEW StockRestant AS
SELECT 
    p.id AS produitId,
    p.nom AS produitNom,
    -- Total des entrées dans le stock
    COALESCE(SUM(CASE WHEN s.typemvt = 0 THEN s.quantiteDisponible ELSE 0 END), 0) AS totalentree,
    -- Total des sorties du stock (mouvements manuels + commandes non annulées)
    (
        COALESCE(SUM(CASE WHEN s.typemvt = 1 THEN s.quantiteDisponible ELSE 0 END), 0) + 
        COALESCE(( 
            SELECT SUM(dc.quantite)
            FROM DetailsCommande dc
            JOIN Commandes c ON dc.commandeId = c.id
            WHERE c.statut IN ('valide', 'En attente') AND dc.produitId = p.id
        ), 0)
    ) AS totalsortie,
    -- Calcul du stock restant
    (
        COALESCE(SUM(CASE WHEN s.typemvt = 0 THEN s.quantiteDisponible ELSE 0 END), 0) - 
        (
            COALESCE(SUM(CASE WHEN s.typemvt = 1 THEN s.quantiteDisponible ELSE 0 END), 0) + 
            COALESCE(( 
                SELECT SUM(dc.quantite)
                FROM DetailsCommande dc
                JOIN Commandes c ON dc.commandeId = c.id
                WHERE c.statut IN ('valide', 'En attente') AND dc.produitId = p.id
            ), 0)
        )
    ) AS stockrestant
FROM 
    Produits p
LEFT JOIN 
    Stock s ON p.id = s.produitId
GROUP BY 
    p.id, p.nom;

    SELECT * FROM StockRestant;


DROP VIEW IF EXISTS Vente;
CREATE OR REPLACE VIEW Vente AS
SELECT
    c.dateCommande::DATE AS datevente,
    CAST(dc.produitId AS INT) AS produitid, -- Conversion en INT
    p.nom AS produitnom,
    SUM(dc.quantite * dc.prixUnitaire) AS totalvente,
    CAST(SUM(dc.quantite) AS INT) AS totalquantite, -- Conversion en INT
    CAST(COUNT(DISTINCT c.id) AS INT) AS nombrecommandes -- Conversion en INT
FROM 
    Commandes c
JOIN 
    DetailsCommande dc ON c.id = dc.commandeId
JOIN 
    Produits p ON dc.produitId = p.id
WHERE 
    c.statut IN ('valide', 'livrée') -- Inclure uniquement les commandes valides ou livrées
GROUP BY 
    c.dateCommande::DATE, dc.produitId, p.nom
ORDER BY 
    c.dateCommande::DATE, dc.produitId;
