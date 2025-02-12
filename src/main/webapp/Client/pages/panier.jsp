<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classTable.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Panier</title>
  <link rel="stylesheet" href="assets/client/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="assets/client/css/global.css">
  <link rel="stylesheet" href="assets/client/css/panier.css">
  <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="assets/client/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/Accueil" class="active">Accueil</a></li>
        <li><a href="<%=request.getContextPath()%>/pages/commandes.jsp" class="active">Commandes</a></li>
        <li><a href="<%=request.getContextPath()%>/Panier" class="active">Panier</a></li>
        <li>
          <a href="<%=request.getContextPath()%>/pages/deconnexion.jsp" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="assets/client/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>
  
  <%
      HttpSession sess = request.getSession();
      Produits[] produits = (Produits[]) sess.getAttribute("panier");
      Remise remise = (Remise) request.getAttribute("remise");
      if (produits == null) {
          produits = new Produits[0];
      }
  %>

  <main id="app">
    <section class="panier">
      <div class="panier-top">
        <div>
          <span class="title">Mes Achats</span>
        </div>
        <div class="colonne">
          <form action="<%=request.getContextPath()%>/Panier" method="post">
            <input type="hidden" name="produits" id="produit-commande" value="">
            <input class="link" type="submit" value="Commander">
          </form>
          <form action="<%=request.getContextPath()%>/Panier?action=viderPanier" method="post">
            <input class="link" type="submit" value="Vider">
          </form>
        </div>
      </div>

      <div class="total">
        <!-- Affiche un message de réduction seulement si la remise existe et est applicable -->
        <h3 v-if="hasDiscount">
          Réduction de {{ remise.pourcentage }} % pour un total d'achat de {{ remise.seuil }} Ar
        </h3>
        <h3 v-else>Aucune réduction applicable mais Réduction de {{ remise.pourcentage }} % pour un total d'achat de {{ remise.seuil }} Ar </h3>

        <!-- Affichage conditionnel du prix original et du prix avec remise -->
        <div v-if="hasDiscount">
          <!-- Prix original souligné, en plus petit -->
          <p style="text-decoration: underline; font-size: 0.9rem; margin-bottom: 5px;">
            Prix avant remise : {{ originalTotal }} Ar
          </p>
          <!-- Prix total avec remise, en plus grand -->
          <p style="font-size: 1.2rem; font-weight: bold;">
            Total : {{ discountedTotal }} Ar
          </p>
        </div>
        <!-- Si aucune remise, on affiche juste le total normal -->
        <div v-else>
          <p style="font-size: 1.2rem;">
            Total : {{ originalTotal }} Ar
          </p>
        </div>
      </div>
    </section>

    <section class="produits">
      <div class="produits-list">
        <div v-if="produits.length === 0">Panier Vide</div>
        <div v-for="(produit, index) in produits" :key="index" class="produit-card">
          <div>
            <img :src="produit.image" :alt="produit.nom">
          </div>
          <div>
            <h3>{{ produit.nom }}</h3>
            <p>Prix : {{ produit.calculPrixPromo }} Ar</p>
            <p>Quantité disponible : {{ produit.stock }}</p>
            <div class="quantite">
              <button @click="modifierQuantite(index, -1)" class="moins">-</button>
              <input 
                type="number" 
                v-model.number="produit.quantite" 
                min="1" 
                :max="produit.stock" 
                @input="mettreAJourTotal"
              >
              <button @click="modifierQuantite(index, 1)" class="plus">+</button>
            </div>
          </div>
        </div>
      </div>
    </section>

  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>

  <script>
    new Vue({
      el: '#app',
      data: {
        produits: [
          <% for (Produits produit : produits) { %>
          {
            id: <%= produit.getid() %>,
            nom: "<%= produit.getnom() %>",
            image: "<%= produit.getimageS() %>",
            calculPrixPromo: <%= produit.calculPrixPromo() %>,
            quantite: <%= produit.getQtt() %>,
            stock: <%= produit.getStock().getstockrestant() %>
          },
          <% } %>
        ],
        remise: {
          pourcentage: <%= remise != null ? remise.getpourcentage() : 0 %>,
          seuil: <%= remise != null ? remise.getprixatteint() : 0 %>
        }
      },
      computed: {
        // Calcul du total sans remise
        originalTotal() {
          let sum = 0;
          this.produits.forEach(produit => {
            sum += produit.calculPrixPromo * produit.quantite;
          });
          // On pourrait formatNumber, mais on renvoie juste la valeur
          return sum.toFixed(2);
        },
        // Test si la remise est applicable
        hasDiscount() {
          return (
            parseFloat(this.originalTotal) >= this.remise.seuil &&
            this.remise.pourcentage > 0
          );
        },
        // Calcul du total avec remise
        discountedTotal() {
          let totalSansRemise = parseFloat(this.originalTotal);
          if (this.hasDiscount) {
            const reduction = (this.remise.pourcentage / 100) * totalSansRemise;
            return (totalSansRemise - reduction).toFixed(2);
          }
          return totalSansRemise.toFixed(2);
        }
      },
      methods: {
        modifierQuantite(index, valeur) {
          const produit = this.produits[index];
          const nouvelleQuantite = produit.quantite + valeur;
          if (nouvelleQuantite >= 1 && nouvelleQuantite <= produit.stock) {
            produit.quantite = nouvelleQuantite;
            this.mettreAJourTotal();
          }
        },
        mettreAJourTotal() {
          this.commander();
        },
        commander() {
          // Récupère les infos sous forme JSON pour envoi
          const panier = this.produits.map(produit => ({
            idProduit: produit.id,
            quantite: produit.quantite
          }));
          const element = document.getElementById("produit-commande");
          element.value = JSON.stringify(panier);
          // Soumet le formulaire après avoir injecté la valeur
          console.log(element.value);
        }
      }
    });
  </script>
</body>
</html>
