// スクロールで小計が固定されるjs
$(document).on('turbolinks:load', function () {
  if (window.location.href.match(/\/products\/\d+\/cart_products/)) {
    var hidden = $("#huc-v2-order-row-placeholder");
    var sum = $("#huc-v2-order-row-with-divider");
    var width = $("#huc-v2-order-row-container")
    var sumTop = sum.offset().top;
    $(window).scroll(function () {
      var winTop = $(this).scrollTop();
      if (winTop >= sumTop) {
        hidden.removeClass("a-hidden");
        sum.addClass("huc-v2-pinned-order-row-with-divider");
        width.addClass("huc-v2-pinned-order-row");
      } else if (winTop <= sumTop) {
        hidden.addClass("a-hidden");
        sum.removeClass("huc-v2-pinned-order-row-with-divider");
        width.removeClass("huc-v2-pinned-order-row");
      };
    });
  };
});
