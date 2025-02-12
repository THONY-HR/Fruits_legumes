new Vue({
    el: '#app',
    data: {
      avisList: [
        { id: 1, nom_utilisateur: 'Jean', date: '2025-01-01', note: 5, commentaire: 'Très bons produits!' },
        { id: 2, nom_utilisateur: 'Marie', date: '2025-01-02', note: 4, commentaire: 'Très frais, mais un peu cher.' }
      ],
      nouveauAvis: { note: '', commentaire: '' }
    },
    methods: {
      ajouterAvis() {
        const nouveau = { 
          id: this.avisList.length + 1, 
          nom_utilisateur: 'Utilisateur Anonyme', 
          date: new Date().toLocaleDateString(), 
          note: this.nouveauAvis.note, 
          commentaire: this.nouveauAvis.commentaire 
        };
        this.avisList.push(nouveau);
        this.nouveauAvis.note = '';
        this.nouveauAvis.commentaire = '';
      }
    }
  });
  