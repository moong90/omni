$(function () {
  $('.gnb > li').hover(
      function () {
        $(this).addClass('active');
      },
      function () {
        $(this).removeClass('active');
      }
  );
  $('.lnb > li').hover(
      function () {
        $(this).addClass('active');
      },
      function () {
        $(this).removeClass('active');
      }
  );
});
$(function () {
    $('.mobile-btn').on('click', function () {
        $('#Sitemap').toggleClass('active');
        $(this).toggleClass('active');
    });
});
$(function () {
    $('#Sitemap .s-gnb > li > .dep-01').on('click', function (e) {
        const $li = $(this).parent('li');
        if ($li.children('.s-lnb').length) {
            e.preventDefault(); // 링크 차단
            $li.toggleClass('active')
                .siblings().removeClass('active'); // 하나만 열리게
        }
    });
    $('#Sitemap .s-lnb > li > a').on('click', function (e) {
        const $li = $(this).parent('li');

        if ($li.children('.s-snb').length) {
            e.preventDefault(); // 링크 차단
            $li.toggleClass('active')
                .siblings().removeClass('active');
        }
    });
    $('#Sitemap .close-btn').on('click', function () {
        $('#Sitemap').removeClass('active');
        $('#Sitemap li').removeClass('active');
        $('body').removeClass('menu-open'); // body 스크롤 잠금 사용 시
    });
});