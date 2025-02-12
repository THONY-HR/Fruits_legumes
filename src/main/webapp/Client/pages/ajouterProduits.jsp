<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nos Produits</title>
  <link rel="stylesheet" href="../assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="../assets/css/global.css">
  <link rel="stylesheet" href="../assets/css/ajoutProd.css">
  <script src="../js/Vue.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="../assets/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/Accueil" class="active">Accueil</a></li>
        <li><a href="<%=request.getContextPath()%>/pages/commandes.html" class="active">Commandes</a></li>
        <li><a href="<%=request.getContextPath()%>/Panier" class="active">Panier</a></li>
        <li>
          <a href="deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="../assets/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <main id="app">
    <div class="container">
        <div class="texte">
          <h3>Votre Panier est vide</h3>
          <a href="../index.html" class="btn">Ajouter</a>
        </div>
    </div>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>

  <script src="../js/Produits.js"></script>
</body>
</html>
