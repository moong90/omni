<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <%
    String userId = "";
    String loginName = "";
    session = request.getSession();

    if (session.getAttribute("loginId") != null) {
        userId = session.getAttribute("loginId").toString();
        loginName = session.getAttribute("loginName").toString();
    }
    String path = request.getServletPath();
    String requestUri = request.getRequestURI();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=1920,shrink-to-fit=no,user-scalable=yes">

    <!--폰트-->
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/fonts/fonts.css">

    <!--css-->
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/css/reset.css">
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/css/base.css">
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/css/common.css">
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/css/style.css">

    <!--js-->
    <script src="/static/admin/assets/v2/js/jquery-3.6.0.js"></script>
    <script src="/static/admin/assets/v2/js/common.js"></script>
    <script src="/static/admin/assets/v2/js/calendar.js"></script>
    <script type="text/javascript" src="/static/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

    <!--데이트피커-->
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/v2/js/libs/datepicker-master/dist/datepicker.min.css">
    <script src="/static/admin/assets/v2/js/libs/datepicker-master/dist/datepicker.min.js"></script>
    
    <!-- chart -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <title>OMNIFIT 관리자</title>
</head>

<body>
<div class="site-wrap">
    <!-- GNB -->
    <div class="gnb" id="Gnb">
        <header class="header">
            <a href="/admin">
                <h1 class="max">OMNIFIT ADMIN</h1>
            </a>
        </header>
        <nav class="nav scroll">
            <ul>
                <li>
                    <button class="btn dep-01" type="button">
                        <span class="icon">
                            <img src="/static/admin/assets/v2/img/icon/menu-icon-01.png" alt="">
                        </span>
                        <span class="txt">메뉴관리</span>
                    </button>
                    <ul class="dep-02 scroll">
                        <li><a href="/admin/menu/1">메뉴관리</a></li>
                    </ul>
                </li>
                <li>
                    <button class="btn dep-01" type="button">
                        <span class="icon">
                          <img src="/static/admin/assets/v2/img/icon/menu-icon-10.png" alt="">
                        </span>
                        <span class="txt">페이지 관리</span>
                    </button>
                    <ul class="dep-02">
                        <li><a href="/admin/pageMng">컨텐츠관리</a></li>
                    </ul>
                </li>
                <li>
                    <button class="btn dep-01" type="button">
                        <span class="icon">
                          <img src="/static/admin/assets/img/icon/menu-icon-07.png" alt="">
                        </span>
                        <span class="txt">문의관리</span>
                    </button>
                    <ul class="dep-02 scroll">
                        <li><a href="/admin/inquiryList">문의리스트</a></li>
                    </ul>
                </li>
                <li>
                    <button class="btn dep-01" type="button">
                        <span class="icon">
                          <img src="/static/admin/assets/v2/img/icon/menu-icon-04.png" alt="">
                        </span>
                        <span class="txt">서비스관리</span>
                    </button>
                    <ul class="dep-02 scroll">
                        <li><a href="/admin/footer">푸터관리</a></li>
                        <li><a href="/admin/mainPage">메인관리</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <button class="menu-pop-btn" type="button">
            <span class="icon"></span>
        </button>

    </div>
    <!-- // gnb -->

    <div class="content-wrap">
        <header class="header">
            <div class="user-menu">
                <a class="btn" href="javascript:logout();"><img src="/static/admin/assets/v2/img/icon/logout.png" alt="">로그아웃</a>
                <a class="btn my-page-btn" href="#n"><img src="/static/admin/assets/v2/img/icon/user.png" alt=""><span
                        class="user"><%=loginName %></span>&nbsp;님
                </a>
            </div>
            <div class="location">
                <ul>
                    <li>${board_title}</li>
                </ul>
            </div>
            <!--
            <div class="page-tit">
                <h2 class="page-tit-text">${board_title}</h2>
                <c:choose>
                    <c:when test="${board_title eq '예약 관리'}">
                        <span>상담신청 예약을 관리합니다.</span>
                    </c:when>
                    <c:when test="${board_title eq '상담 관리'}">
                        <span>상담이 완료된 내역을 관리합니다.</span>
                    </c:when>
                    <c:when test="${board_title eq '예약 현황'}">
                        <span>예약 현황을 관리할 수 있습니다.</span>
                    </c:when>
                    <c:when test="${board_title eq '휴일 관리'}">
                        <span>휴일을 관리합니다. (ex. 임시공휴일, 휴가)</span>
                    </c:when>
                    <c:when test="${board_title eq '페이지 관리'}">
                        <span>페이지 콘텐츠를 관리 할 수 있습니다.</span>
                    </c:when>
                </c:choose>
            </div>
            -->
        </header>
        <!-- // header -->
