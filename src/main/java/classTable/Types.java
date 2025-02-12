package classTable;

import Fonction.Fonction;

public class Types extends Fonction {

    private int id;
    private String type;
    private String description;

    // Constructeur par défaut
    public Types() {}

    // Constructeur avec tous les paramètres
    public Types(int id, String type, String description) {
        this.id = id;
        this.type = type;
        this.description = description;
    }
    public Types(String type, String description) {
        this.type = type;
        this.description = description;
    }

    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id = id;
    }

    public String gettype() {
        return type;
    }

    public void settype(String type) {
        this.type = type;
    }

    public String getdescription() {
        return description;
    }

    public void setdescription(String description) {
        this.description = description;
    }

}