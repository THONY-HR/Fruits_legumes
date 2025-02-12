<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Deconnexion</title>
  <link rel="stylesheet" href="assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="assets/css/global.css">
  <link rel="stylesheet" href="assets/css/deconnexion.css">
  <script src="js/Vue.js"></script>
  <script src="js/Deconnexion.js"></script>
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

  <main>
    <div id="popup" class="popup">
      <div class="popup-content">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <div class="person-info">
          <img id="person-image" src="assets/images/persons/2.jpg" alt="Photo" class="person-photo">
          <p><strong>ID :</strong> 12345</p>
          <p><strong>Nom Complet :</strong> Jean Rakoto</p>
          <p><strong>Email :</strong> jean.rakoto@example.com</p>
          <p><strong>Mot de Passe :</strong> ********</p>
          <p><strong>Téléphone :</strong> +261 34 56 78 90</p>
          <p><strong>Date d'Inscription :</strong> 2024-05-12</p>
          <button onclick="logout()">Se déconnecter</button>
        </div>
      </div>
    </div>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>
 
</body>
</html>
