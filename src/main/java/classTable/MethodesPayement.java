package classTable;

import Fonction.Fonction;

public class MethodesPayement extends Fonction {

    private int id;
    private String methode;

    // Constructeur par défaut
    public MethodesPayement() {}

    // Constructeur avec tous les paramètres
    public MethodesPayement(int id, String methode) {
        this.id = id;
        this.methode = methode;
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public String getmethode() {
        return methode;
    }

    public void setmethode(String methode) {
        this.methode = methode;
    }

}