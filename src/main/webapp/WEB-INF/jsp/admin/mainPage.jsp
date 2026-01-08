<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header.jsp"/>

<script type="text/javascript">

    function doSave(user_id) {

        var form = jQuery('#menuForm')[0];
        var formData = new FormData(form);

        if (!confirm("저장하시겠습니까?")) {
            return false;
        }

        showHTML();
        formData.append("contents",document.getElementById("editorTxt").value);
        formData.append("contents2",document.getElementById("editorTxt2").value);
        // formData.append("contents3",document.getElementById("editorTxt3").value);

        $.ajax({
            url: "/api/menu/main/save"
            , type: "POST"
            , processData: false
            , contentType: false
            , data: formData
            , success: function (data) {
                console.log("data :: " + data)
                if (data.return_code == 200) {
                    alert('수정되었습니다');
                    location.href = "/admin/mainPage";
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
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams: {
                SE_EditingAreaManager: {
                    sDefaultEditingMode: "HTMLSrc"	// 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    smartEditor2 = function () {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt2",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams : {
                SE_EditingAreaManager: {
                    sDefaultEditingMode : "HTMLSrc"	// 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    smartEditor3 = function () {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt3",
            sSkinURI: "/static/smarteditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2",
            htParams : {
                SE_EditingAreaManager: {
                    sDefaultEditingMode : "HTMLSrc"	// 로딩 시 디폴트 편집 모드를 설정 Editor 모드 : WYSIWYG, HTML 모드 : HTMLSrc, TEXT 모드 : TEXT
                },
                bSkipXssFilter : true,
            }, //boolean
        })
    }

    $(document).ready(function () {
        $('.content-wrap').addClass('write');
        smartEditor();
        smartEditor2();
        // smartEditor3();

        setTimeout(function () {
            $('.langPanel').addClass('d-none');
            $('#Ko').removeClass('d-none');
            // $('.type_content').show();
        }, 1000);

    })

    function pasteHTML() {
        var sHTML = "";
        oEditors.getById["editorTxt"].exec("PASTE_HTML", [sHTML]);
    }

    function showHTML() {
        var sHTML = oEditors.getById["editorTxt"].getIR();
        //alert(sHTML);
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt2"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        // oEditors.getById["editorTxt3"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
    }

    function submitContents(elClickedObj) {
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt2"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        // oEditors.getById["editorTxt3"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
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
        // oEditors.getById["editorTxt3"].setDefaultFont(sDefaultFont, nFontSize);
    }


</script>

<div class="content">
    <div class="tap-wrap">
        <ul class="tap">
            <li class="tab_li active"><a href="#n" data-id="Ko">한국어</a></li>
            <li class="tab_li"><a href="#n" data-id="Eng">영어</a></li>
            <%--            <li class="tab_li"><a href="#n" data-id="#Vt">베트남어</a></li>--%>
        </ul>
    </div>
    <div class="panel-wrap">
        <form id="menuForm" style="width:100%;">

            <div class="out-box border-t-1">

                <div class="panel langPanel" id="Ko">
                    <div class="input-wrap type_content">
                        <label class="label" for="editorTxt">한글컨텐츠</label>
                        <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해주세요"
                                  style="width: 90%">
                            ${res.contents}
                        </textarea>
                    </div>
                </div>
                <div class="panel langPanel" id="Eng">
                    <div class="input-wrap type_content">
                        <label class="label" for="editorTxt2">영어컨텐츠</label>
                        <textarea name="editorTxt2" id="editorTxt2" rows="20" cols="10" placeholder="내용을 입력해주세요"
                                  style="width: 90%">
                            ${res.contentsEng}
                        </textarea>
                    </div>
                </div>
<%--                <div class="panel" id="Vt"><!--23.11.03 탭 콘텐츠-->--%>
<%--                    <div class="input-wrap type_content">--%>
<%--                        <label class="label" for="editorTxt3">베트남어컨텐츠</label>--%>
<%--                        <textarea name="editorTxt3" id="editorTxt3" rows="20" cols="10" placeholder="내용을 입력해주세요"--%>
<%--                                  style="width: 90%">--%>
<%--                            ${menuInfo.contentsVt}--%>
<%--                        </textarea>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
            <div class="btn-box mt-30 txt-center">
                <button class="btn form-btn bg-deep-purple mr-10" type="button" onclick="doSave()">저장</button>
            </div>
        </form>
    </div>
</div>


</body>

</html>
<!--메뉴등록-->
<!-- 모달 -->


