new Vue({
    el: '#app',
    data: {
      categorie: '',
      produits: [
        // Fruits
        {
          id: 1,
          nom: 'Pomme',
          description: 'Délicieuse et croquante.',
          prix: 500,
          image: '../assets/images/fruits/pomme.jpg',
          categorie: 'fruits'
        },
        {
          id: 2,
          nom: 'Banane',
          description: 'Sucrée et riche en potassium.',
          prix: 2000,
          image: '../assets/images/fruits/banane.jpg',
          categorie: 'fruits'
        },
        {
          id: 5,
          nom: 'Orange',
          description: 'Acidulée et pleine de vitamine C.',
          prix: 1000,
          image: '../assets/images/fruits/orange.jpg',
          categorie: 'fruits'
        },
        {
          id: 6,
          nom: 'Fraise',
          description: 'Sucrée et parfumée.',
          prix: 500,
          image: '../assets/images/fruits/fraise.jpg',
          categorie: 'fruits'
        },
        {
          id: 9,
          nom: 'Mangue',
          description: 'Tropicale et juteuse.',
          prix: 800,
          image: '../assets/images/fruits/mangue.jpg',
          categorie: 'fruits'
        },
  
        // Légumes
        {
          id: 3,
          nom: 'Carotte',
          description: 'Riche en vitamines.',
          prix: 1000,
          image: '../assets/images/légumes/carotte.jpg',
          categorie: 'legumes'
        },
        {
          id: 4,
          nom: 'Tomate',
          description: 'Juteuse et parfaite pour vos salades.',
          prix: 500,
          image: '../assets/images/légumes/tomate.jpg',
          categorie: 'legumes'
        },
        {
          id: 7,
          nom: 'Courgette',
          description: 'Légère et douce, idéale pour les plats d’été.',
          prix: 1000,
          image: '../assets/images/légumes/courgette.jpg',
          categorie: 'legumes'
        },
        {
          id: 8,
          nom: 'Poivron',
          description: 'Croquant et sucré, parfait pour vos recettes.',
          prix: 200,
          image: '../assets/images/légumes/poivron.jpg',
          categorie: 'legumes'
        },
        {
          id: 10,
          nom: 'Épinard',
          description: 'Riche en fer et parfait pour les soupes.',
          prix: 500,
          image: '../assets/images/légumes/épinard.jpg',
          categorie: 'legumes'
        }
      ]
    },
    computed: {
        produitsFiltres() {
          if (this.categorie) {
            return this.produits.filter(produit => produit.categorie === this.categorie);
          }
          return this.produits;
        }
      },

    methods: {
      ajouterAuPanier(id) {
        alert('Produit ajouté au panier : ' + id);
      }
    }
  });
  