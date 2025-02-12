package utilitaire;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSetMetaData;

/**
 * Gestion d'une connexion unique (singleton).
 * Se reconnecte automatiquement si la connexion a été fermée ou n'existe pas.
 * Ferme la connexion après 1 minute d'inactivité via un Thread en arrière-plan.
 */
public class BdConnect {

    // ---------------------- SINGLETON ET GESTION DU TIMEOUT -------------------- //

    private static volatile BdConnect instance; // instance du singleton
    private static volatile Connection connexion; 
    private static long lastAccessTime = 0L; 
    private static final long TIMEOUT = 60_000;  // 60_000 ms = 1 minute

    // Thread pour surveiller l'inactivité
    private static Thread timeoutThread;
    private static boolean running = true; 

    // Constructeur privé pour le singleton
    private BdConnect() {
        // on ne fait rien directement ici 
        // la création effective se fait dans getConnection() si besoin
    }

    /**
     * Retourne l'unique instance BdConnect.
     * Si la connexion n'existe pas ou est fermée (ou a expiré), on la réouvre.
     */
    public static BdConnect getInstance() throws Exception{
        if (instance == null) {
            synchronized (BdConnect.class) {
                if (instance == null) {
                    instance = new BdConnect();
                    startTimeoutThread(); // démarrer le thread de surveillance s'il n'est pas déjà lancé
                }
            }
        }
        // On s'assure que la connexion est OK
        instance.getConnection();
        return instance;
    }

