<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header.jsp"/>
<script type="text/javascript">
    $(document).ready(function () {
    })
</script>
<div class="content">
    <!-- table-wrap -->
    <div class="table-wrap">
        <div class="table-top">
            <div class="case">
                총 <span class="num">${fn:length(response.list)}</span>개
            </div>
        </div>
        <div class="table border-t-1">
            <table class="t-type-01">
                <colgroup>
                    <col style="width: 5%">
                    <col style="width: 10%">
                    <col style="width: 15%">
                    <col style="width: 15%">
                    <col style="width: 10%">
                    <col style="width: 15%">
                    <col style="width: 15%">
                </colgroup>
                <thead>
                <tr class="bg-white">
                    <th scope="col">
                        <input id="check_all" type="checkbox">
                        <label for="check_all"></label>
                    </th>
                    <th scope="col">NO</th>
                    <th scope="col">제목</th>
                    <th scope="col">이름</th>
                    <th scope="col">이메일</th>
                    <th scope="col">처리상태</th>
                    <th scope="col">등록일</th>
                </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty response.list}">
                            <tr>
                                <th colspan="6">데이터가 없습니다.</th>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${response.list}" var="list" varStatus="status">
                                <tr>
                                    <th class="line-ch" scope="row">
                                        <input id="tr-${status.count}" type="checkbox" name="list_check" value="${list.seq}">
                                        <label for="tr-${status.count}"></label>
                                    </th>
                                    <c:choose>
                                        <c:when test="${not empty param.page}">
                                            <td>${(param.page - 1) * (param.recordSize != null ? param.recordSize : 10) + status.count}</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${status.count}</td>
                                        </c:otherwise>
                                    </c:choose> 
                                    <td><a href="/admin/inquiryView/${list.seq}">${list.subject}</a></td>
                                    <td><a href="/admin/inquiryView/${list.seq}">${list.name}</a></td>
                                    <td><a href="/admin/inquiryView/${list.seq}">${list.email}</a></td>
                                    <td>
	                                    <c:choose>
							                 <c:when test="${empty list.content2}"><a href="/admin/inquiryView/${list.seq}" style="color: #58d68d; font-weight: bold;">처리 대기중</a></c:when>
							                 <c:otherwise><a href="/admin/inquiryView/${list.seq}" style="color: #5dade2; font-weight: bold;">처리 완료</a></c:otherwise>
							            </c:choose>
                                    </td>
                                    <td>${list.regDate}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <div class="btn-box mt-10">
            <button class="btn table-btn bg-deepgray" type="button" id="deleteSelect">선택삭제</button>
        </div>
        <!--pagination-->
        <div class="pagination">
            <a class="btn start" href="javascript:void(0);" onclick="movePage(1)"><img src="/static/admin/assets/img/icon/start-btn.png" alt="첫페이지"></a>
            <c:choose>
                <c:when test="${response.pagination.existPrevPage eq false}">
                    <a class="btn prev" href="javascript:void(0);">
                        <img src="/static/admin/assets/img/icon/prev-page.png" alt="이전페이지">
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="btn prev" href="javascript:void(0);" onclick="movePage(${response.pagination.startPage - 1})">
                        <img src="/static/admin/assets/img/icon/prev-page.png" alt="이전페이지">
                    </a>
                </c:otherwise>
            </c:choose>
            <div class="page">
                <c:forEach var="num" begin="${response.pagination.startPage}" end="${response.pagination.endPage}" step="1">
                    <c:choose>
                        <c:when test="${empty param.page}">
                                <a <c:if test="${num == 1}">class="on"</c:if> href="javascript:void(0);" onclick="movePage(${num});">
                                        <span>${num eq 0 ? 1 : num}</span>
                                </a>
                        </c:when>
                        <c:otherwise>
                                <a <c:if test="${num == param.page}">class="on"</c:if> href="javascript:void(0);" onclick="movePage(${num});">
                                        <span>${num eq 0 ? 1 : num}</span>
                                </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <c:choose>
                <c:when test="${response.pagination.existNextPage eq false}">
                    <a class="btn start" href="javascript:void(0);">
                        <img src="/static/admin/assets/img/icon/next-page.png" alt="다음페이지">
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="btn start" href="javascript:void(0);" onclick="movePage(${response.pagination.endPage + 1});">
                        <img src="/static/admin/assets/img/icon/next-page.png" alt="다음페이지">
                    </a>
                </c:otherwise>
            </c:choose>
            <a class="btn endt" href="javascript:void(0);" onclick="movePage(${response.pagination.totalPageCount});"><img src="/static/admin/assets/img/icon/end.png" alt="끝페이지"></a>
        </div>
        <!--pagination-->
    </div>
    <!-- // table-wrap-->

</div>
<!-- // content -->
</div>
<!-- // content-wrap -->

</div>
<!-- // site-wrap -->
<script>
	$('#check_all').on('click',function(){
	    if($("#check_all").is(":checked")){
	        $("input:checkbox[name=list_check]").prop("checked",true);
	    }else{
	        $("input:checkbox[name=list_check]").prop("checked",false);
	    }
	});
	
	$('#deleteSelect').on('click', function(){
	    var items = [];
	    $('input:checkbox[name=list_check]:checked').each(function () {
	        items.push(parseInt($(this).val()));
	    });
	    console.log("Selected items:", items);
	
	    if(items.length == 0){
	        alert('선택된 내역이 없습니다.');
	        return false;
	    }
	
	    if (confirm('정말 삭제하겠습니까?')) {
	        $.ajax({
	            url: "/api/board/deleteInquiry",
	            type: 'POST',
	            dataType: "json",
	            traditional: true,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            data: $.param({ seq: items }),
	            success: function(data) {
	                if (data.return_code === 200) {
	                    alert('삭제되었습니다');
	                    location.href = "/admin/inquiryList";
	                }
	            },
	            error: function(request, status, error) {
	                if (request.status === 403) {
	                    alert("로그인 정보가 없습니다.");
	                    location.href = "/auth/login";
	                }
	                if (request.status === 400 || request.status === 500 || request.status === 503) {
	                    alert("삭제에 실패했습니다. 시스템관리자에게 문의해주세요.");
	                }
	            }
	        });
	    } else {
	        return false;
	    }
	});
	
	function movePage(page) {
        // 이벤트를 통해 전달받는 page(페이지 번호)를 기준으로 객체 생성
        const queryParams = {
            page: (page) ? page : 1,
            recordSize: 10,
            pageSize: 20
        }
        location.href = location.pathname + '?' + new URLSearchParams(queryParams).toString();
    }
</script>
</body>

</html>