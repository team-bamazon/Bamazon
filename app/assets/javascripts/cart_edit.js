$(document).on('turbolinks:load', function () {
  function buildSumHTML(cart){
    var html = '<p class="a-spacing-none a-spacing-top-mini">'+
            '<span class="a-size-medium a-text-bold">'+
              '小計 ('+ cart.cart_count_sum+ '点):'+
              '<span class="a-color-price a-text-bold">'+
                '<span class="a-size-medium a-color-price sc-price sc-white-space-nowrap  sc-price-sign">'+
                '￥' + cart.cart_price_sum +
             '</span>'+
            '</span>'+
          '</span>'+
        '</p>'+
        '<p class="a-spacing-none a-spacing-top-medium a-text-right">'+
          '<span class="a-size-base">'+
            'この注文での獲得ポイント:'+
            '<span class="a-color-price">'+cart.cart_point_sum+'pt'+'</span>'+
          '</span>'+
        '</p>'
      return html;
  }

  function buildRegistarHTML(cart){
    var html = '<p class="a-spacing-none a-spacing-top-none">' +
                    '<span class="a-size-medium a-text-bold">' +
                      '<span>'+
                        '小計 ('+cart.cart_count_sum+ '点): '+
                      '</span>'+
                      '<span class="a-size-medium a-color-price sc-price sc-white-space-nowrap  sc-price-sign">'+
                      '￥'+ cart.cart_price_sum+
                      '</span>'+
                    '</span>'+
                  '</p>'+
                  '<p class="a-spacing-none a-spacing-top-small">'+
                    '<span class="a-size-base">'+
                      'この注文での獲得ポイント: '+
                      '<span class="a-color-price">'+
                      cart.cart_point_sum+'pt'+
                    '</span>'+
                  '</span>'+
                '</p>'
            return html;
  }


  // 数量変更のイベント
  $(".cart_prodcut_count_buttorn").on('change', function(){
    var changed_count = $(this).val();
    var product_id = $(this).attr('product_id');
    var cart_product_id = $(this).attr('cart_product_id');
    var cart_id = $(this).attr('cart_id')
    var cart_product_info = $(this).parents(".sc-list-item");
    var url = /products/+ product_id +/cart_products/+ cart_product_id ;

    $.ajax({
        url: url,
        type: "PATCH",
        data: {product_count: changed_count,
              cart_id: cart_id},
        dataType: 'json',
      })

    .done(function(json){
      var sumHtml = buildSumHTML(json);
      var registarHtml = buildRegistarHTML(json);
      $(cart_product_info).css("opacity", "0.2").delay(800).animate({"opacity": "1"}, 50);
      $(".a-spacing-none").delay(800).queue(function(){
        $(".a-spacing-none").remove()
      });
      $(".bottom-sum").delay(800).queue(function(){
        $(".bottom-sum").append(sumHtml)
      });
      $(".registar-area").delay(800).queue(function(){
        $(".registar-area").append(registarHtml)
      });
    });

  });
// 削除ボタンのイベント
  $(".carts_delete-buttorn").on('click', function(e) {
    console.log("aaa")
    e.preventDefault();
    $(this).fadeOut(1000)
  });
});