    /**
     * Retourne la connexion. Si elle n'existe pas ou est fermée, la recrée.
     * Met à jour la dernière date d'accès (lastAccessTime).
     */
    private Connection getConnection() {
        synchronized (BdConnect.class) {
            try {
                if (connexion == null || connexion.isClosed() || isTimedOut()) {
                    createConnection();
                }
                // chaque fois qu'on utilise la connexion, on met à jour lastAccessTime
                lastAccessTime = System.currentTimeMillis();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return connexion;
        }
    }

    /**
     * Création physique de la connexion.
     */
    private void createConnection() {
        try {
            // Charger le driver
            Class.forName("org.postgresql.Driver");
            // Obtenir les détails via DBUtil
            DBUtil dbUtil = new DBUtil();
            connexion = DriverManager.getConnection(dbUtil.getUrl(), dbUtil.getUser(), dbUtil.getPassword());
            System.out.println("Connexion ouverte (BdConnect).");
        } catch (ClassNotFoundException e) {
            System.out.println("Erreur : pilote JDBC non trouvé.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Erreur de connexion : " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Renvoie vrai si le temps écoulé depuis le dernier accès > TIMEOUT.
     */
    private static boolean isTimedOut() {
        long now = System.currentTimeMillis();
        return (now - lastAccessTime) > TIMEOUT;
    }

    /**
     * Lance un Thread qui vérifie périodiquement l'inactivité et ferme la connexion si besoin.
     */
    private static void startTimeoutThread() {
        if (timeoutThread == null) {
            timeoutThread = new Thread(() -> {
                while (running) {
                    try {
                        Thread.sleep(10_000); // vérification toutes les 10 secondes
                        synchronized (BdConnect.class) {
                            // On capture l'exception ici pour isClosed() et close()
                            try {
                                if (connexion != null && !connexion.isClosed() && isTimedOut()) {
                                    connexion.close();
                                    connexion = null;
                                    System.out.println("Connexion fermée automatiquement après 1 minute d'inactivité.");
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    } catch (InterruptedException e) {
                        // si on interrompt le thread, on sort de la boucle
                        Thread.currentThread().interrupt();
                    }
                }
            });
            timeoutThread.setDaemon(true);
            timeoutThread.start();
        }
    }
    

    /**
     * Méthode pour fermer manuellement la connexion (et stopper le thread de surveillance si besoin).
     * Vous pouvez l'appeler si vous voulez forcer la fermeture dans certaines situations.
     */
    public static void shutdown() {
        running = false;
        if (timeoutThread != null) {
            timeoutThread.interrupt();
        }
        synchronized (BdConnect.class) {
            if (connexion != null) {
                try {
                    connexion.close();
                    connexion = null;
                    System.out.println("Connexion fermée manuellement.");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ---------------------- MÉTHODES GÉNÉRIQUES --------------------- //

    /**
     * Récupère un tableau d'objets de type T depuis la table tableName.
     */
    public <T> T[] getObjectFromTable(String tableName, Class<T> clazz) {
        List<T> results = new ArrayList<>();
        Connection cnx = getConnection(); // on récupère la connexion unique
        try {
            String query = "SELECT * FROM " + tableName;
            PreparedStatement preparedStatement = cnx.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            Field[] fields = clazz.getDeclaredFields();

            while (resultSet.next()) {
                Constructor<T> constructor = clazz.getDeclaredConstructor();
                T instance = constructor.newInstance();

                for (Field field : fields) {
                    field.setAccessible(true);
                    String fieldName = field.getName();
                    Object value = resultSet.getObject(fieldName);

                    // Convertir BigDecimal en double si le champ est de type double
                    if (value instanceof BigDecimal && field.getType().equals(double.class)) {
                        value = ((BigDecimal) value).doubleValue();
                    }

                    field.set(instance, value);
                }
                results.add(instance);
            }
        } catch (SQLException e) {
            System.out.println("Erreur SQL : " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        @SuppressWarnings("unchecked")
        T[] array = (T[]) Array.newInstance(clazz, results.size());
        return results.toArray(array);
    }

    /**
     * Insère un objet dans la table spécifiée.
     */
    public <T> boolean insertObjectIntoTable(String tableName, T object) {
        Connection cnx = getConnection();
        try {
            Field[] fields = object.getClass().getDeclaredFields();
            StringJoiner columns = new StringJoiner(", ");
            StringJoiner values = new StringJoiner(", ");

            for (Field field : fields) {
                field.setAccessible(true);
                if (field.getName().equalsIgnoreCase("id")) {
                    Object value = field.get(object);
                    if (value != null && (Integer) value == 0) {
                        continue;
                    }
                }
                columns.add(field.getName());
                values.add("?");
            }

            String sql = "INSERT INTO " + tableName + " (" + columns.toString() + ") VALUES (" + values.toString() + ")";
            PreparedStatement preparedStatement = cnx.prepareStatement(sql);

            int index = 1;
            for (Field field : fields) {
                field.setAccessible(true);
                if (field.getName().equalsIgnoreCase("id")) {
                    Object value = field.get(object);
                    if (value != null && (Integer) value == 0) {
                        continue;
                    }
                }
                Object value = field.get(object);
                preparedStatement.setObject(index++, value);
            }

            preparedStatement.executeUpdate();
            System.out.println("Insertion réussie dans la table " + tableName);
            return true;
        } catch (SQLException e) {
            System.out.println("Erreur lors de l'insertion : " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (IllegalAccessException e) {
            System.out.println("Erreur accès champs : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Met à jour un objet dans la table en ne mettant à jour que les champs non nuls (et != 0 pour int/double...).
     */
    public <T> void updateObjectInTable(String tableName, T object, String primaryKeyField) {
        Connection cnx = getConnection();
        try {
            Field[] fields = object.getClass().getDeclaredFields();
            StringBuilder query = new StringBuilder("UPDATE " + tableName + " SET ");
            String primaryKeyValue = null;
            List<Object> nonNullValues = new ArrayList<>();

            for (Field field : fields) {
                field.setAccessible(true);
                Object fieldValue = field.get(object);

                if (field.getName().equals(primaryKeyField)) {
                    primaryKeyValue = (fieldValue != null) ? fieldValue.toString() : null;
                    continue;
                }

                if (fieldValue != null && !isDefaultValue(field, fieldValue)) {
                    query.append(field.getName()).append(" = ?, ");
                    nonNullValues.add(fieldValue);
                }
            }

            if (nonNullValues.isEmpty()) {
                System.out.println("Aucune valeur non nulle à mettre à jour.");
                return;
            }

            query.setLength(query.length() - 2); // on enlève la dernière virgule
            query.append(" WHERE ").append(primaryKeyField).append(" = ?");

            PreparedStatement preparedStatement = cnx.prepareStatement(query.toString());
            int paramIndex = 1;
            for (Object value : nonNullValues) {
                preparedStatement.setObject(paramIndex++, value);
            }
            if (primaryKeyValue != null) {
                preparedStatement.setObject(paramIndex, primaryKeyValue);
            } else {
                System.out.println("Erreur : la clé primaire ne peut pas être nulle.");
                return;
            }

            int affectedRows = preparedStatement.executeUpdate();
            System.out.println("Mise à jour réussie, lignes affectées : " + affectedRows);

        } catch (SQLException e) {
            System.out.println("Erreur SQL update : " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            System.out.println("Erreur d'accès aux champs : " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Vérifie si une valeur est la valeur par défaut du type du champ.
     */
    private boolean isDefaultValue(Field field, Object value) {
        Class<?> type = field.getType();
        if (type.equals(int.class) || type.equals(Integer.class)) {
            return ((Integer) value) == 0;
        } else if (type.equals(double.class) || type.equals(Double.class)) {
            return ((Double) value) == 0.0;
        } else if (type.equals(float.class) || type.equals(Float.class)) {
            return ((Float) value) == 0.0f;
        } else if (type.equals(long.class) || type.equals(Long.class)) {
            return ((Long) value) == 0L;
        } else if (type.equals(short.class) || type.equals(Short.class)) {
            return ((Short) value) == 0;
        } else if (type.equals(byte.class) || type.equals(Byte.class)) {
            return ((Byte) value) == 0;
        } else if (type.equals(boolean.class) || type.equals(Boolean.class)) {
            return !((Boolean) value); 
        }
        return false;  
    }

    /**
     * Récupère le dernier ID inséré (en se basant sur un champ 'id').
     */
    public String getLastInsertIdFromTable(String tableName, String column) throws SQLException {
        Connection cnx = getConnection();
        String lastInsertId = "";
        try {
            String sql = "SELECT id AS lastId FROM " + tableName + " ORDER BY id DESC LIMIT 1";
            PreparedStatement preparedStatement = cnx.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                lastInsertId = resultSet.getString("lastId");
            }
            System.out.println("Dernier ID inséré dans " + tableName + " : " + lastInsertId);
        } catch (SQLException e) {
            System.out.println("Erreur getLastInsert : " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return lastInsertId;
    }

    /**
     * Exécute une requête SQL qui ne renvoie qu'une seule valeur.
     */
    public Object getSingleValueFromQuery(String sql) {
        Connection cnx = getConnection();
        Object result = null;
        try {
            PreparedStatement preparedStatement = cnx.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                result = resultSet.getObject(1);
            }
        } catch (SQLException e) {
            System.out.println("Erreur requête SQL : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Génère une classe Java à partir d'une table (exemple).
     */
    public void generateClassFromTable(String tableName, String outputDirectory) {
        Connection cnx = getConnection();
        try {
            String query = "SELECT * FROM " + tableName + " LIMIT 1";
            PreparedStatement preparedStatement = cnx.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();

            String className = toPascalCase(tableName);

            StringBuilder classCode = new StringBuilder();
            classCode.append("package classTable;\n\n")
                     .append("import Fonction.Fonction;\n\n")
                     .append("public class ").append(className).append(" extends Fonction {\n\n");

            // Attributs
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                String columnName = metaData.getColumnName(i);
                String columnType = metaData.getColumnTypeName(i);
                String javaType = sqlTypeToJavaType(columnType);

                classCode.append("    private ").append(javaType).append(" ")
                         .append(toCamelCase(columnName)).append(";\n");
            }

            classCode.append("\n    // Constructeur par défaut\n")
                     .append("    public ").append(className).append("() {}\n\n");

            // Constructeur avec tous paramètres
            classCode.append("    public ").append(className).append("(");
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                String columnName = metaData.getColumnName(i);
                String columnType = metaData.getColumnTypeName(i);
                String javaType = sqlTypeToJavaType(columnType);
                classCode.append(javaType).append(" ").append(toCamelCase(columnName));
                if (i < metaData.getColumnCount()) {
                    classCode.append(", ");
                }
            }
            classCode.append(") {\n");
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                String columnName = metaData.getColumnName(i);
                String attributeName = toCamelCase(columnName);
                classCode.append("        this.").append(attributeName).append(" = ")
                         .append(attributeName).append(";\n");
            }
            classCode.append("    }\n\n");

            // Getters & Setters
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                String columnName = metaData.getColumnName(i);
                String columnType = metaData.getColumnTypeName(i);
                String javaType = sqlTypeToJavaType(columnType);

                String attributeName = toCamelCase(columnName);
                String methodName = toPascalCase(columnName);

                classCode.append("    public ").append(javaType).append(" get")
                         .append(methodName).append("() {\n")
                         .append("        return ").append(attributeName).append(";\n    }\n\n");

                classCode.append("    public void set").append(methodName).append("(")
                         .append(javaType).append(" ").append(attributeName).append(") {\n")
                         .append("        this.").append(attributeName).append(" = ")
                         .append(attributeName).append(";\n    }\n\n");
            }

            classCode.append("}");

            try (FileWriter fileWriter = new FileWriter(outputDirectory + "/" + className + ".java")) {
                fileWriter.write(classCode.toString());
            }

            System.out.println("Classe générée : " + className);

        } catch (SQLException | IOException e) {
            System.out.println("Erreur génération classe : " + e.getMessage());
            e.printStackTrace();
        }
    }

    // ------------------ Méthodes utilitaires privées ----------------- //

    private String sqlTypeToJavaType(String sqlType) {
        switch (sqlType.toLowerCase()) {
            case "varchar":
            case "char":
            case "text":
                return "String";
            case "int":
            case "integer":
            case "serial":
                return "int";
            case "bigint":
                return "long";
            case "double":
            case "numeric":
            case "float":
            case "decimal":
                return "double";
            case "date":
                return "java.sql.Date";
            case "timestamp":
                return "java.sql.Timestamp";
            case "bytea":
                return "byte[]";
            case "bool":
            case "boolean":
                return "int"; 
            default:
                return "String";
        }
    }

    private String toCamelCase(String text) {
        // Ici, vous pouvez implémenter de vraies conversions camelCase si vous le souhaitez
        return text;
    }

    private String toPascalCase(String text) {
        // Pareil, ici c'est laissé tel quel, ou vous mettez la logique de conversion
        return text;
    }
}
