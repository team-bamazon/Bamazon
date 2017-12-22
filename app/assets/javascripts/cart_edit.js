$(document).on('turbolinks:load', function () {

  // 下の合計のところのHTML
  function buildSumHTML(cart){
    var html = '<p class="a-spacing-none a-spacing-top-mini">'+
            '<span class="a-size-medium a-text-bold">'+
              '小計 ('+ cart.cart_count_sum+ '点): '+
              '<span class="a-color-price a-text-bold">'+
                '<span class="a-size-medium a-color-price sc-price sc-white-space-nowrap  sc-price-sign">'+
                '￥ ' + cart.cart_price_sum +
             '</span>'+
            '</span>'+
          '</span>'+
        '</p>'+
        '<p class="a-spacing-none a-spacing-top-medium a-text-right">'+
          '<span class="a-size-base">'+
            'この注文での獲得ポイント: '+
            '<span class="a-color-price">'+cart.cart_point_sum+'pt'+'</span>'+
          '</span>'+
        '</p>'
      return html;
  }

  // 右のレジのところのHTML
  function buildRegistarHTML(cart){
    var html = '<p class="a-spacing-none a-spacing-top-none">' +
                    '<span class="a-size-medium a-text-bold">' +
                      '<span>'+
                        '小計 ('+cart.cart_count_sum+ '点): '+
                      '</span>'+
                      '<span class="a-size-medium a-color-price sc-price sc-white-space-nowrap  sc-price-sign">'+
                      '￥ '+ cart.cart_price_sum+
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

  // ヘッダーのカートの合計のテキスト
  function buildHeaderCartHTML(cart){
    var html = cart.cart_count_sum
      return html;
  }

  // カートから商品削除後のメッセージ
  function buildDestroyCartProductHTML(product){
    var html = '<div id ="deleted_product">'+'<a href = "/products/'+product.product_id+' calss: "deleted_link ">'
    +product.product_name+'</a>'+'は削除されました'+'</div>'
    return html;
    }
  // 商品なかったらの時のメッセージ
  function buildCartHeadHTML(cart){
    var html = '<h1>'+
                'お客様のカートに商品はありません。'+
              '</h1>';
      return html;
  }

  // 数量変更のイベント
  $(".cart_prodcut_count_buttorn").on('change', function(){
    var changed_count = $(this).val();
    var cart_id = $(this).attr('cart_id')
    var product_id = $(this).attr('product_id');
    var cart_product_id = $(this).attr('cart_product_id');
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
      var headerCartHtml = buildHeaderCartHTML(json);
      $(cart_product_info).css("opacity", "0.2").delay(800).animate({"opacity": "1"}, 50);
      $(".a-spacing-none").delay(800).queue(function(){
        $(".a-spacing-none").remove();
        $(".bottom-sum").append(sumHtml);
        $(".registar-area").append(registarHtml);
        $("#nav-cart-count").text(headerCartHtml)
      });
    });

  });
  // 削除ボタンのイベント
  $(".carts_delete_buttorn").on('click', function(e){
    e.preventDefault();
    var cart_id = $(this).attr('cart_id');
    var product_id = $(this).attr('product_id');
    var cart_product_id = $(this).attr('cart_product_id');
    var cart_product_info = $(this).parents(".cart-product-infomation");
    var url = /products/+ product_id +/cart_products/+ cart_product_id ;

    $.ajax({
      url: url,
      type: "DELETE",
      data: {cart_id: cart_id},
      dataType: 'json',
    })

    .done(function(json){
      var destoryMessage = buildDestroyCartProductHTML(json);
      var sumHtml = buildSumHTML(json);
      var registarHtml = buildRegistarHTML(json);
      var headerCartHtml = buildHeaderCartHTML(json);
      var cartHeadHtml = buildCartHeadHTML(json);
      var cart_products = json.cart_products;
      $(cart_product_info).css("opacity", "0.2").delay(800).queue(function(){
        $(cart_product_info).css("opacity", "1");
        $(cart_product_info).html(destoryMessage);
      });

      $(".a-spacing-none").delay(800).queue(function(){
        $(".a-spacing-none").remove();
        $(".bottom-sum").append(sumHtml);
        $(".registar-area").append(registarHtml);
        $("#nav-cart-count").text(headerCartHtml);
      });

      if($(cart_products).length == 0){
        $(".cart_head").delay(800).queue(function(){
          $(".cart_head").html(cartHeadHtml);
          $("#sc-buy-box").remove();
        });
      };
      $("#deleted_product").closest(".sc-list-item-border").fadeOut(800);
    });
  });
});
