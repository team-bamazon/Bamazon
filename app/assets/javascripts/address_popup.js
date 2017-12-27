$(document).on('turbolinks:load', function () {
    var tgt = $("#a-popover-3");
    var displayFlg = false;

    function fadeInAddress(a_top, a_left) {
        var w_tgt = tgt.outerWidth();

        displayFlg = true;
        tgt.css("top", a_top);
        tgt.css("left", a_left - w_tgt / 2);
        // tgt.offset({ top: a_top, left: a_left - w_tgt / 2 });
        tgt.css("display", "block;");
        tgt.stop(true, true).fadeIn();
    }

    function fadeOutAddress() {
        displayFlg = false;
        tgt.stop(true,true).fadeOut(500, function() {
            // tgt.offset({ top: "0px", left: "0px" });
            tgt.css("display: none;");
            tgt.css("top",0);
            tgt.css("left", 0);
        });
    }

    $(".order-declarative").on("mouseenter", function() {
        if(!displayFlg){
            var w_span = $(this).outerWidth();
            var h_span = $(this).outerHeight();
            var t_span = $(this).offset().top;
            var l_span = $(this).offset().left;

            var top  = t_span + h_span;
            var left = l_span + w_span / 2;

            fadeInAddress(top, left);
        }
    });

    $(".order-declarative").on("mouseleave", function() {
        fadeOutAddress();
    });
});
