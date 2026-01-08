<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header_v2.jsp"/>
<script type="text/javascript">
	$(document).ready(function () {
	    smartEditorVis();
	    smartEditor();
	});

    let oEditors = []

    // 비주얼 코드 에디터
    smartEditorVis = function () {
        console.log("Naver SmartEditor")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorVisualTxt",
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

    // 컨텐츠 에디터
    smartEditor = function () {
        console.log("Naver SmartEditor")
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt",
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

    function pasteHTML() {
        var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
        oEditors.getById["editorTxt"].exec("PASTE_HTML", [sHTML]);
    }

    function showHTML() {
        var sHTML = oEditors.getById["editorTxt"].getIR();
        //alert(sHTML);
        oEditors.getById["editorVisualTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
    }

    function submitContents(elClickedObj) {
        oEditors.getById["editorVisualTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
        try {
            elClickedObj.form.submit();
        } catch (e) {
        }
    }

    function setDefaultFont() {
        var sDefaultFont = '궁서';
        var nFontSize = 24;
        oEditors.getById["editorVisualTxt"].setDefaultFont(sDefaultFont, nFontSize);
        oEditors.getById["editorTxt"].setDefaultFont(sDefaultFont, nFontSize);
    }
</script>
<div class="content">
  <div class="panel-wrap">
    <form id="menuForm" style="width:100%;">
      <div class="out-box border-t-1">
        <div class="input-wrap">
          <span class="label">언어 선택</span>
          <div>
            <label class="radio-wrap">
                <input class="radio-btn" type="radio" name="langType" id="kor" value="KOR" <c:if test="${menuVo.langType == 'KOR'}">checked="checked"</c:if>><span class="radio-label">국문</span>
            </label>
            <label class="radio-wrap">
              <input class="radio-btn" type="radio" name="langType" id="eng" value="ENG" <c:if test="${menuVo.langType == 'ENG'}">checked="checked"</c:if>><span class="radio-label">영문</span>
            </label>
          </div>
        </div>
        <div class="panel" id="Visual">
          <input type="hidden" name="parent" id="parent" value="${menuVo.parent}">
          <input type="hidden" name="depth" id="depth" value="${menuVo.depth}">
          <input type="hidden" name="menuSeq" id="menuSeq" value="${menuVo.menuSeq}">
          <div class="out-box border-t-0">
<%--            <div class="input-wrap">--%>
<%--              <div class="input-group">--%>
<%--                <label class="label" for="parent_name">1차 메뉴</label>--%>
<%--                <input class="flex-1" type="text" name="parent_name1" id="parent_name" value="ABOUT"--%>
<%--                       readonly="readonly">--%>
<%--              </div>--%>
<%--              <div class="input-group">--%>
<%--                <label class="label" for="parent_name">2차 메뉴</label>--%>
<%--                <input class="flex-1" type="text" name="parent_name2" id="parent_name" value="-"--%>
<%--                       readonly="readonly">--%>
<%--              </div>--%>
<%--            </div>--%>
            <div class="input-wrap">
              <label class="label" for="urlname">페이지명</label>
              <input class="flex-1 mr-10" type="text" name="urlname" id="urlname" value="${menuVo.menuName}" readonly="readonly">
            </div>
            <div class="input-wrap">
              <label class="label" for="editorVisualTxt">Visual Code</label>
              <textarea name="editorVisualTxt" id="editorVisualTxt" rows="20" cols="10" style="width: 90%">${menuVo.visualCode}</textarea>
            </div>
          </div>
          <div class="panel" data-lang="kor">
            <div class="input-wrap type_content">
              <label class="label" for="editorTxt">컨텐츠</label>
              <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해주세요" style="width: 90%">${menuVo.contents}</textarea>
            </div>
          </div>
          <div class="input-wrap">
            <label class="label">사용유무</label>
            <div class="select-box">
              <select class="select" name="useYn" id="useYn">
                <option value="Y" <c:if test="${menuVo.useYn == 'Y'}">selected</c:if>>사용</option>
                <option value="N" <c:if test="${menuVo.useYn == 'N'}">selected</c:if>>숨김</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div class="btn-box mt-30 txt-center">
        <button class="btn form-btn bg-deep-purple mr-10" type="button" onclick="doSave()">저장</button>
        <button class="btn form-btn bg-black" type="button" onclick="javascript:history.back();">뒤로</button>
      </div>
    </form>
  </div>
</div>

<script type="text/javascript">

    function doSave() {
    	oEditors.getById["editorVisualTxt"].exec("UPDATE_CONTENTS_FIELD", []);
        oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
        
        let menuSeq = $("#menuSeq").val();
        let langType = $('input[name=langType]:checked').val();
        let useYn = $("#useYn").val();
        let editorVisualTxt = document.getElementById("editorVisualTxt").value
        let editorTxt = document.getElementById("editorTxt").value

        let jsonData =  {
            menuSeq: menuSeq,
            langType: langType,
            useYn: useYn,
            contents: editorTxt,
            visualCode: editorVisualTxt
        }

        console.log("jsonData ::: " + JSON.stringify(jsonData));

        if (!confirm("컨텐츠를 저장하시겠습니까?")) {
            return false;
        }

        $.ajax({
            url: "/api/menu/contents/save/"
            , type: "POST"
            , processData: false
            , contentType: "application/json"
            , dataType: "json"
            , data: JSON.stringify(jsonData)
            , success: function (data) {

                console.log("data :: " + data)

                if (data.return_code == 200) {
                    alert('저장되었습니다');
                    location.href = "/admin/pageModify/"+menuSeq;
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