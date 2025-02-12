<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inscription</title>
  <link rel="stylesheet" href="assets/client/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="assets/client/css/global.css">
  <link rel="stylesheet" href="assets/client/css/connexion.css">
  <script src="assets/client/js/Vue.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="assets/client/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
        <ul>
            <li><a href="accueil.html" class="active">Accueil</a></li>
            <li><a href="commandes.html"  class="active">Commandes</a></li>
            <li><a href="panier.html"  class="active">Panier</a></li>
          </ul>
    </nav>
  </header>

  <main>
    <section class="formulaire-connexion">
      <a href="<%=request.getContextPath()%>/AccueilAdmin">Admin</a>
      <form action="<%=request.getContextPath()%>/Connexion" method="POST">
        <div class="form-group">
          <label for="email">Email :</label>
          <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
          <label for="mot_de_passe">Mot de passe :</label>
          <input type="password" id="mot_de_passe" name="mdp" required>
        </div>
        <input type="submit" value="Se connecter">
      </form>
    </section>
  </main>
</body>
</html>
