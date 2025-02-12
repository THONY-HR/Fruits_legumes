<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Paiement</title>
  <link rel="stylesheet" href="assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="assets/css/global.css">
  <link rel="stylesheet" href="assets/css/paiement.css">
  <script src="js/Vue.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="assets/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/Accueil" class="active">Accueil</a></li>
        <li><a href="<%=request.getContextPath()%>/pages/commandes.jsp" class="active">Commandes</a></li>
        <li><a href="<%=request.getContextPath()%>/Panier" class="active">Panier</a></li>
        <li>
          <a href="<%=request.getContextPath()%>/pages/deconnexion.jsp" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="assets/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <main id="app">
    <section class="formulaire-paiement">
      <h1>Méthode de Paiement</h1>
      <div class="method-selection">
        <div class="method-card" v-for="method in methods" :key="method.id">
          <div><img :src="method.logo" :alt="method.name" class="payment-logo"></div>
          <div class="radio-group">
            <input type="radio" :id="method.id" v-model="selectedMethod" :value="method.name">
            <label :for="method.id">{{ method.name }}</label>
          </div>
        </div>
      </div>
      <a  class="validation" href="<%=request.getContextPath()%>/pages/ajouterProduits.jsp">Valider</a>
    </section>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>

  <script src="js/Paiement.js"></script>
</body>
</html>
