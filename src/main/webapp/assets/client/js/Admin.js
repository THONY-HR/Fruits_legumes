new Vue({
    el: '#app',
    data: {
      produits: [
        { id: 1, nom: 'Pomme', prix: 2.5 },
        { id: 2, nom: 'Carotte', prix: 1.8 }
      ],
      commandes: [
        { id: 1, date: '2025-01-01', statut: 'Expédiée' },
        { id: 2, date: '2025-01-02', statut: 'En attente' }
      ]
    },
    methods: {
      ajouterProduit() {
        alert('Ajouter un nouveau produit');
      },
      modifierProduit(id) {
        alert('Modifier le produit avec l\'ID ' + id);
      },
      supprimerProduit(id) {
        this.produits = this.produits.filter(produit => produit.id !== id);
      },
      mettreAJourStatut(id) {
        alert('Mettre à jour le statut de la commande ' + id);
      }
    }
  });
  