<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classTable.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historique des Commandes</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/client/css/commande.css">
  <script src="js/vue.js"></script>
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
        <li><a href="<%=request.getContextPath()%>/Panier" class="active">Panier</a></li>
        <li>
          <a href="deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="<%=request.getContextPath()%>/assets/client/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <main id="app">
    <h1>Liste des Commandes</h1>
    <section class="historique-commandes">
      <div class="commandes-container">
        <%
          Commandes[] commandes = (Commandes[]) request.getAttribute("commandes");
          if(commandes.length > 0){
            for(Commandes c: commandes){
        %>
          <div class="commande-item">
            <h3>Commande Numéro : <%=c.getid()%></h3>
            <p>Date : <%=c.getdatecommande()%></p>
            <p>Statut : <%=c.getstatut()%></p>
            <p class="total">Total dû : <%=c.gettotal()%> Ar</p>
          </div>
        <%
            }
          }else{
            out.println("Commande vide");
          }
        %>
      </div>
    </section>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>

  <script src="<%=request.getContextPath()%>/assets/client/js/Commandes.js"></script>

</body>
</html>
