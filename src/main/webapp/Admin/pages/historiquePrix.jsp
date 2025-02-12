<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classTable.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fruits et Légumes - Accueil</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/index.css">
  <script src="<%=request.getContextPath()%>/assets/admin/js/Vue.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Deconnexion.js"></script>

  <style>
    /* Style général du main */
    main {
        max-width: 900px;
        margin: 40px auto;
        padding: 20px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
    }

    /* Titre */
    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    /* Tableau */
    table {
        width: 100%;
        border-collapse: collapse;
        background: #f8f8f8;
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: center;
    }

    th {
        background: #4CAF50;
        color: white;
        font-size: 16px;
    }

    td {
        background: #ffffff;
    }

    tr:nth-child(even) td {
        background: #f2f2f2;
    }

    tr:hover td {
        background: #ddd;
    }

    /* Images */
    img {
        border-radius: 5px;
    }

    /* Bouton "voir historique" */
    input[type="submit"] {
        background: #ef9115;
        color: white;
        border: none;
        padding: 8px 12px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 14px;
    }

    input[type="submit"]:hover {
        background: #d66d0b;
    }

    /* Footer */
    footer {
        text-align: center;
        margin-top: 40px;
        padding: 10px;
        background: #333;
        color: white;
    }
  </style>
</head>
<body>
  <header>
    <div class="logo">
      <img src="<%=request.getContextPath()%>/assets/admin/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/AccueilAdmin" class="active">Dashboard</a></li>
        <li><a href="<%=request.getContextPath()%>/Insertion" class="active">Insertion</a></li>
        <li><a href="<%=request.getContextPath()%>/Vente" class="active">Vente</a></li>
        <li><a href="<%=request.getContextPath()%>/HistoriquePrix" class="active">Historique Prix</a></li>
        <li>
          <a href="pages/deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="<%=request.getContextPath()%>/assets/admin/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>
  
  <%
      Produits[] produits = (Produits[]) request.getAttribute("produits");
  %>

  <main id="app">
    <h2>Liste des Produits</h2>
    <table id="ventesTable">
        <thead>
          <tr>
            <th>Image</th>
            <th>Nom Produit</th>
            <th>Description</th>
            <th>Lien</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <%
            for(Produits p: produits){
          %>
            <tr>
                <td><img src="<%=p.getimageS()%>" alt="<%=p.getnom()%>" style="width: 40px; height: 40px;"></td>
                <td><%=p.getnom()%></td>
                <td><%=p.getdescription()%></td>
                <td>
                    <form action="<%=request.getContextPath()%>/HistoriquePrix" method="post">
                        <input type="hidden" name="idProduit" value="<%=p.getid()%>">
                        <input type="submit" value="Voir Historique">
                    </form>
                </td>
            </tr>
          <%
            }
          %>
        </tbody>
      </table>
  </main>
        
  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>
</body>
</html>
