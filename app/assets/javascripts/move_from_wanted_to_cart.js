$(document).on('turbolinks:load', function () {
   $("[id^=move-to-cart-]").on("click", function(e) {
       e.preventDefault();
       e.stopPropagation();
       var url = $(this).attr("href");
       var product_id = $(this).data("id");

       $.ajax({
           type:     'POST',
           url:      url,
           data:     { cart_product: { product_count: 1 } },
           dataType: 'json'
       })
       .done(function() {
           var before_tag = "#beforeMoveToCart_" + product_id;
           var after_tag  = "#afterMoveToCart_" + product_id;
           $(before_tag).css("display", "none");
           $(after_tag).css("display", "block");

           // カートに入れた時にヘッダのカート内の品数をインクリメント
           var num_items = parseInt($('#nav-cart-count').text().replace(/,/g,""), 10) + 1;
           num_items = String(num_items).replace( /(\d)(?=(\d{3})+(?!\d))/g, '$1,');
           $('#nav-cart-count').text(num_items);
       })
       .fail(function() {
           alert('カートに移動できませんでした');
       })
   });
});
