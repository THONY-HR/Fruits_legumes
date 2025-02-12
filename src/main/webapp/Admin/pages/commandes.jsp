<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historique des Commandes</title>
  <link rel="stylesheet" href="../assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="../assets/css/global.css">
  <link rel="stylesheet" href="../assets/css/commande.css">
  <script src="../js/Vue.js"></script>
  <script src="../js/Deconnexion.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="../assets/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="../index.html" class="active">Dashboard</a></li>
        <li><a href="insertion.html"  class="active">Insertion</a></li>
        <li><a href="commandes.html"  class="active">Commandes</a></li>
        <li><a href="livraisons.html"  class="active">Livraisons</a></li>
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
    <h1>Liste des Commandes</h1>
    <section class="historique-commandes">
      <div class="commandes-container">
        <div v-for="commande in commandes" :key="commande.id" class="commande-item">
          <h3>Commande Numéro : {{ commande.numero }}</h3>
          <p>Date : {{ commande.date }}</p>
          <p>Statut : {{ commande.statut }}</p>
          <p class="total">Total dû : {{ commande.total }} Ar</p>
        </div>
      </div>
    </section>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>

  <script src="../js/Commandes.js"></script>

</body>
</html>
