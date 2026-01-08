<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<ul>
<c:set var="prevLvl" value="1"/>
<c:set var="prevParent" value="0"/>

<c:forEach items="${menuTreeList}" var="menu" varStatus="status">
    
    <!-- ROOT 노드 -->
    <c:if test="${menu.parent == 0}">
        <li>
            <a class="dep-01" href="/admin/menu/1">
                <span>Home</span>
            </a>
        </li>
    </c:if>
    
    <!-- LVL 2: 최상위 메뉴 -->
    <c:if test="${menu.lvl == 2}">
        <!-- 이전 레벨 닫기 -->
        <c:if test="${prevLvl == 3}">
            </ul></li>
        </c:if>
        <c:if test="${prevLvl == 4}">
            </ul></li></ul></li>
        </c:if>
        <c:if test="${prevLvl == 2 && prevParent != menu.parent}">
            </li>
        </c:if>
        
        <li>
            <div class="dep-01">
                <a href="/admin/menu/${menu.menuSeq}">
                    <span>${menu.menuName}</span>
                </a>
                <button type="button"></button>
            </div>
    </c:if>
    
    <!-- LVL 3: 2depth 메뉴 -->
    <c:if test="${menu.lvl == 3}">
        <!-- 이전에 lvl 4가 있었다면 닫기 -->
        <c:if test="${prevLvl == 4}">
            </ul></li>
        </c:if>
        
        <!-- 첫 번째 lvl 3 항목이면 ul 열기 -->
        <c:if test="${prevLvl == 2}">
            <ul class="dep-02">
        </c:if>
        
        <li <c:if test="${menu.childCnt > 0}">class="folder"</c:if>>
            <a href="javascript:goMove('${menu.menuSeq}')">${menu.menuName}</a>
    </c:if>
    
    <!-- LVL 4: 3depth 메뉴 -->
    <c:if test="${menu.lvl == 4}">
        <!-- 첫 번째 lvl 4 항목이면 ul 열기 -->
        <c:if test="${prevLvl == 3}">
            <ul class="dep-03">
        </c:if>
        
        <li>
            <a href="/admin/menu/modify/${menu.menuSeq}">${menu.menuName}</a>
        </li>
    </c:if>
    
    <!-- 현재 레벨 저장 -->
    <c:set var="prevLvl" value="${menu.lvl}"/>
    <c:set var="prevParent" value="${menu.parent}"/>
    
</c:forEach>

<!-- 마지막 닫는 태그들 -->
<c:if test="${prevLvl == 4}">
    </ul></li>
</c:if>
<c:if test="${prevLvl >= 3}">
    </ul></li>
</c:if>
<c:if test="${prevLvl == 2}">
    </li>
</c:if>

</ul>
<script type="text/javascript">

    function goMove(seq) {
        if (confirm("하위메뉴를 생성하시겠습니까?")) {
            location.href = "/admin/menu/" + seq;
        } else {
            location.href = "/admin/menu/modify/" + seq;
        }
    }

    $(document).ready(function () {
         $('.menu-tree .dep-02').css("display", "none");
         //메뉴 트리
         $('.menu-tree .dep-01 button').click(function (e) {
             e.stopPropagation();
             $(this).closest('li').toggleClass('on').find('.dep-02').slideToggle(600);
         });
        
         $('.dep-02 li').click(function () {
             $('.dep-02 li').removeClass('on');
             $(this).addClass('on').siblings().removeClass('on');
         })
    });

</script>