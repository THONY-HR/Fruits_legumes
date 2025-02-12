<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inscription</title>
  <link rel="stylesheet" href="../assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="../assets/css/global.css">
  <link rel="stylesheet" href="../assets/css/inscription.css">
  <script src="../js/Vue.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="../assets/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="../index.html" class="active">Accueil</a></li>
        <li><a href="commandes.html"  class="active">Commandes</a></li>
        <li><a href="panier.html"  class="active">Panier</a></li>
        <li>
          <a href="deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="../assets/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <main>
    <section class="formulaire-inscription">
      <h1>Inscription</h1>
      <form action="inscriptionServlet" method="POST">
        <div class="form-group">
          <label for="nom">Nom :</label>
          <input type="text" id="nom" name="nom" required>
        </div>
        <div class="form-group">
          <label for="email">Email :</label>
          <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
          <label for="mot_de_passe">Mot de passe :</label>
          <input type="password" id="mot_de_passe" name="mot_de_passe" required>
        </div>
        <div class="form-group">
            <label for="mot_de_passe">Confirmation du mot de passe :</label>
            <input type="password" id="mot_de_passe" name="mot_de_passe" required>
        </div>
        <div class="form-group">
          <label for="telephone">Téléphone :</label>
          <input type="tel" id="telephone" name="telephone" required>
        </div>
        <button type="submit">S'inscrire</button>
      </form>
    </section>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>
</body>
</html>
