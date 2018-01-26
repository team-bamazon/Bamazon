$(document).on('turbolinks:load', function () {
    $(function(){
        //テキストリンクをクリックしたら
        $("#editYourAddress").click(function(){
            //body内の最後に<div id="create-address-modal-bg"></div>を挿入
            $("body").append('<div id="create-address-list-modal-bg"></div>');

            //画面中央を計算する関数を実行
            modalResize_firsttime();

            //モーダルウィンドウを表示
            $("#create-address-list-modal-bg,#create-address-list-modal-main").fadeIn("slow");

            //背景のどこか、またはキャンセルボタン、住所を追加をクリックしたらモーダルを閉じる
            $("#create-address-list-modal-bg,#cancel_button,.a-button-close.a-declarative,.a-icon-close, #order-address-add-link").click(function(){
                $("#create-address-list-modal-main,#create-address-list-modal-bg").fadeOut("fast",function(){
                    //挿入した<div id="modal-bg"></div>を削除
                    $('#create-addresslist--modal-bg').remove() ;
                });
            });

            //画面の左上からmodal-mainの横幅・高さを引き、その値を2で割ると画面中央の位置が計算できます
            $(window).resize(modalResize);

            function modalResize_firsttime(){
                var w = $(window).width();
                var h = $(window).height();
                var tgt = $("#a-popover-3");
                var tgt_parent = $("#create-address-list-modal-main");

                tgt_parent.css({
                    'display':'block',
                    'visibility':'hidden'
                });

                var cw = tgt.outerWidth();
                var ch = tgt.outerHeight();

                tgt_parent.css({
                    'display':'none',
                    'visibility':'visible'
                });

                //取得した値をcssに追加する
                tgt_parent.css({
                    "left": ((w - cw)/2) + "px",
                    "top": ((h - ch)/2) + "px"
                });
            }

            function modalResize(){
                var w = $(window).width();
                var h = $(window).height();
                var tgt = $("#a-popover-3");
                var tgt_parent = $("#create-address-list-modal-main");

                var cw = tgt.outerWidth();
                var ch = tgt.outerHeight();

                //取得した値をcssに追加する
                tgt_parent.css({
                    "left": ((w - cw)/2) + "px",
                    "top": ((h - ch)/2) + "px"
                });
            }
        });
    });
});

$(document).on('turbolinks:load', function () {

    var settedAddressHtml = '<div id="status-1" class="a-section a-spacing-none default-section">' +
                  '<span class="a-size-small a-color-secondary default-line-item">既定の住所: </span>'+
                  '<div id="ya-myab-default-shipping-address-icon" class="a-section a-spacing-none amazon-logo aok-inline-block"></div>' +
                '</div>';

    function buildDisplayAddressHtml(address){
        var html = '<ul class="displayAddressUL">'+
                                    '<li>'+address.full_name+'</li>'+
                                      '<li>'+address.postal_code_one+'-'+ address.postal_code_two+ '</li>'+
                                      '<li>'+address.region +' '+ address.street_address_one + address.street_address_two + address.building_name+'</li>'+
                                      '<li>'+'電話番号:'+address.phone_number+'</li>'+
                                      '</ul>';
        return html
    }

    $('.status-update-btn').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
        var btn = $(this);
        // 'action'でとるよりもhtmlにあったhrefの方が欲しいurlになっていそうだったので変更あと'POST'も'PATCH'に
        var href = $(this).attr('href');
        // dataでformDataを送る必要がなさそうなのでajaxから削除。
        $.ajax ({
            url: href,
            type: 'PATCH',
            dataType: 'json',
            // processData: false,
            // contentType: false
        })
        // .doneがなかったので追加
        .done(function (json) {
             var displayAddressHtml = buildDisplayAddressHtml(json);
            $('#status-1').remove();
            // 'btn'に$がなかったので追加
            $(btn).parent().parent().find('.a-box-inner').prepend(settedAddressHtml);
            // 元々届け先だったものにボタンの追加
            $('.status-update-btn').show();
            // 住所に設定ボタンを削除
            $(btn).hide();
            // モーダルじゃないところに住所の変更を反映
            $('.displayAddressDiv').html(displayAddressHtml);
        })
    });
});
