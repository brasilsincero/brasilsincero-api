var endpoint = 'http://brasilsincero.thiagoguimaraes.com.br/v1',
    $errorContainer = $('[data-error]'),
    $errorMessageContainer = $('[data-error-message]'),
    $loading = $('.loading'),
    $body = $('body');

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
