document.getElementById('types-link').addEventListener('click', function(event) {
    event.preventDefault();
    var typeForm = document.getElementById('type-form');
    var categoryForm = document.getElementById('category-form');
    var productForm = document.getElementById('product-form');
    var stockForm = document.getElementById('stock-form');
    var promoForm = document.getElementById('promo-form');
    
    categoryForm.style.display = 'none';
    productForm.style.display = 'none';
    stockForm.style.display = 'none';
    promoForm.style.display = 'none';
    
    if (typeForm.style.display === 'none' || typeForm.style.display === '') {
      typeForm.style.display = 'block';
    } else {
      typeForm.style.display = 'none';
    }
  });
  