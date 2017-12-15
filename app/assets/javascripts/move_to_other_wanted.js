$(document).on('turbolinks:load', function () {
    $("[id^=wanted-selector-]").on("click",function() {
        var value = $(this).prop('value');
        var wpid = $(this).data("wpid");

        // 「移動」以外が押されたときのみ発動
        if(value != ""){
            $("#edit_wanted_product_" + wpid).submit();
        }
    });
});
