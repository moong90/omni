<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header_v2.jsp"/>


<div class="content">

<!-- table-wrap -->
    <div class="page-table-header">
        <div>메뉴</div>
        <div>상태</div>
        <div>등록일</div>
        <div>최종수정일</div>
        <div>처리</div>
    </div>
    <ul class="page-list">
    <c:set var="cnt" value="0" />
    <c:set var="depth" value="0" />
    <c:set var="parent" value="0" />
    <c:forEach items="${menuTreeList}" var="list" varStatus="status">
        <c:if test="${list.useYn=='Y'}">
            <c:if test="${depth == 2 &&  list.depth == 1}">
                </div>
            </c:if>
            <c:if test="${depth == 2 &&  list.depth == 2}">
                </div>
            </c:if>
            <c:if test="${depth == 3 &&  list.depth != 3}">
                    </div>
                </div>
            </c:if>
            <c:if test="${list.lvl == 2}">
                <c:choose>
                    <c:when test="${parent == 1 && list.parent == 1}">
                            </div>
                        </li>
                    </c:when>
                    <c:when test="${list.lvl == 2 && list.level > 1}">
                            </div>
                        </li>
                    </c:when>
                </c:choose>
                <c:set var="cnt" value="${cnt + 1}" />
                <li class="g-menu-0${status.count} menu-wrap page-depth-wrap">
                    <div class="page-depth <c:if test="${list.childCnt > 0}">dep-true</c:if> page-dep-01">
                        <div class="page-wrap">
                            <div class="btn-box">
                                <c:choose>
                                    <c:when test="${list.menuName ne 'Notice'}">
                                            <button class="btn list-open-btn" type="button"></button>
                                    </c:when>
                                </c:choose>
                            </div>
                            <div class="tit">
                                <span>${list.menuName}</span>
                            </div>
                            <div class="visible">
                                <input id="visible-${status.count}" type="checkbox" checked>
                                <label for="visible-${status.count}"></label>
                            </div>
                            <div>${list.regDate}</div>
                            <div>${list.modiDate eq '' || empty list.modiDate ? '-' : list.modiDate}</div>
                            <div>
                                <a class="btn table-btn bg-deepgray" href="/omnifit/${list.parentUrlname}/${list.urlname}" target="_blank">바로가기</a>
                            </div>
                        </div>
            </c:if>
            <c:if test="${list.lvl == 3 && list.level == 1}">
                <div class="page-depth-wrap">
                    <div class="page-depth <c:if test="${list.childCnt > 0}">dep-true</c:if> page-dep-02">
                        <div class="page-wrap">
                            <div class="btn-box">
                                <button class="btn list-open-btn" type="button"></button>
                            </div>
                            <div class="tit">${list.menuName}</div>
                            <div class="visible">
                                <input id="visible-${status.count}" type="checkbox" checked>
                                <label for="visible-${status.count}"></label>
                            </div>
                            <div>${list.regDate}</div>
                            <div>${list.modiDate eq '' || empty list.modiDate ? '-' : list.modiDate}</div>
                            <div>
                                <a class="btn table-btn bg-deepgray" href="/omnifit/${list.parentUrlname}/${list.urlname}" target="_blank">바로가기</a>
                                <a class="btn table-btn bg-purple" href="/admin/pageModify/${list.menuSeq}">수정하기</a>
                            </div>
                        </div>
            </c:if>
            <c:if test="${list.lvl == 3 && list.level != 1}">
                <div class="page-depth <c:if test="${list.childCnt > 0}">dep-true</c:if> page-dep-02">
                    <div class="page-wrap">
                        <div class="btn-box">
                            <button class="btn list-open-btn" type="button"></button>
                        </div>
                        <div class="tit">${list.menuName}</div>
                        <div class="visible">
                            <input id="visible-08" type="checkbox" checked>
                            <label for="visible-08"></label>
                        </div>
                        <div>${list.regDate}</div>
                        <div>${list.modiDate eq '' || empty list.modiDate ? '-' : list.modiDate}</div>
                        <div>
                            <a class="btn table-btn bg-deepgray" href="/omnifit/${list.parentUrlname}/${list.urlname}" target="_blank">바로가기</a>
                            <a class="btn table-btn bg-purple" href="/admin/pageModify/${list.menuSeq}">수정하기</a>
                        </div>
                    </div>
            </c:if>

            <c:if test="${list.lvl == 4 && list.level == 1}">
                <div class="page-depth-wrap">
                    <div class="page-depth <c:if test="${list.childCnt > 0}">dep-true</c:if> page-dep-03">
                        <div class="page-wrap">
                            <div class="btn-box">
                                <button class="btn list-open-btn" type="button"></button>
                            </div>
                            <div class="tit">${list.menuName}</div>
                            <div class="visible">
                                <input id="visible-${status.count}" type="checkbox" checked>
                                <label for="visible-${status.count}"></label>
                            </div>
                            <div>${list.regDate}</div>
                            <div>${list.modiDate eq '' || empty list.modiDate ? '-' : list.modiDate}</div>
                            <div>
                                <a class="btn table-btn bg-deepgray" href="/omnifit/${list.parentUrlname}/${list.urlname}" target="_blank">바로가기</a>
                                <a class="btn table-btn bg-purple" href="/admin/pageModify/${list.menuSeq}">수정하기</a>
<%--                                <a class="btn table-btn bg-black" href="#n" role="button">삭제</a>--%>
                            </div>
                        </div>
                        </div>
            </c:if>
            <c:if test="${list.lvl == 4 && list.level != 1}">
                <div class="page-depth <c:if test="${list.childCnt > 0}">dep-true</c:if> page-dep-03">
                <div class="page-wrap">
                    <div class="btn-box">
                        <button class="btn list-open-btn" type="button"></button>
                    </div>
                    <div class="tit">${list.menuName}</div>
                    <div class="visible">
                        <input id="visible-04" type="checkbox" checked>
                        <label for="visible-04"></label>
                    </div>
                    <div>${list.regDate}</div>
                    <div>${list.modiDate eq '' || empty list.modiDate ? '-' : list.modiDate}</div>
                    <div>
                        <a class="btn table-btn bg-deepgray" href="/omnifit/${list.parentUrlname}/${list.urlname}" target="_blank">바로가기</a>
                        <a class="btn table-btn bg-purple" href="/admin/pageModify/${list.menuSeq}">수정하기</a>
<%--                        <a class="btn table-btn bg-black" href="#n" role="button">삭제</a>--%>
                    </div>
                </div>
                </div>
            </c:if>
            <c:if test="${status.last}">
                </div>
                </li>
            </c:if>
            <c:set var="depth" value="${list.depth}" />
            <c:set var="parent" value="${list.parent}" />
        </c:if>
    </c:forEach>
    </ul>
</div>