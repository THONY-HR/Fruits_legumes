// Fonction pour afficher le popup
function showPopup() {
    const popup = document.getElementById('popup');
    popup.style.display = 'flex'; // Afficher le popup
  }
  
  // Fonction pour fermer le popup
  function closePopup() {
    const popup = document.getElementById('popup');
    popup.style.display = 'none'; // Masquer le popup
  }
  
  // Fonction de déconnexion (ajustez la redirection si nécessaire)
  function logout() {
    window.location.href = 'deconnexion.html'; // Rediriger vers la page de déconnexion
  }
  