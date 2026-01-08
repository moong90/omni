<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header.jsp"/>
<script type="text/javascript">
  function doSave() {
    var form = jQuery("#writeForm")[0];
    var formData = new FormData(form);
    
    formData.append("content2",document.getElementById("content2").value);
    
    for (let pair of formData.entries()) {
        console.log(pair[0] + ', ' + pair[1]); 
    }
    
    if (!confirm("저장하시겠습니까?")) {
      return false;
    }
    
    $.ajax({
        url: "/api/admin/inquiry/saveAnswer"
        , type: "POST"
        , processData: false
        , contentType: false
        , data: formData
        , success: function (data) {
            if (data.return_code == 200) {
                alert("등록 완료되었습니다.");
                location.href = "/admin/inquiryList";
            } else {
                alert(data.return_message);
            }
        }
        , error: function (request, status, error) {
            if (request.status == 403) {
                alert("로그인 정보가 없습니다.");
                location.href = "/auth/login";
            }
            if (request.status == 400 || request.status == 500 || request.status == 503) {
                alert("등록에 실패했습니다. 시스템관리자에게 문의해주세요.");
            }
        }
    });
  }

</script>
<div class="content">
    <div class="out-box border-t-1">
        <c:if test="${not empty response.name}">
	        <div class="input-wrap">
	            <label class="label">이름</label>
	                ${response.name}
	        </div>
        </c:if>
        <c:if test="${not empty response.email}">
	        <div class="input-wrap">
	            <label class="label">이메일</label>
	                ${response.email}
	        </div>
        </c:if>
        <c:if test="${not empty response.type}">
	        <div class="input-wrap">
	            <label class="label">타입</label>
	                ${response.type}
	        </div>
        </c:if>
        <c:if test="${not empty response.fileName}">
            <div class="input-wrap">
              <span class="label">첨부파일</span>
              <a href="/resources/upload/${response.fileName}" role="button" download="${response.orgName}" class="file">${response.orgName}</a>
            </div>
        </c:if>
        <c:if test="${not empty response.tel}">
            <div class="input-wrap">
                <label class="label">연락처</label>
                   ${response.tel}
            </div>
        </c:if>
        <c:if test="${not empty response.subject}">
            <div class="input-wrap">
                <label class="label">제목</label>
                    ${response.subject}
            </div>
        </c:if>
        <div class="input-wrap">
            <label class="label">문의내용</label>
            <textarea rows="10" style="width: 90%" readonly>${response.content}</textarea>
        </div>
        <div class="input-wrap">
            <label class="label">문의처리상태</label>
            <textarea rows="3" style="width: 90%" name="content2" id="content2">${response.content2}</textarea>
        </div>
   </div>
   <form id="writeForm">
	   <input type="hidden" name="seq" id="seq" value="${response.seq}">
	   <div class="btn-box mt-30 txt-center">
	        <button class="btn form-btn bg-black" type="button" onclick="javascript:history.back();">목록</button>
	        <button class="btn form-btn bg-purple" type="button" onclick="doSave()">문의처리</button>
	   </div>
   </form>
</div>
<!-- // content -->

</body>

</html>
