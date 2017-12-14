$(document).on('turbolinks:load', function () {
   $("[id^=move-to-cart-]").on("click", function(e) {
       e.preventDefault();
       e.stopPropagation();
       var url = $(this).attr("href");
       var product_id = $(this).data("id");
       var link_button = $(this);

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
       })
       .fail(function() {
           alert('カートに移動できませんでした');
       })
   });
});
