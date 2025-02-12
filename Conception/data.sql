
-- SELECT * FROM Produits;
-- SELECT * FROM Categories;
-- SELECT * FROM Saisons;

INSERT INTO Utilisateurs (nom, email, motDePasse, telephone, role)
VALUES (
    'Anthony Herinantenaina',                  -- Nom de l'utilisateur
    'root@gmail.com',      -- Adresse email
    'root',                -- Mot de passe (en pratique, utilisez un hash)
    '0123456789',                   -- Numéro de téléphone
    'client'                        -- Rôle (par défaut 'client', mais spécifié ici pour l'exemple)
);

INSERT INTO Utilisateurs (nom, email, motDePasse, telephone, role)
VALUES (
    'Anthony Herinantenaina Rantonirina',                  -- Nom de l'utilisateur
    'root2@gmail.com',      -- Adresse email
    'root2',                -- Mot de passe (en pratique, utilisez un hash)
    '0123456789',                   -- Numéro de téléphone
    'client'                        -- Rôle (par défaut 'client', mais spécifié ici pour l'exemple)
);

INSERT INTO Types (type,description) VALUES 
    ('Fruits','voankazo'),
    ('Legumes','Sakafo natioraly'),
    ('Mixte','Sady fruits no legumes');

INSERT INTO Saisons (nom) VALUES 
('Toutes saisons'),
('Saison des pluies'), -- Novembre à Avril
('Saison sèche');      -- Mai à Octobre

INSERT INTO Categories (nom, typeId, description) VALUES 

    ('Fruits à chair molle', 1, 'Ceci regroupe les fruits dont la pulpe est tendre et moelleuse'),
    ('Fruits à coque', 1, 'Ces fruits sont caractérisés par leur noyau dur enrobé d''une chair sucrée'),
    ('Fruits exotiques', 1, 'La catégorie inclut des fruits originaires d''Amérique du Sud, d''Afrique ou d''Asie'),
    ('Fruits à pépin', 1, 'Les pommes de terre sont les représentants typiques de cette catégorie'),
    ('Fruits baies', 1, 'Ceci rassemble des fruits qui ont la forme et certaines caractéristiques de baies'),

    ('Légumes à feuilles vertes', 2, 'La catégorie comprend des légumes riches en vitamine A tels que les épinards'),
    ('Légumes à tubercules', 2, 'Ceci rassemble les légumes dont la partie comestible est un tubercule sous-sol'),
    ('Légumes à graines', 2, 'Les courges, les citrouilles, les choux de Bruxelles sont des exemples de légumes à graine'),
    ('Légumes à paille', 2, 'La catégorie comprend les courges d''été comme le potiron et la butternut'),
    ('Légumes à côtes', 2, 'Ceci regroupe des légumes dont la chair est découpée en côtes ou en losanges'),

    ('Salade composée', 3, 'Une salade composée de fruits et de légumes'),
    ('Fruit-légume hybride', 3, 'Un produit qui a les caractéristiques de both fruit and vegetable');


    -- Fruits à chair molle :
    INSERT INTO Produits (nom, description, unite, categorieId,saisonid) VALUES 
    ('Fraise', 'Fraise sucrée', 'kg', 1,1),
    ('Pomme', 'Pomme rouge vif', 'kg', 1,1),  
    ('Poire', 'Poire jaune douce', 'kg', 1,1),

    -- Fruits à coque : 
    ('Amandes', 'Noix d''amande entières', 'kg', 2,1),
    ('Noix', 'Noix en boîte', 'kg', 2,1),  
    ('Pistaches', 'Pistaches sèches', 'kg', 2,1),

    -- Fruits exotiques :
    ('Mangue', 'Fruit jaune vif exotique', 'kg', 3,1),
    ('Kiwi', 'Petit fruit vert avec graines noires', 'kg', 3,1),  
    ('Litchi', 'Noix de péché rouge', 'kg', 3,1),

    -- Fruits à pépin :
    ('Pomme de terre douce', 'Pomme de terre sucrée', 'kg', 4,2),
    ('Batata', 'Batata dorée', 'kg', 4,2),  
    ('Pomme de terre riz', 'Pomme de terre ronde comme un riz', 'kg', 4,2),

    -- Fruits baies :
    ('Cassis', 'Baie noire et bleue', 'kg', 5,2),
    ('Groseillier', 'Fruit de la groseille', 'kg', 5,2),  
    ('Myrtille', 'Petite baie blanche', 'kg', 5,2),

    -- Légumes à feuilles vertes :
    ('Epinard', 'Légume vert foncé', 'kg', 6,2),
    ('Chou frisé', 'Feuilles de chou blanches et rugueuses', 'kg', 6,2),  
    ('Roucoux', 'Laitue rouge vif', '100g', 6,2),

    -- Légumes à tubercules :
    ('Pomme de terre', 'Tubercule terrestre commun', 'kg', 7,2),
    ('Patate douce', 'Racine sucrée orange', 'kg', 7,2),  
    ('Topinambour', 'Tubercule comestible blanc', 'kg', 7,2),

    -- Légumes à graines :
    ('Courgette', 'Ovule de courge verte', 'kg', 8,3),
    ('Pois gourmands', 'Légume vert avec des grains', 'kg', 8,3),  
    ('Chou de Bruxelles', 'Feuilles de chou blanches et coudées', 'kg', 8,3),

    -- Légumes à paille :
    ('Potiron', 'Gros fruit d''hiver avec chair orange', 'kg', 9,3),
    ('Butternut', 'Courge allongée doré', 'kg', 9,3),  
    ('Muscade', 'Fruit de la courge muscade', 'kg', 9,3),

    -- Légumes à côtes :
    ('Carotte', 'Racine orange comestible', 'kg', 10,3),
    ('Navet', 'Légume ronde avec chair jaune', 'kg', 10,3),  
    ('Concombre', 'Côtes de cosses vertes', 'kg', 10,3);

INSERT INTO Stock (produitId, quantiteDisponible, prix, typemvt)
VALUES
    (1, 100, 5.99, 0),
    (2, 80, 7.50, 0),
    (3, 60, 12.99, 0),
    (4, 120, 3.75, 0),
    (5, 90, 8.99, 0),
    (6, 40, 15.00, 0),
    (7, 200, 2.50, 0),
    (8, 150, 6.99, 0),
    (9, 75, 10.49, 0),
    (10, 30, 4.99, 0);

INSERT INTO Stock (produitId, quantiteDisponible, prix, typemvt)
VALUES
    (1, 20, 5.99, 1),
    (2, 15, 7.50, 1),
    (3, 25, 12.99, 1),
    (4, 10, 3.75, 1),
    (5, 5, 8.99, 1),
    (6, 30, 15.00, 1),
    (7, 50, 2.50, 1),
    (8, 40, 6.99, 1),
    (9, 10, 10.49, 1),
    (10, 5, 4.99, 1);


INSERT INTO Promotions (produitId, pourcentage, debut, fin)
VALUES
  (1, 10.00, '2025-01-15 08:00:00', '2025-01-10 23:59:59');

INSERT INTO Promotions (produitId, pourcentage, debut, fin)
VALUES
  (2, 15.50, '2025-01-15 10:15:00', '2025-02-15 23:59:59');

INSERT INTO Promotions (produitId, pourcentage, debut, fin)
VALUES
  (3, 20.00, '2025-01-15 10:14:00', '2025-03-05 23:59:59');

INSERT INTO Promotions (produitId, pourcentage, debut, fin)
VALUES
  (4, 25.00, '2025-01-15 08:00:00', '2025-04-07 23:59:59');

INSERT INTO Promotions (produitId, pourcentage, debut, fin)
VALUES
  (5, 25.00, '2025-01-15 08:00:00', '2025-04-07 23:59:59');

-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'En attente',36000);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'En attente',72000);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'En attente',300);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'Annuler',60000);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'Valide',62626);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'Valide',242000);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'Valide',25600);
-- INSERT INTO Commandes (utilisateurId,statut,total) VALUES (1,'Valide',560000);

