$(function() {
    var suggest_field = $(".nav-template.nav-flyout-content");
    var prev_input    = "";

    function appendSuggest(suggest) {
        var html =`<li>${ suggest.name }</li>`;
        return html;
    }

    $("#twotabsearchtextbox").on("keyup", function() {
        var input = $("#twotabsearchtextbox").val().trim();

        // 直前の入力と現在の入力が異なる場合再検索（行頭・末尾のスペース入力時対策）
        if(prev_input != input) {
            prev_input = input;

            // 検索文字列が存在するときのみ検索
            if(input != "") {
                $.ajax({
                    type: 'GET',
                    url: '/products/suggest',
                    data: {keyword: input},
                    dataType: 'json'
                })

                .done(function (suggests) {
                    suggest_field.empty();
                    var html = "<ul>";
                    suggests.forEach(function (suggest) {
                        html += appendSuggest(suggest);
                    });
                    html += "</ul>";
                    suggest_field.append(html);
                    $("#nav-flyout-searchAjax").attr("style","display: block;")
                })
                .fail(function () {
                    alert('ユーザー検索に失敗しました');
                })
            }
            // 検索文字列がない場合、前回の検索結果の削除のみ実施
            else {
                suggest_field.empty();
            }
        }
    });
});
