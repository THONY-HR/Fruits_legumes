document.getElementById('categories-link').addEventListener('click', function(event) {
    event.preventDefault();
    var categoryForm = document.getElementById('category-form');
    var typeForm = document.getElementById('type-form');
    var productForm = document.getElementById('product-form');
    var stockForm = document.getElementById('stock-form');
    var prixForm = document.getElementById('prix-form');
    
    typeForm.style.display = 'none';
    productForm.style.display = 'none';
    stockForm.style.display = 'none';
    prixForm.style.display = 'none';
    
    categoryForm.style.display = 'block';
  });
  