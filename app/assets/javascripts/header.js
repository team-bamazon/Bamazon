// カテゴリーダイアログ
$(document).on('turbolinks:load', function () {
  var shopAll = $('#nav-flyout-shopAll')
  $('#nav-link-shopall').hover(function() {
    shopAll.show();
  }, function() {
    shopAll.hide();
  });
    shopAll.hover(function() {
    shopAll.show();
  }, function() {
    shopAll.hide();
  });
});

// 言語選択ダイアログ
$(document).on('turbolinks:load', function () {
  var icp = $('#nav-flyout-icp')
  $('#icp-nav-flyout').hover(function() {
    icp.show();
  }, function() {
    icp.hide();
  });
  $(icp).hover(function() {
    $(icp).show();
  }, function() {
    $(icp).hide();
  });
});


// アカウントサービスダイアログ
//// サインイン時
$(document).on('turbolinks:load', function () {
  var yourAccount = $('#nav-flyout-yourAccount')
  $('#nav-link-yourAccount').hover(function() {
    yourAccount.show();
  }, function() {
    yourAccount.hide();
  });
  $(yourAccount).hover(function() {
    $(yourAccount).show();
  }, function() {
    $(yourAccount).hide();
  });
});

////サインアウト時
$(document).on('turbolinks:load', function () {
  var yourAccount = $('#nav-flyout-yourAccount_sign_out')
  $('#nav-link-yourAccount').hover(function() {
    yourAccount.show();
  }, function() {
    yourAccount.hide();
  });
  $(yourAccount).hover(function() {
    $(yourAccount).show();
  }, function() {
    $(yourAccount).hide();
  });
});


// ほしい物リストダイアログ
//// サインイン時
$(document).on('turbolinks:load', function () {
  var wishList = $('#nav-flyout-wishlist')
  $('#nav-link-wishlist').hover(function() {
    wishList.show();
  }, function() {
    wishList.hide();
  });
  $(wishList).hover(function() {
    $(wishList).show();
  }, function() {
    $(wishList).hide();
  });
});
////サインアウト時
$(document).on('turbolinks:load', function () {
  var wishList = $('#nav-flyout-wishlist_sign_out')
  $('#nav-link-wishlist').hover(function() {
    wishList.show();
  }, function() {
    wishList.hide();
  });
  $(wishList).hover(function() {
    $(wishList).show();
  }, function() {
    $(wishList).hide();
  });
});
