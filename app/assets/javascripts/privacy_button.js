$(document).on('turbolinks:load', function () {

    function remove_attrs() {
        $("#privacy_button_private").removeClass("a-button-selected");
        $("#privacy_button_public").removeClass("a-button-selected");
        $("#radio_privacy_private").removeAttr("checked");
        $("#radio_privacy_public").removeAttr("checked");
        $("#private_blurb").removeClass("a-hidden");
        $("#public_blurb").removeClass("a-hidden");
    }

    $(document).on('click', '#privacy_button_private_btn', function() {
        remove_attrs();

        $("#privacy_button_private").addClass("a-button-selected");
        $("#radio_privacy_private").attr("checked", "checked");
        $("#public_blurb").addClass("a-hidden");
    });
    $(document).on('click', '#privacy_button_public_btn', function() {
        remove_attrs();

        $("#privacy_button_public").addClass("a-button-selected");
        $("#radio_privacy_public").attr("checked", "checked");
        $("#private_blurb").addClass("a-hidden");
    });
});

