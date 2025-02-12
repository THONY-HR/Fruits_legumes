package Fonction;

import java.sql.Time;
import java.util.Date;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import utilitaire.BdConnect;

import java.text.SimpleDateFormat;
import java.time.Year;

/**
 * Classe "parent" proposant des méthodes utilitaires.
 * Ne gère plus la connexion de façon directe : on utilise BdConnect.getInstance().
 */
public class Fonction {
    
    protected String nomTable;
    protected double duree;
    protected String key;
    protected double quantiter;
    
    // ------------------------------------------------------------------
    // 1) Méthodes CRUD utilisant BdConnect
    // ------------------------------------------------------------------

    /**
     * Insertion dans la table (this est l'objet courant).
     */
    public boolean inserer() throws Exception {
        try {
            boolean bool = BdConnect.getInstance().insertObjectIntoTable(this.getNomTable(), this);
            if (bool) {
                System.out.println("Insertion réussie dans " + nomTable);
            }
            return bool;
        } catch (Exception e) {
            throw new Exception("Erreur: Insertion: " + nomTable + " " + e.getMessage());
        }
    }

    /**
     * Mise à jour dans la table.
     * @param primaryKey nom du champ clé primaire (ex: "id").
     */
    public boolean update(String primaryKey) throws Exception {
        try {
            BdConnect.getInstance().updateObjectInTable(this.getNomTable(), this, primaryKey);
            System.out.println("Update réussie dans " + nomTable);
            return true;
        } catch (Exception e) {
            throw new Exception("Erreur Update: " + nomTable + " " + e.getMessage());
        }
    }

    /**
     * Récupère le dernier ID inséré.
     */
    public String getLastInsert(String column) throws Exception {
        try {
            return BdConnect.getInstance().getLastInsertIdFromTable(this.getNomTable(), column);
        } catch (Exception e) {
            throw new Exception("Erreur getLastInsert: " + nomTable + " " + e.getMessage());
        }
    }

    /**
     * Récupère tous les objets de la table correspondante.
     */
    public <T> T[] getObject(Class<T> clazz) throws Exception {
        try {
            return BdConnect.getInstance().getObjectFromTable(this.getNomTable(), clazz);
        } catch (Exception e) {
            throw new Exception("Erreur getObject: " + nomTable + " " + e.getMessage());
        }
    }

    // ------------------------------------------------------------------
    // 2) Méthodes "utilitaires" (session, conversions, etc.)
    // ------------------------------------------------------------------

    public void setSession(HttpSession session, String nomSession, Object obj) {
        if (session != null && nomSession != null && !nomSession.isEmpty() && obj != null) {
            session.setAttribute(nomSession, obj);
        } else {
            throw new IllegalArgumentException("Paramètres invalides pour définir la session.");
        }
    }

    public <T> T getSession(HttpSession session, String nomSession, Class<T> clazz) {
        if (session != null && nomSession != null && !nomSession.isEmpty() && clazz != null) {
            Object attribute = session.getAttribute(nomSession);
            if (clazz.isInstance(attribute)) {
                return clazz.cast(attribute);
            }
        }
        return null;
    }

    // ------------------------------------------------------------------
    // 3) Accesseurs / Mutateurs (getters / setters)
    // ------------------------------------------------------------------

    public void setKey(String keys) {
        this.key = keys;
    }

    public String getKey() {
        return this.key;
    }

    public double getQtt() {
        return this.quantiter;
    }

    public void setQtt(String qtt) {
        this.quantiter = Double.parseDouble(qtt);
    }

    public void setQtt(double qtt) {
        this.quantiter = qtt;
    }

    public String getNomTable() {
        return this.nomTable;
    }

    public void setNomTable(String nomTable) {
        this.nomTable = nomTable;
    }

    public double getLongueurDuree() {
        return this.duree;
    }

    public void setLongueurDuree(double duree) {
        this.duree = duree;
    }

    // ------------------------------------------------------------------
    // 4) Conversions
    // ------------------------------------------------------------------

    public int toInteger(String value) {
        return Integer.parseInt(value);
    }

    public double toDouble(String value) {
        return Double.parseDouble(value);
    }

    public Date toDate(String dateStr) {
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        } catch (Exception e) {
            return null;
        }
    }

    public java.sql.Date toDateBase(String dateStr) {
        try {
            return java.sql.Date.valueOf(dateStr);
        } catch (Exception e) {
            return null;
        }
    }

    public Year toYear(String yearString) {
        try {
            return Year.parse(yearString);
        } catch (Exception e) {
            System.err.println("Erreur : la chaîne '" + yearString + "' n'est pas une année valide.");
            return null;
        }
    }

    public Time toTime(String time) throws IllegalArgumentException {
        if (time != null && time.matches("\\d{2}:\\d{2}")) {
            String timeWithSecond = time + ":00";
            return Time.valueOf(timeWithSecond);
        } else {
            throw new IllegalArgumentException("Le format de l'heure n'est pas valide (hh:mm).");
        }
    }

    public String toStringTime(Time time) {
        if (time == null) {
            return "erreur";
        }
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
        return formatter.format(time);
    }

    public byte[] convertToBytes(Part filePart) throws IOException {
        byte[] imagesBytes = null;
        try (InputStream inputStream = filePart.getInputStream();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            imagesBytes = outputStream.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return imagesBytes;
    }
}
