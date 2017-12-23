$(document).on('turbolinks:load', function () {
// 挙動が変だったのでオンclickをオンchangeに変更しました
    $("[id^=wanted-selector-]").on("change",function() {
        var value = $(this).prop('value');
        var wpid = $(this).data("wpid");

        // 「移動」以外が押されたときのみ発動
        if(value != ""){
            $("#edit_wanted_product_" + wpid).submit();
        }
    });
});
