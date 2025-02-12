package classTable;

import Fonction.Fonction;

public class Remise extends Fonction {
    private int id;
    private double pourcentage;
    private double prixatteint;

    public Remise() {
        this.setNomTable("Remise");
        this.id = 0;
        this.pourcentage = 0;
        this.prixatteint = 0;
    }

    /**
     * Méthode pour charger les données depuis la base de données.
     * Elle doit être appelée explicitement après la création de l'objet.
     */
    public void loadFirstRemise() {
        try {
            Remise[] remises = this.getObject(Remise.class);
            if (remises.length > 0) {
                this.setters(remises[0]); // Charger les données du premier objet
            }
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement des données Remise : " + e.getMessage());
        }
    }

    private void setters(Remise remise) {
        this.id = remise.getid();
        this.pourcentage = remise.getpourcentage();
        this.prixatteint = remise.getprixatteint();
    }

    // Getters et Setters
    public int getid() {
        return this.id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public double getpourcentage() {
        return this.pourcentage;
    }

    public void setpourcentage(double pourcentage) {
        this.pourcentage = pourcentage;
    }

    public double getprixatteint() {
        return this.prixatteint;
    }

    public void setprixatteint(double prixatteint) {
        this.prixatteint = prixatteint;
    }
}
