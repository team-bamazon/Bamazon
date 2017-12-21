$(document).on('turbolinks:load', function () {
    $(function(){
        //テキストリンクをクリックしたら
        $("#editYourAddress").click(function(){
            //body内の最後に<div id="create-address-modal-bg"></div>を挿入
            $("body").append('<div id="create-address-modal-bg"></div>');

            //画面中央を計算する関数を実行
            modalResize_firsttime();

            //モーダルウィンドウを表示
            $("#create-address-modal-bg,#create-address-modal-main").fadeIn("slow");

            //背景のどこか、またはキャンセルボタンをクリックしたらモーダルを閉じる
            $("#create-address-modal-bg,#cancel_button,.a-button-close.a-declarative,.a-icon-close").click(function(){
                $("#create-address-modal-main,#create-address-modal-bg").fadeOut("slow",function(){
                    //挿入した<div id="modal-bg"></div>を削除
                    $('#create-address-modal-bg').remove() ;
                });
            });

            //画面の左上からmodal-mainの横幅・高さを引き、その値を2で割ると画面中央の位置が計算できます
            $(window).resize(modalResize);

            function modalResize_firsttime(){
                var w = $(window).width();
                var h = $(window).height();
                var tgt = $("#a-popover-1");
                var tgt_parent = $("#create-address-modal-main");

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
                var tgt = $("#a-popover-1");
                var tgt_parent = $("#create-address-modal-main");

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
