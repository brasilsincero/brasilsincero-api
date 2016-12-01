(function() {
  var endpoint = 'http://brasilsincero.thiagoguimaraes.com.br/v1',
      $errorContainer = $('[data-error]'),
      $errorMessageContainer = $('[data-error-message]'),
      $loading = $('.loading'),
      $body = $('body'),
      $peopleYear = $('#people-year'),
      $peopleState = $('#people-state'),
      $peopleTableBody = $('#people-table-data tbody'),
      $peopleCount = $('[data-people-count]'),
      $peopleActiveYear = $('[data-people-active-year]'),
      $peopleMoney = $('[data-people-money]'),
      $peopleRankingCount = $('[data-people-ranking-count]');

  $peopleYear.on('change', fetchData);
  $peopleState.on('change', fetchData);

  fetchData();

  function _showLoading() {
    $loading.removeClass('hide');
    $body.addClass('body-loading');
  }

  function _hideLoading() {
    $loading.addClass('hide');
    $body.removeClass('body-loading');
  }

  function _raiseError(xhr) {
    $errorMessageContainer.text(xhr.responseJSON.error);
    $errorContainer.removeClass('hide');
  }

  function _toMoney(value) {
    return 'R$ ' + numeral(value).format('0,0.00');
  }

  function fetchData() {
    _showLoading();

    var year = $peopleYear.val(),
        state = $peopleState.val(),
        params = '?year=' + year;

    if (state !== '') {
      params += '&state=' + state;
    }

    var request = $.getJSON(endpoint + '/bolsa_familia/people/ranking' + params);
    request.then(_render);
    request.fail(_raiseError);

    function _render(result) {
      $peopleTableBody.empty();

      $peopleCount.text(result.number_of_people);
      $peopleActiveYear.text(result.year);
      $peopleMoney.text(_toMoney(result.money_spent));
      $peopleRankingCount.text(result.ranking.length);

      result.ranking.forEach(function(data) {
        _insertTableData(data);
      });

      _hideLoading();
    }
  }

  function _insertTableData(data) {
    var $row = $('<tr>'),
        $peopleNameColumn = $('<td>'),
        $peopleCityColumn = $('<td>'),
        $peopleStateColumn = $('<td>'),
        $peopleAmountColumn = $('<td>');

    $peopleNameColumn.text(data.nome_favorecido);
    $peopleCityColumn.text(data.nome_municipio);
    $peopleStateColumn.text(data.uf);
    $peopleAmountColumn.text(_toMoney(data.sum));
    $row.append($peopleNameColumn);
    $row.append($peopleCityColumn);
    $row.append($peopleStateColumn);
    $row.append($peopleAmountColumn);
    $peopleTableBody.append($row);
  }
})();
