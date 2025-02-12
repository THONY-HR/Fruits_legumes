<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Avis des Clients</title>
  <link rel="stylesheet" href="../assets/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="../assets/css/global.css">
  <link rel="stylesheet" href="../assets/css/avis.css">
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
    <section class="avis-clients">
      <h1>Avis des Clients</h1>
      <div v-for="avis in avisList" :key="avis.id" class="avis-item">
        <h3>avis.nom_utilisateur  (avis.date)</h3>
        <p>Note : avis.note/5</p>
        <p>avis.commentaire</p>
      </div>

      <div>
        <h3>Ajouter un Avis</h3>
        <form @submit.prevent="ajouterAvis">
          <div class="form-group">
            <label for="note">Note (1 à 5) :</label>
            <input type="number" id="note" v-model="nouveauAvis.note" min="1" max="5" required>
          </div>
          <div class="form-group">
            <label for="commentaire">Commentaire :</label>
            <textarea id="commentaire" v-model="nouveauAvis.commentaire" required></textarea>
          </div>
          <button type="submit">Envoyer</button>
        </form>
      </div>
    </section>
  </main>

  <footer>
    <p>&copy; 2025 Fruits et Légumes - Tous droits réservés</p>
  </footer>
</body>
</html>
