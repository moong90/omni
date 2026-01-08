<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header.jsp"/>
<%
    String userId = "";
    session = request.getSession();
    if (session.getAttribute("loginId") != null) {
        userId = session.getAttribute("loginId").toString();
    }
%>
<script type="text/javascript">

    function doSave(user_id) {
        var parent = $('#parent').val();
        var seoUseYn = $('input[name=seoUseYn]:checked').val();

        var form = jQuery('#menuForm')[0];
        var formData = new FormData(form);

        showHTML();
        formData.append("seoYn",seoUseYn);
        formData.append("visualCode",document.getElementById("editorVisualTxt").value);
        formData.append("visualCode2",document.getElementById("editorVisualTxt2").value);
        formData.append("contents",document.getElementById("editorTxt").value);
        formData.append("contents2",document.getElementById("editorTxt2").value);
        
        for (let pair of formData.entries()) {
            console.log(pair[0] + ', ' + pair[1]); 
        }
        
        if (confirm("수정하시겠습니까?")) {
            $.ajax({
                url: "/api/menu/modify"
                , type: "POST"
                , processData: false
                , contentType: false
                , data: formData
                , success: function (data) {
                    console.log("data :: " + data)
                    if (data.return_code == 200) {
                        alert('수정되었습니다');
                        location.href = "/admin/menu/" + parent;
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
    }

    let oEditors = []
    
 // 한글 비주얼 코드 에디터
    smartEditorVis = function () {
        console.log("Naver SmartEditor")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorVisualTxt",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams: {
                SE_EditingAreaManager: {
                    sDefaultEditingMode: "HTMLSrc"  // 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }
    
    // 영문 비주얼 코드 에디터
    smartEditorVis2 = function () {
        console.log("Naver SmartEditor2")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorVisualTxt2",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams: {
                SE_EditingAreaManager: {
                    sDefaultEditingMode: "HTMLSrc"  // 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    smartEditor = function () {
        console.log("Naver SmartEditor")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams: {
                SE_EditingAreaManager: {
                    sDefaultEditingMode: "HTMLSrc"  // 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    smartEditor2 = function () {
        console.log("Naver SmartEditor2")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt2",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams : {
                SE_EditingAreaManager: {
                    sDefaultEditingMode : "HTMLSrc" // 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    $(document).ready(function () {
        $('.content-wrap').addClass('write');
        smartEditorVis();
        smartEditorVis2();
        smartEditor();
        smartEditor2();

        setTimeout(function () {
            $('.langPanel').addClass('d-none');
            $('#Ko').removeClass('d-none');
            $('.type_content').hide();
            $('.type_board').hide();
            $('.type_link').hide();

            let type_val = '${menuInfo.menuType}';
          switch (type_val){
            case "PAGE":
              $('.type_content').show();
              //pasteHTML();
              break;
            case "BOARD":
              $('.type_board').show();
              break;
            case "LINK":
              $('.type_link').show();
              break;
          }
        }, 2000);

        $('.type_change li').click(function(){
            if($(this).data("val") == "PAGE"){
                $('.type_content').show();
                $('.type_board').hide();
                $('.type_link').hide();
                $('#menu_type').val('PAGE');
            }else if($(this).data("val") == "BOARD"){
                $('.type_content').hide();
                $('.type_board').show();
                $('.type_link').hide();
                $('#menu_type').val('BOARD');
            }else if($(this).data("val") == "LINK" || $(this).data("val") == "ACTION"){
                $('.type_content').hide();
                $('.type_board').hide();
                $('.type_link').show();
                $('#menu_type').val($(this).data("val"));
            }
        });

        // 언어 탭 클릭시 값 세팅
        $(".langTabBtn").on("click", function () {
            let langType = $(this).attr("data-id");
            $("#langType").val(langType);
            
            // 모든 언어 패널을 숨김
            $('.langPanel').addClass('d-none');
            
            // 선택한 언어 패널만 표시
            $('#' + langType).removeClass('d-none');
            
            if (langType === "Ko") {
                $("#visualKo").removeClass('d-none');
                $("#visualEng").addClass('d-none');
            } else if (langType === "Eng") {
                $("#visualEng").removeClass('d-none');
                $("#visualKo").addClass('d-none');
            } else {
                $("#visualKo").addClass('d-none');
                $("#visualEng").addClass('d-none');
            }
        });

        // 보기 버튼 클릭 이벤트
        $(".preview").on("click", function () {
            $("#modal_contents").text($(this).attr("data-conts"));

            /**
             * >> 기능 : 히스토리 정보를 단건 조회.
             *
             * 현재는 히스토리 조회는 사용하지 않음. 필요시 주석 해제하고 사용하면 됨.
             */
        //     let seq = $(this).attr('data-seq');
        //     let data = {
        //         contentsHisSeq: seq
        //     };
        //
        //     $.ajax({
        //         url: "/api/menu/contents/getContentsHistoryInfo"
        //         , type: "POST"
        //         , processData: false
        //         , contentType: "application/json"
        //         , data: JSON.stringify(data)
        //         , success: function (data) {
        //             $("#modal_contents").html(data.contents);
        //         }
        //         , error: function (request, status, error) {
        //             if (request.status == 403) {
        //                 alert("로그인 정보가 없습니다.");
        //                 location.href = "/auth/login";
        //             }
        //             if (request.status == 400 || request.status == 500 || request.status == 503) {
        //                 alert("등록에 실패했습니다. 시스템관리자에게 문의해주세요.");
        //             }
        //         }
        //     });
        //
         });

        // 컨텐츠 히스토리 삭제
        $(".deleteBtn").on("click", function () {
            let menuSeq = $("#menu_seq").val();
            let seq = $(this).attr('data-seq');
            let data = {
                contentsHisSeq: seq
            };

            if (confirm("히스토리 정보를 삭제 하시겠습니까?")) {
                $.ajax({
                    url: "/api/menu/contents/deleteContentsHistory"
                    , type: "POST"
                    , processData: false
                    , contentType: "application/json"
                    , data: JSON.stringify(data)
                    , success: function (data) {
                        alert("삭제되었습니다.");
                        location.href = "/admin/menu/modify/"+menuSeq;
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
        });

    })

    function pasteHTML() {
        var sHTML = "";
        oEditors.getById["editorTxt"].exec("PASTE_HTML", [sHTML]);
    }

    function showHTML() {
        var sHTML = oEditors.getById["editorTxt"].getIR();
        //alert(sHTML);
        oEditors.getById["editorVisualTxt"].exec("UPDATE_CONTENTS_FIELD", []);  // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorVisualTxt2"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt2"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
    }

    function submitContents(elClickedObj) {
        oEditors.getById["editorVisualTxt"].exec("UPDATE_CONTENTS_FIELD", []);  // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorVisualTxt2"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt2"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
        // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

        try {
            elClickedObj.form.submit();
        } catch (e) {
        }
    }

    function setDefaultFont() {
        var sDefaultFont = '궁서';
        var nFontSize = 24;
        oEditors.getById["editorVisualTxt"].setDefaultFont(sDefaultFont, nFontSize);
        oEditors.getById["editorVisualTxt2"].setDefaultFont(sDefaultFont, nFontSize);
        oEditors.getById["editorTxt"].setDefaultFont(sDefaultFont, nFontSize);
        oEditors.getById["editorTxt2"].setDefaultFont(sDefaultFont, nFontSize);
    }


</script>
<div class="content">
    <div class="tap-wrap">
        <ul class="tap">
            <li class="tab_li active"><a href="#n" class="langTabBtn" data-id="Ko">한국어</a></li>
            <li class="tab_li"><a href="#n" class="langTabBtn" data-id="Eng">영어</a></li>
        </ul>
    </div>
    <div class="panel-wrap">
        <form id="menuForm" style="width:100%;">
            <input type="hidden" name="langType" id="langType" value="Ko" />

        <div class="out-box border-t-1">

<%--            <div class="input-wrap">--%>
<%--                <span class="label" for="seoUseYn01">페이지 SEO 사용여부</span>--%>
<%--                <div>--%>
<%--                    <label class="radio-wrap"><input class="radio-btn" type="radio" name="seoUseYn" id="seoUseYn01" value="Y" <c:if test="${menuInfo.seoYn == 'Y'}">checked="checked"</c:if>><span class="radio-label">사용</span></label>--%>
<%--                    <label class="radio-wrap"><input class="radio-btn" type="radio" name="seoUseYn" id="seoUseYn02" value="N" <c:if test="${menuInfo.seoYn == 'N'}">checked="checked"</c:if>><span class="radio-label">사용안함</span></label>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="input-wrap">--%>
<%--                <label class="label" for="seoTitle">TITLE</label>--%>
<%--                <input class="flex-1" type="text" name="seoTitle" id="seoTitle" value="${menuInfo.seoTitle}"/>--%>
<%--            </div>--%>

<%--            <div class="input-wrap">--%>
<%--                <label class="label" for="seoDesc">DESCRIPTION</label>--%>
<%--                <input class="flex-1" type="text" name="seoDesc" id="seoDesc" value="${menuInfo.seoDesc}"/>--%>
<%--            </div>--%>

<%--            <div class="input-wrap">--%>
<%--                <label class="label" for="seoKeyword">KEYWORD</label>--%>
<%--                <input class="flex-1" type="text" name="seoKeyword" id="seoKeyword" value="${menuInfo.seoKeyword}"/>--%>
<%--            </div>--%>

<%--            <div class="input-wrap">--%>
<%--                <label class="label" for="seoImg">IMG</label>--%>
<%--                <input class="flex-1" type="text" name="seoImg" id="seoImg" value="${menuInfo.seoImg}"/>--%>
<%--            </div>--%>

<%--            <div class="input-wrap" style="border-bottom: 3rem solid #e3e6e3 !important;">--%>
<%--                <label class="label" for="seoUrl">URL</label>--%>
<%--                <input class="flex-1" type="text" name="seoUrl" id="seoUrl" value="${menuInfo.seoUrl}"/>--%>
<%--            </div>--%>

            <div class="input-wrap">
                <label class="label" for="parent_name">메뉴코드</label>
                <input class="flex-1" type="text" name="menu_seq" id="menu_seq" value="${menuInfo.menuSeq}" readonly/>
            </div>

            <div class="input-wrap">
                <label class="label" for="parent_name">상위메뉴코드</label>
                <input class="flex-1" type="text" name="parent" id="parent" value="${menuInfo.parent}" readonly/>
            </div>

            <div class="input-wrap">
                <label class="label" for="parent_name">상위메뉴명</label>
                <input class="flex-1" type="text" name="parent_name" id="parent_name" value="${parentInfo.menuName}"
                       readonly/>
            </div>

            <div class="input-wrap">
                <label class="label" for="parent_name">depth</label>
                <input class="flex-1" type="text" name="depth" id="depth" value="${menuInfo.depth}" readonly/>
            </div>

            <div class="input-wrap">
                <label class="label" for="parent_name">level</label>
                <input class="flex-1" type="text" name="level" id="level" value="${menuInfo.level}" readonly/>
            </div>

            <div class="input-wrap">
                <label class="label" for="urlname">URL명</label>
                <input class="flex-1" type="text" name="urlname" id="urlname" value="${menuInfo.urlname}"/>
                <br>
                <span>* 띄워쓰기 없이 영문만</span>
            </div>

            <div class="input-wrap">
                <label class="label" for="menu_name">한글메뉴명</label>
                <input class="flex-1" type="text" name="menu_name" id="menu_name" value="${menuInfo.menuName}"/>
            </div>

            <div class="input-wrap">
                <label class="label">타입</label>
                <div class="select-box">
                    <input type="hidden" name="menu_type" id="menu_type" value="${menuInfo.menuType}">
                    <a class="select" href="#n">
                      <c:choose>
                        <c:when test="${menuInfo.menuType == 'PAGE'}">
                          페이지
                        </c:when>
                        <c:when test="${menuInfo.menuType == 'BOARD'}">
                          게시판
                        </c:when>
                        <c:when test="${menuInfo.menuType == 'ACTION'}">
                          개발
                        </c:when>
                        <c:when test="${menuInfo.menuType == 'LINK'}">
                          링크
                        </c:when>
                      </c:choose>
                    </a>
                    <ul class="option type_change">
                        <li data-val="PAGE"><a href="#n">페이지</a></li>
                        <li data-val="BOARD"><a href="#n">게시판</a></li>
                        <li data-val="ACTION"><a href="#n">개발</a></li>
                        <li data-val="LINK"><a href="#n">링크</a></li>
                    </ul>
                </div>
            </div>


            <div class="panel langPanel" id="visualKo">
                <div class="input-wrap">
                    <label class="label" for="editorVisualTxt">한글 Visual Code</label>
                    <textarea name="editorVisualTxt" id="editorVisualTxt" rows="20" cols="10" style="width: 90%">
                        ${menuInfo.visualCode}
                    </textarea>
                </div>
            </div>
            <div class="panel langPanel" id="visualEng">
                <div class="input-wrap">
                    <label class="label" for="editorVisualTxt2">영문 Visual Code</label>
                    <textarea name="editorVisualTxt2" id="editorVisualTxt2" rows="20" cols="10" style="width: 90%">
                        ${menuInfo.visualCode2}
                    </textarea>
                </div>
            </div>

            <div class="panel langPanel" id="Ko">
                <div class="input-wrap type_content">
                    <label class="label" for="editorTxt">한글컨텐츠</label>
                    <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해주세요"
                              style="width: 90%">
                        ${menuInfo.contents}
                    </textarea>
                </div>
            </div>
            <div class="panel langPanel" id="Eng">
                <div class="input-wrap">
                    <label class="label" for="menu_name_2">영어메뉴명</label>
                        <input class="flex-1" type="text" name="menu_name_2" id="menu_name_2" value="${menuInfo.menuName2}"/>
                </div>
                <div class="input-wrap type_content">
                    <label class="label" for="editorTxt2">영어컨텐츠</label>
                    <textarea name="editorTxt2" id="editorTxt2" rows="20" cols="10" placeholder="내용을 입력해주세요"
                              style="width: 90%">
                        ${menuInfo.contents2}
                    </textarea>
                </div>
            </div>

            <div class="input-wrap type_board">
                <label class="label">게시판선택</label>
                <div class="select-box">
                    <input type="hidden" name="category_seq" id="category_seq" value="${menuInfo.categorySeq}">
                    <a class="select" href="#n">
                        <c:forEach items="${boardList}" var="boardList" varStatus="status">
                            <c:if test="${boardList.categorySeq == menuInfo.categorySeq}">
                                ${boardList.name}
                            </c:if>
                        </c:forEach>
                    </a>
                    <ul class="option seq">
                        <c:forEach items="${boardList}" var="boardList" varStatus="status">
                            <li data-val="${boardList.categorySeq}"><a href="#n">${boardList.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="input-wrap type_link">
                <label class="label" for="link">외부링크</label>
                <input class="flex-1" type="text" name="link" id="link" value="${menuInfo.link}">
            </div>


            <div class="input-wrap">
                <label class="label">사용유무</label>
                <div class="select-box">
                    <input type="hidden" name="use_yn" id="use_yn" value="${menuInfo.useYn}">
                    <a class="select" href="#n">
                      <c:choose>
                        <c:when test="${menuInfo.useYn == 'Y'}">
                          사용
                        </c:when>
                        <c:when test="${menuInfo.useYn == 'N'}">
                          숨김
                        </c:when>
                      </c:choose>
                    </a>
                    <ul class="option">
                        <li data-val="Y"><a href="#n">사용</a></li>
                        <li data-val="N"><a href="#n">숨김</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="btn-box mt-30 txt-center">
            <button class="btn form-btn bg-deep-purple mr-10" type="button" onclick="doSave()">저장</button>
            <button class="btn form-btn bg-black" type="button" onclick="javascript:history.back();">뒤로</button>
        </div>
    </form>
    </div>

    <div class="relative mt30 mb50">
        <div class="table-wrap">
            <div class="table border-t-1">
                <table class="t-type-01">
                    <colgroup>
                        <col style="width: 10%">
                        <col style="width: 30%">
                        <col style="width: 20%">
                        <col style="width: 20%">
                        <col style="width: 20%">
                    </colgroup>
                    <thead>
                    <tr class="bg-white">
                        <th scope="col">NO</th>
                        <th scope="col">히스토리 등록일</th>
                        <th scope="col">수정언어</th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty contsList}">
                            <tr>
                                <td colspan="5">히스토리 내역이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${contsList}" var="list" varStatus="status">
                                <tr>
                                    <th scope="row">${status.count}</th>
                                    <td>${list.regDate}</td>
                                    <td>${list.langName}</td>
                                    <td>
                                        <a class="modal-open-btn btn table-btn bg-purple preview" data-id="modalView"
                                           data-conts="<c:out value="${list.contents}" escapeXml="true" />"
                                           data-seq="${list.contentsHisSeq}" href="#n">보기</a>
                                    </td>
                                    <td>
                                        <a class="btn table-btn bg-purple deleteBtn" data-seq="${list.contentsHisSeq}" href="#n">삭제</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!--모달-->
<div class="modal-wrap d-none">
    <div id="modalView" class="modal wid-740">
        <h3 class="t-title">
            컨텐츠 내용
        </h3>
        <button class="modal-close absolute right20 top-20">
            <img src="/static/admin/assets/img/icon/close-btn.png" alt="닫기" />
        </button>
        <form>
            <div class="table-wrap z-index20">
                <table class="table t-type-02  td-bl td-br">
                    <colgroup>
                        <col width="100%">
                    </colgroup>
                    <tbody class="t-pl-60 txt-left">
                        <tr>
                            <td id="modal_contents"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</div>

</body>

</html>
<!--메뉴등록-->
<!-- 모달 -->


