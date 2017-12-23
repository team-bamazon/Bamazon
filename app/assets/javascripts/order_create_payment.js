$(document).on('turbolinks:load', function () {
    $(function(){
        //テキストリンクをクリックしたら
        $("#payment-change-link").click(function(){
            //body内の最後に<div id="create-payment-modal-bg"></div>を挿入
            $("body").append('<div id="create-payment-modal-bg"></div>');

            //画面中央を計算する関数を実行
            modalResize_firsttime();

            //モーダルウィンドウを表示
            $("#create-payment-modal-bg,#create-payment-modal-main").fadeIn("slow");

            //背景のどこか、またはキャンセルボタンをクリックしたらモーダルを閉じる
            $("#create-payment-modal-bg,#cancel_button,.a-button-close.a-declarative,.a-icon-close").click(function(){
                $("#create-payment-modal-main,#create-payment-modal-bg").fadeOut("slow",function(){
                    //挿入した<div id="modal-bg"></div>を削除
                    $('#create-payment-modal-bg').remove() ;
                });
            });

            //画面の左上からmodal-mainの横幅・高さを引き、その値を2で割ると画面中央の位置が計算できます
            $(window).resize(modalResize);

            function modalResize_firsttime(){
                var w = $(window).width();
                var h = $(window).height();
                var tgt = $("#a-popover-2");
                var tgt_parent = $("#create-payment-modal-main");

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
                var tgt = $("#a-popover-2");
                var tgt_parent = $("#create-payment-modal-main");

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
    function buildHTML(card) {
        var html = '<span id="card_number">下4桁 ' +
                     + card.number_method +
                   '</span>'
        return html;
    }
    $('#new_payment_information').on('submit', function(e){
        e.preventDefault();
        e.stopPropagation();
        $("#create-payment-modal-main,#create-payment-modal-bg").fadeOut("slow",function(){
            //挿入した<div id="modal-bg"></div>を削除
            $('#create-payment-modal-bg').remove() ;
        });
        var formData = new FormData(this);
        var href = $(this).attr('action');
        $.ajax ({
            url: href,
            type: 'POST',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
        .done(function(data){
            var html = buildHTML(data);
            $('#card_number').html(html)
        })
        .fail(function(){
            alert('error');
        })
    });
});
