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
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Titre */
    h2 {
        text-align: center;
        color: #333;
    }

    /* Conteneur du filtre */
    .filter-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
    }

    .filter-container label {
        font-weight: bold;
    }

    .filter-container input, .filter-container button {
        padding: 8px;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .filter-container button {
        background: #28a745;
        color: white;
        cursor: pointer;
    }

    .filter-container button:hover {
        background: #218838;
    }

    /* Tableau */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    th {
        background: #4CAF50;
        color: white;
    }

    tr:nth-child(even) {
        background: #f2f2f2;
    }

    tr:hover {
        background: #ddd;
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
      Produits produit = (Produits) request.getAttribute("produit");
  %>

  <main id="app">
    <h2>Historique des Prix</h2>

    <!-- Filtres -->
    <div class="filter-container">
      <label for="date-debut">Date début :</label>
      <input type="date" id="date-debut">
      <label for="date-fin">Date fin :</label>
      <input type="date" id="date-fin">
      <button id="filtrer">Filtrer</button>
    </div>

    <!-- Tableau des prix -->
    <table id="ventesTable">
      <thead>
        <tr>
          <th>Prix</th>
          <th>Date</th>
        </tr>
      </thead>
      <tbody id="ventesTableBody">
        <%
          for(Stock s: produit.getHistoriquePrix()){
        %>
          <tr>
              <td><%=s.getprix()%></td>
              <td class="date-cell"><%=s.getdateajout()%></td>
          </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </main>

  <script>
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("filtrer").addEventListener("click", function() {
            let dateDebut = document.getElementById("date-debut").value;
            let dateFin = document.getElementById("date-fin").value;
            let rows = document.querySelectorAll("#ventesTableBody tr");

            rows.forEach(row => {
                let dateText = row.querySelector(".date-cell").textContent.trim();
                let rowDate = new Date(dateText);

                let isVisible = true;
                if (dateDebut) {
                    let startDate = new Date(dateDebut);
                    if (rowDate < startDate) {
                        isVisible = false;
                    }
                }
                if (dateFin) {
                    let endDate = new Date(dateFin);
                    if (rowDate > endDate) {
                        isVisible = false;
                    }
                }

                row.style.display = isVisible ? "" : "none";
            });
        });
    });
  </script>

</body>
</html>
