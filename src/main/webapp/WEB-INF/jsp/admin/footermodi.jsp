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
<script>
    function doSave(){
        if (!confirm("수정하시겠습니까?")) {
            return false;
        }
        var form = jQuery('#footerForm')[0];
        var formData = new FormData(form);

        showHTML();
        formData.append("contents",document.getElementById("editorTxt").value);
        formData.append("contents2",document.getElementById("editorTxt2").value);

        $.ajax({
            url: "/api/footer/modify"
            , type: "POST"
            , processData: false
            , contentType: false
            , data: formData
            , success: function (data) {
                console.log("data :: " + data)
                if (data.return_code == 200) {
                    alert('수정되었습니다');
                    location.href = "/admin/footer/";
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

    let oEditors = []

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
                bSkipXssFilter: true,
            }, //boolean
        })
    }

    smartEditor2 = function () {
        console.log("Naver SmartEditor")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt2",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams: {
                SE_EditingAreaManager: {
                    sDefaultEditingMode: "HTMLSrc"  // 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter: true,
            }, //boolean
        })
    }

    $(document).ready(function () {
        $('.content-wrap').addClass('write');
        smartEditor();
        smartEditor2();

        setTimeout(function () {
            $('.langPanel').addClass('d-none');
            $('#Ko').removeClass('d-none');
        }, 2000);

        // 언어 탭 클릭 시 발생하는 이벤트
        $('body').on('click', '.tap a', function (event) {
            event.preventDefault();  // 기본 동작 방지 (페이지 이동 방지)

            let langType = $(this).attr("data-id");  // 클릭된 탭의 언어 타입

            $("#langType").val(langType);  // 숨겨진 input에 선택된 언어 타입을 저장

            // 모든 언어 패널을 숨김
            $('.langPanel').addClass('d-none');

            // 선택된 언어의 패널만 표시
            $('#' + langType).removeClass('d-none');
        });
    });

    function pasteHTML() {
        var sHTML = "";
        oEditors.getById["editorTxt"].exec("PASTE_HTML", [sHTML]);
    }

    function showHTML() {
        var sHTML = oEditors.getById["editorTxt"].getIR();
        //alert(sHTML);
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt2"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
    }

    function submitContents(elClickedObj) {
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
        oEditors.getById["editorTxt"].setDefaultFont(sDefaultFont, nFontSize);
        oEditors.getById["editorTxt2"].setDefaultFont(sDefaultFont, nFontSize);
    }
</script>
<div class="content">
    <div class="tap-wrap">
        <ul class="tap">
            <li class="tab_li active"><a href="#n" data-id="Ko">한국어</a></li>
            <li class="tab_li"><a href="#n" data-id="Eng">영어</a></li>
        </ul>
    </div>
    <div class="panel-wrap">
        <form id="footerForm" style="width:100%;">
            <input type="hidden" name="langType" id="langType" value="Ko" />
            <div class="out-box border-t-1">
                <div class="panel langPanel" id="Ko">
                    <div class="input-wrap type_content">
                        <label class="label" for="editorTxt">한글컨텐츠</label>
                        <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해주세요" style="width: 90%">
                            ${footerVo.contents}
                        </textarea>
                    </div>
                </div>
                <div class="panel langPanel" id="Eng">
                    <div class="input-wrap type_content">
                        <label class="label" for="editorTxt2">영문컨텐츠</label>
                        <textarea name="editorTxt2" id="editorTxt2" rows="20" cols="10" placeholder="내용을 입력해주세요" style="width: 90%">
                            ${footerVo.contents2}
                        </textarea>
                    </div>
                </div>
            </div>
            <div class="btn-box mt-30 txt-center">
                <button class="btn form-btn bg-deep-purple mr-10" type="button" onclick="doSave()">등록</button>
            </div>
        </form>
    </div>
</div>


</body>

</html>