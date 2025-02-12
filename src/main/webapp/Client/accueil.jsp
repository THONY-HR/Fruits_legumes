<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classTable.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fruits et Légumes - Accueil</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/accueil.css">
  <script src="<%=request.getContextPath()%>/js/Vue.js"></script>
  <script src="<%=request.getContextPath()%>/js/Deconnexion.js"></script>
  <script>
    document.addEventListener("DOMContentLoaded", () => {
        const selectCategorie = document.querySelector("select[name='categorie']"); // Sélection pour catégories
        const selectSaison = document.querySelector("select[name='saison']"); // Sélection pour saisons
        const produits = document.querySelectorAll(".produit-card"); // Tous les produits

        // Fonction pour appliquer les filtres
        function filtrerProduits() {
            const categorieSelectionnee = selectCategorie.value; // Catégorie sélectionnée
            const saisonSelectionnee = selectSaison.value;       // Saison sélectionnée

            produits.forEach(produit => {
                const idCategorie = produit.getAttribute("data-categorie"); // ID catégorie du produit
                const idSaison = produit.getAttribute("data-saison");       // ID saison du produit

                // Vérifie si le produit correspond aux filtres sélectionnés
                const correspondCategorie = categorieSelectionnee === "" || idCategorie === categorieSelectionnee;
                const correspondSaison = saisonSelectionnee === "" || idSaison === saisonSelectionnee;

                if (correspondCategorie && correspondSaison) {
                    produit.style.display = "block"; // Affiche le produit
                } else {
                    produit.style.display = "none"; // Cache le produit
                }
            });
        }

        // Ajoute un écouteur sur les changements de sélection
        selectCategorie.addEventListener("change", filtrerProduits);
        selectSaison.addEventListener("change", filtrerProduits);
    });

  </script>
  </head>
<body>
  <header>
    <div class="logo">
      <img src="<%=request.getContextPath()%>/assets/client/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/Accueil" class="active">Accueil</a></li>
        <li><a href="<%=request.getContextPath()%>/Commande" class="active">Commandes</a></li>
        <li><a href="<%=request.getContextPath()%>/Panier"  class="active">Panier</a></li>
        <li>
          <a href="pages/deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="assets/client/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <main id="app">
        <section class="banniere">
          <div class="contenu-banniere">

            <div class="partie1">
               <div class="image-banniere">
                  <img src="<%=request.getContextPath()%>/assets/client/images/background/image2.jpg" alt="Bienvenue">
              </div>
            </div>

            <div class="partie2">
              <div class="texte-banniere">
                <h3>Bienvenue sur notre site de fruits et légumes frais !</h3>
                <p>Découvrez nos produits de saison et profitez de nos promotions exclusives.</p>
                <a href="#catalogue" class="btn-banniere">Découvrir</a>
            </div>

        </section>
        <%
        if (request.getAttribute("message") != null) {
          String message = (String) request.getAttribute("message");
          out.print("<h5>" + message + "</h5>");
        }
      
          Produits[] produits = (Produits[]) request.getAttribute("produits");
          Categories[] categories = (Categories[]) request.getAttribute("categories");
          Saisons[] saisons = (Saisons[]) request.getAttribute("saisons");
        %>
        <section id="catalogue" class="catalogue">
          <h1>Catalogue de Produits</h1>
          <div class="filtre">
            <label for="categorie">Catégorie :</label>
            <select name="categorie">
                <option value="">Tous</option>
                <%
                    for(Categories cat : categories) {
                %>
                <option value="<%=cat.getid()%>"><%=cat.getnom()%></option>
                <%
                    }
                %>
            </select>

            <label for="saison">Saisons :</label>
            <select name="saison">
                <option value="">Tous</option>
                <%
                    for(Saisons sai : saisons) {
                %>
                <option value="<%=sai.getid()%>"><%=sai.getnom()%></option>
                <%
                    }
                %>
            </select>

          </div>
          <div class="produits-list">
            <%
              for(Produits produit : produits) {
            %>
            <div class="produit-card" data-categorie="<%=produit.getcategorieid()%>" data-saison="<%=produit.getsaisonid()%>">
              <!-- <img src="<%=request.getContextPath()%>/assets/client/images/fruits/abricot.jpg" alt="Abricot"> -->
              <img src="<%=produit.getimageS()%>" alt="<%=produit.getnom()%>">
              <h3><%=produit.getnom()%></h3>
              <p><%=produit.getdescription()%></p>
              <%
                if(produit.getStock().getstockrestant() != 0){
                  if(produit.verifProm()){
                    %><span style="text-decoration: line-through;"><%=produit.getprix()%> Ar</span><%
                  }else{
                    %><h5>Prix : <%=produit.getprix()%> Ar</h5><%
                  }
                  %>
                    <%
                      if(produit.verifProm()){
                        %><span><%="-" + produit.getPromotions().getpourcentage()%>%</span><br><%
                        %><h5>Promotions : <%=produit.calculPrixPromo()%> Ar</h5><br><%
                        %><span>Fin promo : <%=produit.getPromotions().getfin()%></span><%
                      }
                    %>
                    <form action="<%=request.getContextPath() %>/Accueil" method="post">
                      <input type="hidden" name="produitid" value="<%= produit.getid() %>">
                      <button type="submit">Ajouter au Panier</button>
                    </form>
                  <%
                }else{
                  out.print("<h5>Bientôt disponible</h5>");
                }
              %>
            </div>
            <%
              }
            %>
          </div>
        </section>
  </main>
  <script src="js/Index.js"></script>
  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>
</body>
</html>