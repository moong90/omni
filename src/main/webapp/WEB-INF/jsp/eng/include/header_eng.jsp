<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <!--파비콘-->
  <link rel="apple-touch-icon" sizes="76x76" href="/static/img/favicon/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/static/img/favicon/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/static/img/favicon/favicon-16x16.png">
  <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
  <meta name="msapplication-TileColor" content="#da532c">
  <meta name="theme-color" content="#ffffff">

  <!--메타-->
  <meta property="og:image" content="/static/img/common/thumb.jpg">
  <meta property="og:image:type" content="image/jpeg">
  <meta property="og:image:width" content="600">
  <meta property="og:image:height" content="315">
  <meta property="og:url" content="">
  <meta property="twitter:image" content="/static/img/common/thumb.jpg">
  <meta property="twitter:image:type" content="image/jpeg">
  <meta property="twitter:image:width" content="600">
  <meta property="twitter:image:height" content="315">

  <!--css-->
  <link rel="stylesheet" type="text/css" href="/static/fonts/fonts.css">
  <link rel="stylesheet" type="text/css" href="/static/css/reset.css">
  <link rel="stylesheet" type="text/css" href="/static/css/base.css">
  <link rel="stylesheet" type="text/css" href="/static/css/layout.css">
  <link rel="stylesheet" type="text/css" href="/static/css/main.css">
  <link rel="stylesheet" type="text/css" href="/static/css/style.css">

  <!--libs-->
  <script src="/static/js/jquery-3.6.0.js"></script>

  <!--fullpage-->
  <link rel="stylesheet" type="text/css" href="/static/js/libs/fullPage.js-2.9.7/jquery.fullPage.css">
  <script src="/static/js/libs/fullPage.js-2.9.7/vendors/scrolloverflow.min.js"></script>
  <script src="/static/js/libs/fullPage.js-2.9.7/dist/jquery.fullpage.min.js"></script>

  <!--슬라이드-->
  <link rel="stylesheet" href="/static/js/libs/swiper/swiper-bundle.min.css">
  <script src="/static/js/libs/swiper/swiper-bundle.min.js"></script>

  <!--aos-->
  <!-- <link rel="stylesheet" href="/static/js/libs/aos/aos.css">
  <script src="/static/js/libs/aos/aos.js"></script> -->

  <!-- gsap -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/gsap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.13.0/ScrollTrigger.min.js"></script>

  <!--js-->
  <script src="/static/js/common.js"></script>

  <title>OMNIFIT</title>
</head>


<body>
  <!--header-->
  <div class="header-wrap" id="Header">
    <div class="skip-nav">
      <a class="skip" href="#Gnb">go to Menu</a>
      <a class="skip" href="#Main">go to content</a>
    </div>

    <header class="header">
      <h1 class="logo">
        <a href="/">
            <img src="/static/img/common/logo.svg" alt="logo">
        </a>
      </h1>
      <nav class="nav" id="Gnb">
          <ul class="gnb">
             <c:forEach items="${menuTreeList}" var="menuLv2">
                <c:if test="${menuLv2.lvl eq '2' && menuLv2.useYn ne 'N'}">
                   <li><a href="/omnifit/${menuLv2.fullPath}">${menuLv2.menuName}</a>
                       <ul class="lnb">
                           <c:forEach items="${menuTreeList}" var="menuLv3">
                             <c:if test="${menuLv3.lvl eq '3' && menuLv3.parent == menuLv2.menuSeq && menuLv3.useYn eq 'Y'}">
                               <li><a href="/omnifit/${menuLv3.fullPath}">${menuLv3.menuName}</a>
                                   <ul class="snb">
                                       <c:forEach items="${menuTreeList}" var="menuLv4">
                                         <c:if test="${menuLv4.lvl eq '4' && menuLv4.parent == menuLv3.menuSeq && menuLv4.useYn eq 'Y'}">
                                           <li>
                                             <a href="/omnifit/${menuLv2.urlname}/${menuLv3.urlname}/${menuLv4.urlname}">
                                               ${menuLv4.menuName}
                                             </a>
                                           </li>
                                         </c:if>
                                       </c:forEach>
                                   </ul>
                               </li>
                             </c:if>
                           </c:forEach>
                       </ul>
                   </li>
                </c:if>
             </c:forEach>
          </ul>
      </nav>
      <nav class="sitemap_wrap" id="Sitemap">
          <div class="logo">
            <a href="/">
              <img src="/static/img/common/logo.svg" alt="">
            </a>
          </div>
          <ul class="s-gnb">
            <c:forEach items="${menuTreeList}" var="menuLv2">
                <c:if test="${menuLv2.lvl eq '2' && menuLv2.useYn ne 'N'}">
                   <li><a href="/omnifit/${menuLv2.fullPath}">${menuLv2.menuName}</a>
                       <ul class="s-lnb">
                           <c:forEach items="${menuTreeList}" var="menuLv3">
                             <c:if test="${menuLv3.lvl eq '3' && menuLv3.parent == menuLv2.menuSeq && menuLv3.useYn eq 'Y'}">
                               <li><a href="/omnifit/${menuLv3.fullPath}">${menuLv3.menuName}</a>
                                   <ul class="s-snb">
                                       <c:forEach items="${menuTreeList}" var="menuLv4">
                                         <c:if test="${menuLv4.lvl eq '4' && menuLv4.parent == menuLv3.menuSeq && menuLv4.useYn eq 'Y'}">
                                           <li>
                                             <a href="/omnifit/${menuLv2.urlname}/${menuLv3.urlname}/${menuLv4.urlname}">
                                               ${menuLv4.menuName}
                                             </a>
                                           </li>
                                         </c:if>
                                       </c:forEach>
                                   </ul>
                               </li>
                             </c:if>
                           </c:forEach>
                       </ul>
                   </li>
                </c:if>
            </c:forEach>
          </ul>
          <div class="close">
            <button class="close-btn">
                <span></span>
                <span></span>
            </button>
          </div>
      </nav>
        <div class="right-menu">
          <button class="mobile-btn">
            <span></span>
            <span></span>
            <span></span>
          </button>
        </div>
      </header>
  </div>

  <script src="/static/js/header.js"></script>