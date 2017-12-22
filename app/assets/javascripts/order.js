// 右の要素の高さを左の要素の高さに合わせる
$(document).on('turbolinks:load', function () {
  var boxHeight = $('#left-grid').height();
  $('#right-grid').css('height', boxHeight + 'px');
});
