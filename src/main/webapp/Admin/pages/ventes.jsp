<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="classView.Vente" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Fruits et Légumes - Vente</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/fonts.css?v=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/global.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/admin/css/index.css">
  
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Vue.js"></script>
  <script src="<%=request.getContextPath()%>/assets/admin/js/Deconnexion.js"></script>
  
  <!-- STYLE SPÉCIFIQUE -->
  <style>
    /* --- Mise en page générale pour la partie main --- */
    main {
      padding: 20px;
      max-width: 1400px; /* Largeur max plus importante si besoin */
      margin: 0 auto;
    }

    .filters {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      margin-bottom: 20px;
      gap: 20px;
    }

    .filters > div {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .filters label {
      font-weight: bold;
    }

    .filters select {
      padding: 5px;
      font-size: 1rem;
      min-width: 120px;
    }

    /* Conteneurs cachés par défaut pour mois, trimestre, semestre, année */
    #monthContainer,
    #quarterContainer,
    #semesterContainer,
    #yearContainer {
      display: none;
    }

    /* Tableau */
    #ventesTable {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
    }

    #ventesTable th, #ventesTable td {
      border: 1px solid #ccc;
      padding: 10px;
      text-align: left;
    }

    #ventesTable th {
      background-color: #f5f5f5;
    }

    /* Container des graphiques */
    .charts-section {
      display: flex;
      flex-wrap: wrap;
      gap: 40px; /* espace entre les différents graphiques */
      justify-content: center; /* centrage horizontal */
    }

    .chart-container {
      width: 400px; /* Largeur d'un graphique */
      max-width: 100%;
      margin-bottom: 30px;
    }

    /* Ajustement si vous souhaitez plus grand */
    /* .chart-container { width: 600px; } */
  </style>
</head>

