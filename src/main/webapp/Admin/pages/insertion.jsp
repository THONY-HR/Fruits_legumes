<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classTable.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fruits et Légumes - Insertion</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/insertion.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/types.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/categories.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/produits.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/stock.css">
  <script src="<%=request.getContextPath()%>/assets/admin/js/Vue.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Deconnexion.js"></script>
  <style>
    #ventesTable {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
    }

    #ventesTable th, #ventesTable td {
      border: 1px solid #ccc;
      padding: 10px;
      text-align: left;
    }

    #ventesTable th {
      background-color: #f5f5f5;
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
    <style>
        /* Style pour la pop-up */
        #message-popup {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px;
            background-color: #4CAF50; /* Couleur de fond */
            color: white; /* Couleur du texte */
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000; /* S'assurer que la pop-up est au-dessus des autres éléments */
            display: none; /* Caché par défaut */
        }
    </style>
    <script>
        // Fonction pour afficher la pop-up pendant 3 secondes
        function showPopup(message) {
            var popup = document.getElementById("message-popup");
            popup.innerText = message; // Définir le message
            popup.style.display = "block"; // Afficher la pop-up

            // Masquer la pop-up après 3 secondes
            setTimeout(function() {
                popup.style.display = "none";
            }, 3000); // 3000 millisecondes = 3 secondes
        }
    </script>
  </header>
  <%
  if (request.getSession().getAttribute("message") != null) {
      String message = (String) request.getSession().getAttribute("message");
      out.println("<script>showPopup('" + message + "');</script>"); // Afficher la pop-up avec JavaScript
      request.getSession().removeAttribute("message"); // Supprimer le message de la session
  }
    Types[] types = (Types[]) request.getAttribute("types");
    Categories[] categories = (Categories[]) request.getAttribute("categories");
    Saisons[] saisons = (Saisons[]) request.getAttribute("saisons");
    Produits[] produits = (Produits[]) request.getAttribute("produits");
    Stock[] stocks = (Stock[]) request.getAttribute("stocks");
    Promotions[] promos = (Promotions[]) request.getAttribute("promo");
  %>
  <div id="message-popup"></div>
  <main id="app">
    <section class="insertion-links">
      <ul>
        <li><a href="#" id="types-link">Types</a></li>
        <li><a href="#" id="categories-link">Catégories</a></li>
        <li><a href="#" id="produits-link">Produits</a></li>
        <li><a href="#" id="stock-link">Stock</a></li>
        <li><a href="#" id="promo-link">Promotions</a></li>
        <li><a href="#" id="prix-link">Prix</a></li>
      </ul>
    </section>
  
    <!-- Formulaire d'insertion de type -->
    <section class="form-container" id="type-form" style="display: none;">
      <h3>Ajouter un Type</h3>
      <form action="<%=request.getContextPath()%>/Insertion?action=Type" method="post">
        <input type="text" id="type-name" name="type-name" placeholder="Nom du type" required>
        <textarea id="type-description" name="type-description" placeholder="Description" required></textarea>
        <button type="submit">Insérer</button>
      </form>
      <br>
      <table id="ventesTable">
        <thead>
          <tr>
            <th>Id</th>
            <th>Type</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <% for(Types t: types){ %>
          <tr>
            <td><%=t.getid()%></td>
            <td><%=t.gettype()%></td>
            <td><%=t.getdescription()%></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </section>

    <!-- Formulaire d'insertion de catégorie -->
    <section class="form-container" id="category-form" style="display: none;">
      <h3>Ajouter une Catégorie</h3>
      <form action="<%=request.getContextPath()%>/Insertion?action=Categorie" method="post">
        <input type="text" id="category-name" name="category-name" placeholder="Nom de la catégorie" required>
        <select id="category-type" name="category-type" required>
          <%
            for(Types type: types){
          %>
          <option value="<%=type.getid()%>"><%=type.gettype()%></option>
          <%
            }
          %>
        </select>
        <textarea id="category-description" name="category-description" placeholder="Description" required></textarea>
        <button type="submit">Insérer</button>
      </form>
      <br>
      <table id="ventesTable">
        <thead>
          <tr>
            <th>id</th>
            <th>nom</th>
            <th>typeid</th>
            <th>description</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <% for(Categories c: categories){ %>
          <tr>
            <td><%=c.getid()%></td>
            <td><%=c.getnom()%></td>
            <td><%=c.gettypeid()%></td>
            <td><%=c.getdescription()%></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </section>

    <!-- Formulaire d'insertion de produit -->
    <section class="form-container" id="product-form" style="display: none;">
      <h3>Ajouter un Produit</h3>
      <form action="<%=request.getContextPath()%>/Insertion?action=Produits" method="post" enctype="multipart/form-data">
        <input type="text" id="product-name" name="product-name" placeholder="Nom du produit" required>
        <select id="product-category" name="product-category" required>
          <%
            for(Categories cat: categories){
          %>
          <option value="<%=cat.getid()%>"><%=cat.getnom()%></option>
          <%
            }
          %>
        </select>
        <select id="product-saison" name="product-saison" required>
          <%
            for(Saisons saison: saisons){
          %>
          <option value="<%=saison.getid()%>"><%=saison.getnom()%></option>
          <%
            }
          %>
        </select>
        <select id="product-unite" name="product-unite" required>
          <option value="kg">Kilogramme</option>
          <option value="u">Unite</option>
        </select>
        <textarea id="product-description" name="product-description" placeholder="Description" required></textarea>
        <input type="file" id="product-image" name="product-image" required>
        <button type="submit">Insérer</button>
      </form>
      <br>
      <table id="ventesTable">
        <thead>
          <tr>
            <th>Image</th>
            <th>Id</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Categorie</th>
            <th>Saison</th>
            <th>Date ajout</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <% for(Produits p: produits){ %>
          <tr>
            <td><img src="<%=p.getimageS()%>" alt="Fruits et Légumes" style="width: 40px; height: 40px;"></td>
            <td><%=p.getid()%></td>
            <td><%=p.getnom()%></td>
            <td><%=p.getdescription()%></td>
            <td><%=p.getCategorie().getnom()%></td>
            <td><%=p.getSaisons().getnom()%></td>
            <td><%=p.getdateajout()%></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </section>

    <!-- Formulaire d'insertion de stock -->
    <section class="form-container" id="stock-form" style="display: none;">
      <h3>Ajouter un Stock</h3>
      <form action="<%=request.getContextPath()%>/Insertion?action=Stock" method="post">
        <select id="stock-product" name="stock-product" required>
          <%
            for(Produits produit: produits){
          %>
          <option value="<%=produit.getid()%>"><%=produit.getnom()%></option>
          <%
            }
          %>
        </select>
        <select id="stock-mvt" name="stock-mvt" required>
          <option value="0">Entree</option>
          <option value="1">Sortie</option>
        </select>
        <input type="number" id="stock-quantity" name="stock-quantity" placeholder="Quantité" required>
        <input type="hidden" id="stock-price" name="stock-price" placeholder="Prix">
        <button type="submit">Insérer</button>
      </form>
      <br>
      <table id="ventesTable">
        <thead>
          <tr>
            <th>id</th>
            <th>produitid</th>
            <th>quantitedisponible</th>
            <th>prix</th>
            <th>dateajout</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <% for(Stock s: stocks){ %>
          <tr>
            <td><%=s.getid()%></td>
            <td><%=s.getproduitid()%></td>
            <td><%=s.getquantitedisponible()%></td>
            <td><%=s.getprix()%></td>
            <td><%=s.getdateajout()%></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </section>

  <!-- Formulaire d'insertion de Prix -->
  <section class="form-container" id="prix-form" style="display: none;">
    <h3>Ajouter Prix</h3>
    <form action="<%=request.getContextPath()%>/Insertion?action=Prix" method="post">
      <select id="prix-product" name="prix-product" required>
        <%
          for(Produits produit: produits){
        %>
        <option value="<%=produit.getid()%>"><%=produit.getnom()%></option>
        <%
          }
        %>
      </select>
      <input type="hidden" value="0" name="prix-mvt" id="prix-mvt">
      <input type="hidden" id="prix-quantity" name="prix-quantity" placeholder="Quantité" value="0">
      <input type="number" id="prix-price" name="prix-price" placeholder="Prix" required>
      <label for="prix-date">Sélectionnez une date :</label>
      <input type="date" id="prix-date" name="prix-date" required>
      <input type="hidden" id="timestamp" name="timestamp">
      <button type="submit">Insérer</button>
    </form>
  </section>

    <!-- Formulaire d'insertion de promotions -->
    <section class="form-container" id="promo-form" style="display: none;">
      <h3>Ajouter un Promotions</h3>
      <form action="<%=request.getContextPath()%>/Insertion?action=Promotion" method="post">
        <select id="promo-product" name="promo-product" required>
          <%
            for(Produits produit: produits){
          %>
          <option value="<%=produit.getid()%>"><%=produit.getnom()%></option>
          <%
            }
          %>
        </select>
        <input type="number" id="promo-pourcentage" name="promo-pourcentage" placeholder="pourcentage" required>
        <input type="date" id="promo-dateDebut" name="promo-dateDebut" placeholder="date promo" required>
        <input type="date" id="promo-dateFin" name="promo-dateFin" placeholder="date promo" required>
        <button type="submit">Insérer</button>
      </form>
      <br>
      <table id="ventesTable">
        <thead>
          <tr>
            <th>id</th>
            <th>produitid</th>
            <th>pourcentage</th>
            <th>debut</th>
            <th>fin</th>
          </tr>
        </thead>
        <tbody id="ventesTableBody">
          <% for(Promotions pr: promos){ %>
          <tr>
            <td><%=pr.getid()%></td>
            <td><%=pr.getproduitid()%></td>
            <td><%=pr.getpourcentage()%></td>
            <td><%=pr.getdebut()%></td>
            <td><%=pr.getfin()%></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </section>
  </main>
  <script>
    document.addEventListener("DOMContentLoaded", function() {
        let prixForm = document.querySelector("#prix-form form"); // Sélection du bon élément <form>

        prixForm.addEventListener("submit", function(event) {
            event.preventDefault();

            let dateInput = document.getElementById("prix-date").value;
            if (dateInput) {
                let timestampValue = new Date(dateInput).getTime(); // Obtenir le timestamp en millisecondes
                let sqlTimestamp = new Date(timestampValue).toISOString().replace("T", " ").split(".")[0]; // Formater en SQL Timestamp
                
                document.getElementById("timestamp").value = sqlTimestamp; // Mettre la valeur dans l'input caché
                
                console.log("Timestamp SQL:", sqlTimestamp); // Vérification dans la console
                
                // Envoyer le formulaire avec le timestamp
                this.submit();
            } else {
                alert("Veuillez sélectionner une date.");
            }
        });
    });

    </script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Types.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Categories.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Produits.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Stock.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Promotions.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Prix.js"></script>
</body>
</html>
