document.getElementById('prix-link').addEventListener('click', function(event) {
    event.preventDefault(); 
    var stockForm = document.getElementById('stock-form');
    var typeForm = document.getElementById('type-form');
    var categoryForm = document.getElementById('category-form');
    var productForm = document.getElementById('product-form');
    var promoForm = document.getElementById('promo-form');
    var prixForm = document.getElementById('prix-form');
    
    typeForm.style.display = 'none';
    categoryForm.style.display = 'none';
    productForm.style.display = 'none';
    promoForm.style.display = 'none';
    stockForm.style.display = 'none';

    prixForm.style.display = 'block';
  });
  