(function() {
  google.charts.load('current', {'packages': ['geochart', 'corechart']});
  google.charts.setOnLoadCallback(drawMarkersMap);
  google.charts.setOnLoadCallback(drawChart);

  var $stateYear = $('#states-year'),
      $stateTableBody = $('#states-table-data tbody');

  $stateYear.on('change', drawMarkersMap);

  function drawMarkersMap() {
    _showLoading();

    var year = $stateYear.val(),
        ranking = [['Estado', 'Bolsa Família']],
        request = $.getJSON(endpoint + '/bolsa_familia/states/ranking?year=' + year),
        chart = new google.visualization.GeoChart(document.getElementById('map_div')),
        chartOptions = {
          region: 'BR',
          displayMode: 'markers',
          colorAxis: { colors: ['orange', 'red'] }
        };

    request.then(_render);
    request.fail(_raiseError);

    function _render(result) {
      $stateTableBody.empty();

      result.ranking.forEach(function(data) {
        _insertTableData(data);
        ranking.push([data.uf, parseFloat(data.sum)]);
      });

      var data = google.visualization.arrayToDataTable(ranking);
      chart.draw(data, chartOptions);

      _hideLoading();
    }
  }

  function _insertTableData(data) {
    var $row = $('<tr>'),
        $stateNameColumn = $('<td>'),
        $stateAmountColumn = $('<td>');

    $stateNameColumn.text(data.uf);
    $stateAmountColumn.text(_toMoney(data.sum));
    $row.append($stateNameColumn);
    $row.append($stateAmountColumn);
    $stateTableBody.append($row);
  }

  function drawChart() {
    var ranking = [['Ano', 'Valor Investido']],
        request = $.getJSON(endpoint + '/bolsa_familia/yearly_costs'),
        chart = new google.visualization.ColumnChart(document.getElementById('years_div')),
        chartOptions = {
          title: 'Valor investido anualmente',
          width: 600,
          height: 400,
          bar: { groupWidth: '90%' },
          legend: { position: 'none' },
        };

    request.fail(_raiseError);
    request.then(function(result) {
      result.forEach(function(data) {
        var moneySpent = parseFloat(data.money_spent);
        if (moneySpent > 0) {
          ranking.push([data.year.toString(), moneySpent]);
        }
      });

      var data = google.visualization.arrayToDataTable(ranking),
          view = new google.visualization.DataView(data);

      chart.draw(view, chartOptions);
    });
  }
})();