<script type="text/javascript">
    function logout() {
        let json = {};
        $.ajax({
            url: "/api/auth/loginout",
            type: 'POST',
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(json)
            , success: function (data) {
                if (data.return_code == 200) {
                    alert("정상적으로 로그아웃되었습니다.");
                    location.href = "/admin";
                } else {
                    alert(data.return_message);
                }
            }
            , error: function (request, status, error) {
                if (request.status == 403) {
                    alert("로그인 정보가 없습니다.");
                    location.href = "/view/login";
                }
                if (request.status == 400 || request.status == 500 || request.status == 503) {
                    alert("등록에 실패했습니다. 시스템관리자에게 문의해주세요.");
                }
            }
        });
    }

    $(document).ready(function () {

        $(document).on('click', '.gnb .dep-01', function () {
            if ($('.gnb').hasClass('active')) {
                $('.gnb').removeClass('active');
            }
            $(this).closest('li').toggleClass('on').find('.dep-02').stop().slideToggle().closest('li').siblings().removeClass('on').find('.dep-02').stop().slideUp().find('li').removeClass('on');
        });


        $('.gnb .dep-02 li').click(function () {
            $(this).addClass('on').siblings().removeClass('on').closest('.dep-02').parent('li').siblings().find('.dep-02 li').removeClass('on');
        });


        function getPageName() {
            var pageName = "";
            var tempPageName = window.location.href;
            var strPageName = tempPageName.split("/");
            pageName = strPageName[strPageName.length - 1].split("?")[0];

            return pageName;
        }

        let url_Page = getPageName();
        let dep = $('.nav a');

        for (let i = 0; i < dep.length; i++) {
            let el = dep.eq(i);
            if (dep.eq(i).attr('href').indexOf(url_Page) > 0) {
                dep.eq(i).closest('.dep-02').closest('li').find('.dep-01').addClass('on');
                dep.eq(i).closest('.dep-02').stop().slideDown(0);
                break;
            }
        }

        //왼쪽 메뉴 여닫기
        $('.menu-pop-btn').on('click', function () {
            $('.site-wrap').toggleClass('active');
            $('.gnb').find('.on').removeClass('on');
        });

    });

    // $(document).ready(function () {
    //     if ($(location).attr('pathname').indexOf('/admin/menu') != -1) {
    //         $('.content-wrap').addClass('menu');
    //     }
    //
    //     if ($(location).attr('pathname').indexOf('/admin/board') != -1) {
    //         $('.content-wrap').addClass('menu');
    //     }
    //
    //     if($(location).attr('pathname').indexOf('/admin/menu/add/') != -1){
    //         $('.content-wrap').removeClass('menu');
    //     }
    //     if($(location).attr('pathname').indexOf('/admin/menu/modify/') != -1){
    //         $('.content-wrap').removeClass('menu');
    //     }
    //
    //     function getPageName() {
    //         var pageName = "";
    //
    //         var tempPageName = window.location.href;
    //         var strPageName = tempPageName.split("/");
    //         pageName = strPageName[strPageName.length - 1].split("?")[0];
    //
    //         return pageName;
    //     }
    //
    //     let url_Page = getPageName();
    //     let dep = $('.nav a');
    //
    //     for (let i = 0; i < dep.length; i++) {
    //         let el = dep.eq(i);
    //         console.log(el)
    //         if (dep.eq(i).attr('href').indexOf(url_Page) > 0) {
    //             dep.eq(i).closest('.dep-02').closest('li').find('.dep-01').trigger('click');
    //             break;
    //         }
    //     }
    //
    //     //왼쪽 메뉴 여닫기
    //     $('.menu-pop-btn').on('click', function () {
    //         $('.gnb').toggleClass('active');
    //         $('.gnb').find('.on').removeClass('on');
    //         $('.nav>ul>li ul').slideUp();
    //     })//23.03.23
    // });
</script>