<body>
  <!-- HEADER / NAVIGATION -->
  <header>
    <div class="logo">
      <img src="<%=request.getContextPath()%>/assets/admin/images/logo/logo.png" alt="Fruits et Légumes">
    </div>
    <nav>
      <ul>
        <li><a href="<%=request.getContextPath()%>/AccueilAdmin" class="active">Dashboard</a></li>
        <li><a href="<%=request.getContextPath()%>/Insertion" class="active">Insertion</a></li>
        <li><a href="<%=request.getContextPath()%>/Vente" class="active">Vente</a></li>
        <li><a href="<%=request.getContextPath()%>/HistoriquePrix" class="active">Historique Prix</a></li>
        <li>
          <a href="pages/deconnexion.html" class="person-link">
            <span class="person-name">Jean Rakoto</span>
            <img src="<%=request.getContextPath()%>/assets/admin/images/persons/2.jpg" alt="Jean Rakoto" class="person-image">
          </a>
        </li>
      </ul>
    </nav>
  </header>

  <!-- MAIN CONTENT -->
  <main>
    <%
      // Récupération des données de vente depuis le contrôleur
      Vente[] ventes = (Vente[]) request.getAttribute("ventes");

      // Pour la démo, on pourrait aussi simuler quelques années, si non fournies côté serveur.
      // On suppose que ventes[i].getdatevente() => "yyyy-mm-dd"
      // Ex: "2023-01-10", "2023-02-15", "2024-01-05", etc.
    %>

    <h1>Liste des Ventes</h1>

    <!-- Zone de filtres -->
    <div class="filters">
      <!-- Filtre par période -->
      <div>
        <label for="filterPeriod">Période :</label>
        <select id="filterPeriod" onchange="onPeriodChange()">
            <option value="all">Toutes</option>
            <option value="month">Mois</option>
            <option value="quarter">Trimestre</option>
            <option value="semester">Semestre</option>
            <option value="year">Année</option>
            <option value="avance">Avancé</option>
          </select>          
      </div>

    <!-- Conteneur des dates pour le filtre avancé -->
    <div id="advancedDateFilter" style="display: none; margin-top: 20px;">
        <label for="startDate">Date de début :</label>
        <input type="date" id="startDate" onchange="applyFilters()">
    
        <label for="endDate">Date de fin :</label>
        <input type="date" id="endDate" onchange="applyFilters()">
    </div>
  

      <!-- Sélecteur du mois (1 à 12) -->
      <div id="monthContainer">
        <label for="filterMonth">Mois :</label>
        <select id="filterMonth" onchange="applyFilters()">
          <option value="1">Janvier</option>
          <option value="2">Février</option>
          <option value="3">Mars</option>
          <option value="4">Avril</option>
          <option value="5">Mai</option>
          <option value="6">Juin</option>
          <option value="7">Juillet</option>
          <option value="8">Août</option>
          <option value="9">Septembre</option>
          <option value="10">Octobre</option>
          <option value="11">Novembre</option>
          <option value="12">Décembre</option>
        </select>
      </div>

      <!-- Sélecteur de trimestre (1 à 4) -->
      <div id="quarterContainer">
        <label for="filterQuarter">Trimestre :</label>
        <select id="filterQuarter" onchange="applyFilters()">
          <option value="1">T1 (Jan-Mars)</option>
          <option value="2">T2 (Avr-Juin)</option>
          <option value="3">T3 (Juil-Sep)</option>
          <option value="4">T4 (Oct-Déc)</option>
        </select>
      </div>

      <!-- Sélecteur de semestre (1 ou 2) -->
      <div id="semesterContainer">
        <label for="filterSemester">Semestre :</label>
        <select id="filterSemester" onchange="applyFilters()">
          <option value="1">S1 (Jan-Juin)</option>
          <option value="2">S2 (Juil-Déc)</option>
        </select>
      </div>

      <!-- Sélecteur d'année -->
      <div id="yearContainer">
        <label for="filterYear">Année :</label>
        <select id="filterYear" onchange="applyFilters()">
          <!-- On va construire dynamiquement la liste des années détectées dans 'ventesList' en JS. -->
        </select>
      </div>

      <!-- Filtre par produit -->
      <div>
        <label for="filterProduct">Produit :</label>
        <select id="filterProduct" onchange="applyFilters()">
          <option value="all">Tous</option>
          <!-- Options dynamiques en JS pour éviter les doublons -->
        </select>
      </div>
    </div>

    <!-- Tableau des ventes -->
    <table id="ventesTable">
      <thead>
        <tr>
          <th>Date Vente</th>
          <th>Produit</th>
          <th>Quantité Vendue</th>
          <th>Total Vente (Ar)</th>
          <th>Nombre de Commandes</th>
        </tr>
      </thead>
      <tbody id="ventesTableBody">
        <!-- Contenu mis à jour dynamiquement en JS -->
      </tbody>
    </table>
    <!-- Pagination -->
    <div id="pagination" style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
        <button id="prevPage" onclick="changePage(-1)" disabled>Précédent</button>
        <span id="pageIndicator">Page 1</span>
        <button id="nextPage" onclick="changePage(1)">Suivant</button>
    </div>
  

    <!-- Section des graphiques -->
    <div class="charts-section">
      <!-- Graphique en barres : Total des ventes par date -->
      <div class="chart-container">
        <canvas id="barChart"></canvas>
      </div>

      <!-- Graphique en ligne : Quantité vendue par date -->
      <div class="chart-container">
        <canvas id="lineChart"></canvas>
      </div>

      <!-- Graphique donut : répartition des ventes par produit -->
      <div class="chart-container">
        <canvas id="doughnutChart"></canvas>
      </div>
    </div>

    <!-- SCRIPT DE GESTION DES DONNÉES ET GRAPHIQUES -->
    <script>
      /********************************************************
       * 1. Récupération et préparation des données côté JSP
       ********************************************************/
      let ventesList = [];
      <% if (ventes != null && ventes.length > 0) { %>
        ventesList = [
          <% for (int i = 0; i < ventes.length; i++) {
               Vente v = ventes[i];
               // Format string pour date => "YYYY-MM-DD"
               String dateVenteStr = v.getdatevente().toString(); // ex: "2023-01-15"
          %>
            {
              dateVente: "<%=dateVenteStr%>",
              produitId: <%= v.getproduitid() %>,
              produitNom: "<%= v.getproduitnom() %>",
              totalVente: <%= v.gettotalvente() %>,
              totalQuantite: <%= v.gettotalquantite() %>,
              nombreCommandes: <%= v.getnombrecommandes() %>
            }<%= (i < ventes.length - 1) ? "," : "" %>
          <% } %>
        ];
      <% } %>

      /*****************************************************************
       * 2. Préparer dynamiquement :
       *     - la liste de produits (filterProduct)
       *     - la liste des années disponibles (filterYear)
       *****************************************************************/
      const productSelect = document.getElementById("filterProduct");
      const yearSelect = document.getElementById("filterYear");

      function populateFilters() {
        // 2.1 Produits : collecter distinct produitId / produitNom
        const produitsMap = new Map(); // clé = produitId, valeur = produitNom
        ventesList.forEach(v => {
          if (!produitsMap.has(v.produitId)) {
            produitsMap.set(v.produitId, v.produitNom);
          }
        });
        // Ajouter au select
        productSelect.innerHTML = '<option value="all">Tous</option>';
        for (let [pid, pnom] of produitsMap) {
          const opt = document.createElement('option');
          opt.value = pid;
          opt.textContent = pnom;
          productSelect.appendChild(opt);
        }

        // 2.2 Années : extraire l'année depuis v.dateVente => "YYYY-MM-DD"
        const yearSet = new Set();
        ventesList.forEach(v => {
          const year = v.dateVente.split('-')[0];
          yearSet.add(year);
        });

        // trier les années
        const sortedYears = Array.from(yearSet).sort();
        // Ajouter au select
        yearSelect.innerHTML = '';
        sortedYears.forEach(y => {
          const opt = document.createElement('option');
          opt.value = y;
          opt.textContent = y;
          yearSelect.appendChild(opt);
        });
      }

      /**********************************************
       * 3. Gestion de l'affichage conditionnel
       *    des sélecteurs (mois, trimestre, semestre, année)
       **********************************************/
      const monthContainer = document.getElementById("monthContainer");
      const quarterContainer = document.getElementById("quarterContainer");
      const semesterContainer = document.getElementById("semesterContainer");
      const yearContainer = document.getElementById("yearContainer");

      function onPeriodChange() {
  const period = document.getElementById('filterPeriod').value;

  // Masquer tous les conteneurs au départ
  monthContainer.style.display = 'none';
  quarterContainer.style.display = 'none';
  semesterContainer.style.display = 'none';
  yearContainer.style.display = 'none';
  document.getElementById('advancedDateFilter').style.display = 'none';

  // Afficher uniquement le conteneur correspondant
  switch (period) {
    case 'month':
      monthContainer.style.display = 'inline-flex';
      yearContainer.style.display = 'inline-flex';
      break;
    case 'quarter':
      quarterContainer.style.display = 'inline-flex';
      yearContainer.style.display = 'inline-flex';
      break;
    case 'semester':
      semesterContainer.style.display = 'inline-flex';
      yearContainer.style.display = 'inline-flex';
      break;
    case 'year':
      yearContainer.style.display = 'inline-flex';
      break;
    case 'avance':
      document.getElementById('advancedDateFilter').style.display = 'block';
      break;
    case 'all':
    default:
      // Pas de filtre supplémentaire pour "Toutes"
      break;
  }

  // Appliquer les filtres pour afficher les résultats
  applyFilters();
}


      /**********************************************
       * 4. Filtrage principal
       **********************************************/
       function applyFilters() {
        const period = document.getElementById('filterPeriod').value;
        const productId = document.getElementById('filterProduct').value;

        const monthValue = document.getElementById('filterMonth').value; // 1..12
        const quarterValue = document.getElementById('filterQuarter').value; // 1..4
        const semesterValue = document.getElementById('filterSemester').value; // 1..2
        const yearValue = document.getElementById('filterYear').value; // ex: "2023"

        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        // Copie des ventes
        let filtered = [...ventesList];

        // 1. Filtre par produit
        if (productId !== 'all') {
            const pid = parseInt(productId, 10);
            filtered = filtered.filter(v => v.produitId === pid);
        }

        // 2. Filtre avancé : entre deux dates (si sélectionné)
        if (period === 'avance') {
            const startTimestamp = startDate ? new Date(startDate).getTime() : null;
            const endTimestamp = endDate ? new Date(endDate).getTime() : null;

            filtered = filtered.filter(v => {
            const venteTimestamp = new Date(v.dateVente).getTime();
            if (startTimestamp && venteTimestamp < startTimestamp) {
                return false;
            }
            if (endTimestamp && venteTimestamp > endTimestamp) {
                return false;
            }
            return true;
            });
        } else if (period !== 'all') {
            // 3. Autres filtres (mois, trimestre, semestre, année)
            filtered = filtered.filter(v => {
            const [yyyy, mm, dd] = v.dateVente.split('-').map(x => parseInt(x, 10));

            switch (period) {
                case 'month': {
                const selectedMonth = parseInt(monthValue, 10);
                const selectedYear = parseInt(yearValue, 10);
                return (mm === selectedMonth && yyyy === selectedYear);
                }
                case 'quarter': {
                const selectedQuarter = parseInt(quarterValue, 10); // 1..4
                const selectedYear = parseInt(yearValue, 10);

                let startMonth = 1 + (selectedQuarter - 1) * 3; // ex: quarter=2 => start=4
                let endMonth = startMonth + 2; // ex: quarter=2 => end=6
                return (yyyy === selectedYear && mm >= startMonth && mm <= endMonth);
                }
                case 'semester': {
                const selectedSem = parseInt(semesterValue, 10); // 1 ou 2
                const selectedYear = parseInt(yearValue, 10);
                if (selectedSem === 1) {
                    return (yyyy === selectedYear && mm >= 1 && mm <= 6);
                } else {
                    return (yyyy === selectedYear && mm >= 7 && mm <= 12);
                }
                }
                case 'year': {
                const selectedYear = parseInt(yearValue, 10);
                return (yyyy === selectedYear);
                }
                default:
                return true; // Should not happen
            }
            });
        }

        // Réinitialiser la page courante à 1 lors du filtrage
        currentPage = 1;

        // Mettre à jour le tableau et les graphiques
        updateTable(filtered);
        updateAllCharts(filtered);
        }




      /***************************************************
       * 5. Mise à jour du tableau
       ***************************************************/
       // Variables de pagination
    let currentPage = 1;
    const rowsPerPage = 10; // Nombre de lignes par page

    function updateTable(filteredData) {
    const tbody = document.getElementById('ventesTableBody');
    tbody.innerHTML = '';

    // Calcul des indices pour la pagination
    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = Math.min(startIndex + rowsPerPage, filteredData.length);

    // Gestion des lignes à afficher
    const currentData = filteredData.slice(startIndex, endIndex);

    if (currentData.length === 0) {
        const row = document.createElement('tr');
        const cell = document.createElement('td');
        cell.colSpan = 5;
        cell.innerText = 'Aucune vente trouvée.';
        row.appendChild(cell);
        tbody.appendChild(row);
    } else {
        currentData.forEach(v => {
        const row = document.createElement('tr');

        const cellDate = document.createElement('td');
        cellDate.innerText = v.dateVente;

        const cellProduit = document.createElement('td');
        cellProduit.innerText = v.produitNom;

        const cellQuantite = document.createElement('td');
        cellQuantite.innerText = v.totalQuantite;

        const cellTotal = document.createElement('td');
        cellTotal.innerText = v.totalVente;

        const cellCommandes = document.createElement('td');
        cellCommandes.innerText = v.nombreCommandes;

        row.appendChild(cellDate);
        row.appendChild(cellProduit);
        row.appendChild(cellQuantite);
        row.appendChild(cellTotal);
        row.appendChild(cellCommandes);

        tbody.appendChild(row);
        });
    }

    // Mise à jour de l'indicateur de page
    updatePaginationControls(filteredData.length);
    }
    function updatePaginationControls(totalRows) {
        const totalPages = Math.ceil(totalRows / rowsPerPage);
        const pageIndicator = document.getElementById('pageIndicator');
        const prevPageButton = document.getElementById('prevPage');
        const nextPageButton = document.getElementById('nextPage');

        // Mise à jour de l'indicateur
        pageIndicator.innerText = `Page ${currentPage} / ${totalPages}`;

        // Activer/désactiver les boutons
        prevPageButton.disabled = currentPage === 1;
        nextPageButton.disabled = currentPage === totalPages;
    }

    function changePage(direction) {
        // Modifier la page actuelle
        currentPage += direction;

        // Recharger le tableau avec les nouvelles données de la page actuelle
        applyFilters();
    }


      /***************************************************
       * 6. Gestion des Charts (bar, line, doughnut)
       ***************************************************/
      let barChart, lineChart, doughnutChart;

      // Initialisation
      function initCharts() {
        // Bar Chart : Total des ventes par date
        const barCtx = document.getElementById('barChart').getContext('2d');
        barChart = new Chart(barCtx, {
          type: 'bar',
          data: {
            labels: [], // seront mis à jour plus tard
            datasets: [{
              label: 'Total des Ventes (Ar)',
              data: [],
              backgroundColor: 'rgba(75, 192, 192, 0.4)',
              borderColor: 'rgba(75, 192, 192, 1)',
              borderWidth: 1
            }]
          },
          options: {
            responsive: true,
            scales: {
              y: { beginAtZero: true }
            }
          }
        });

        // Line Chart : Quantité vendue par date
        const lineCtx = document.getElementById('lineChart').getContext('2d');
        lineChart = new Chart(lineCtx, {
          type: 'line',
          data: {
            labels: [],
            datasets: [{
              label: 'Quantité Vendue',
              data: [],
              borderColor: 'rgba(255, 99, 132, 1)',
              backgroundColor: 'rgba(255, 99, 132, 0.2)',
              fill: true,
              tension: 0.1
            }]
          },
          options: {
            responsive: true,
            scales: {
              y: { beginAtZero: true }
            }
          }
        });

        // Doughnut Chart : Répartition des ventes par produit
        const doughnutCtx = document.getElementById('doughnutChart').getContext('2d');
        doughnutChart = new Chart(doughnutCtx, {
          type: 'doughnut',
          data: {
            labels: [],
            datasets: [{
              label: 'Répartition des ventes',
              data: [],
              backgroundColor: [
                '#FF6384',
                '#36A2EB',
                '#FFCE56',
                '#4BC0C0',
                '#9966FF',
                '#FF9F40',
                // ajouter plus de couleurs si besoin
              ]
            }]
          },
          options: {
            responsive: true,
            plugins: {
              legend: {
                position: 'top'
              }
            }
          }
        });
      }

      // Mise à jour de tous les charts avec un array filtré
      function updateAllCharts(filteredData) {
        // 6.1 Bar chart (total des ventes par date)
        // On va simplement lister la date (AAAA-MM-JJ) en X et totalVente en Y
        const barName = filteredData.map(v => v.produitNom);
        const barLabels = filteredData.map(v => v.dateVente);
        const barValues = filteredData.map(v => v.totalVente);

        barChart.data.labels = barLabels;
        barChart.data.datasets[0].data = barValues;
        barChart.update();

        // 6.2 Line chart (quantité vendue par date)
        const lineLabels = filteredData.map(v => v.dateVente);
        const lineValues = filteredData.map(v => v.totalQuantite);

        lineChart.data.labels = lineLabels;
        lineChart.data.datasets[0].data = lineValues;
        lineChart.update();

        // 6.3 Doughnut chart (répartition des ventes par produit)
        // Il faut agréger par produit
        const mapProduit = new Map(); // key = produitNom, value = somme totalVente
        filteredData.forEach(v => {
          const nom = v.produitNom;
          if (!mapProduit.has(nom)) {
            mapProduit.set(nom, 0);
          }
          mapProduit.set(nom, mapProduit.get(nom) + v.totalVente);
        });
        const doughnutLabels = Array.from(mapProduit.keys());
        const doughnutValues = Array.from(mapProduit.values());

        doughnutChart.data.labels = doughnutLabels;
        doughnutChart.data.datasets[0].data = doughnutValues;
        doughnutChart.update();
      }

      /***************************************************
       * 7. Initialisation globale de la page
       ***************************************************/
      window.addEventListener('DOMContentLoaded', () => {
        // 7.1 Peupler les filtres (liste de produits, liste d’années)
        populateFilters();

        // 7.2 Initialiser les charts vides
        initCharts();

        // 7.3 Appliquer les filtres par défaut => on affiche tout
        applyFilters();
      });
    </script>
  </main>
</body>
</html>
