package utilitaire;
public class DBUtil {
    String url = "jdbc:postgresql://localhost:5432/produits_agricoles";
    String user = "postgres";
    String password = "root";

    public String getUrl(){
        return url;
    }
    public String getUser(){
        return user;
    }
    public String getPassword(){
        return password;
    }
}
