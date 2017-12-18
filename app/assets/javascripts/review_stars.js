$(document).on('turbolinks:load', function () {
    var fixedStarValue = $("#fixed_star_rate").attr("value");

    function clearStarClass() {
        $(".bigStar").removeClass("blueStar");
        $(".bigStar").removeClass("yellowStar");
    }

    function appendYellowStarClass() {
        var targets = $(".bigStar");

        targets.each(function(i, ele) {
            var target_star_val = $(ele).data("star-value");
            if(fixedStarValue >= target_star_val){
                $(ele).addClass("yellowStar");
            }
        });
    }


    $(".bigStar").on("mouseenter", function() {
        var this_star_val = $(this).data("star-value");
        var targets = $(".bigStar");

        clearStarClass();

        targets.each(function(i, ele) {
            var target_star_val = $(ele).data("star-value");
            if(this_star_val >= target_star_val){
                $(ele).addClass("blueStar");
            }
        });
    });

    $(".bigStar").on("mouseleave", function() {
        clearStarClass();
        appendYellowStarClass();
    });


    $(".bigStar").on("click", function() {
        var this_star_val = $(this).data("star-value");
        $("#fixed_star_rate").attr("value", this_star_val);
        fixedStarValue = this_star_val;

        clearStarClass();
        appendYellowStarClass();

        if($("#input_area").css("display") == "none") {
            $("#input_area").slideDown("slow");
            $("#input_area").css("display", "block");
        }
    });
});
