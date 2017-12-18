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

    function clearHowIdThisProduct() {
        $("#how_is_this_product").text("");
    }

    function clearUserInfoArea() {
        $("#user_info_area").css("display", "none");
    }

    function resetUserInfoArea() {
        $("#user_info_area").css("display", "block");
    }

    $(".bigStar").on("mouseenter", function() {
        var this_star_val = $(this).data("star-value");
        var targets = $(".bigStar");

        clearStarClass();
        clearUserInfoArea();

        switch(this_star_val){
            case 1 : $("#how_is_this_product").text("ん～…まあ…"); break;
            case 2 : $("#how_is_this_product").text("悪くはない"); break;
            case 3 : $("#how_is_this_product").text("普通"); break;
            case 4 : $("#how_is_this_product").text("なかなか良い"); break;
            case 5 : $("#how_is_this_product").text("とても良い"); break;
            default : $("#how_is_this_product").text("");
        }

        targets.each(function(i, ele) {
            var target_star_val = $(ele).data("star-value");
            if(this_star_val >= target_star_val){
                $(ele).addClass("blueStar");
            }
        });
    });

    $(".bigStar").on("mouseleave", function() {
        clearHowIdThisProduct();
        resetUserInfoArea();
        clearStarClass();
        appendYellowStarClass();
    });


    $(".bigStar").on("click", function() {
        var this_star_val = $(this).data("star-value");
        $("#fixed_star_rate").attr("value", this_star_val);
        fixedStarValue = this_star_val;

        clearHowIdThisProduct();
        resetUserInfoArea();
        clearStarClass();
        appendYellowStarClass();

        if($("#input_area").css("display") == "none") {
            $("#input_area").slideDown("slow");
            $("#input_area").css("display", "block");
        }
    });
});
