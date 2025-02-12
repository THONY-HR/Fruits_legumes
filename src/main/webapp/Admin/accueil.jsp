<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fruits et Légumes - Accueil</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/index.css">
  <script src="<%=request.getContextPath()%>/assets/admin/assets/admin/js/Vue.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Deconnexion.js"></script>
</head>
<body>
  <header>
    <div class="logo">
      <img src="<%=request.getContextPath()%>/assets/admin/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/AccueilAdmin" class="active">Dashboard</a></li>
        <li><a href="<%=request.getContextPath()%>/Insertion"  class="active">Insertion</a></li>
        <li><a href="<%=request.getContextPath()%>/Vente"  class="active">Vente</a></li>
        <li><a href="<%=request.getContextPath()%>/HistoriquePrix"  class="active">Historique Prix</a></li>
        <li>
          <a href="pages/deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="<%=request.getContextPath()%>/assets/admin/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
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
                  <img src="<%=request.getContextPath()%>/assets/admin/images/background/image6.jpg" alt="Bienvenue">
              </div>
            </div>
            <div class="partie2">
              <div class="texte-banniere">
                <h3>Bienvenue sur le site d'Administrateur!</h3>
            </div>
        </section>
  </main>
</body>
</html>