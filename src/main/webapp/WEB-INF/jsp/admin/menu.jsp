<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/admin/include/header_v2.jsp"/>

<script type="text/javascript">
    function childMenuCall(menuSeq) {
        // 클릭된 1Depth SEQ 세팅
        $("#1dmenuSeq").val(menuSeq);

        $.ajax({
            url: "/api/menu/childMenu/"+menuSeq
            , type: "POST"
            , success: function (data) {

                let html = "";

                $.each(data, function(index, item) {
                    html += '<tr>';
                    html += '   <td>';

                    if (item.useYn == 'Y') {
                        html += '       <div class="visible-f v-show">사용</div>';
                    } else {
                        html += '       <div class="visible-f v-hid">숨김</div>';
                    }

                    html += '   </td>';
                    html += '   <td><a href="#n" onclick="javascript:thirdChildMenuCall(\''+item.menuSeq+'\');">'+item.menuName+'</a></td>';
                    html += '   <td>';
                    html += '       <a class="btn icon-btn" href="javascript:levelUp(\''+item.menuSeq+'\', \''+item.parent+'\', \''+item.level+'\');"><img src="/static/admin/assets/img/icon/up2.png" alt="위"></a>';
                    html += '       <a class="btn icon-btn" href="javascript:levelDown(\''+item.menuSeq+'\', \''+item.parent+'\', \''+item.level+'\');"><img src="/static/admin/assets/img/icon/down2.png" alt="아래"></a>';
                    html += '       <button class="btn panel-open-btn table-btn bg-purple" onclick="javascript:getModifyData(\''+item.menuSeq+'\');">수정</button>';
                    html += '       <button class="btn table-btn bg-deepgray" onclick="javascript:getDeleteData(\''+item.menuSeq+'\');">삭제</button>';
                    html += '   </td>';
                    html += '</tr>';
                });

                // console.log("data ::::::: " + JSON.stringify(data));/

                $("#2depth").html(html);

            }
            , error: function (request, status, error) {
                if (request.status == 400 || request.status == 500 || request.status == 503) {
                    alert("메뉴를 불러오는 도중에 에러가 발생하였습니다.");
                }
            }
        });
    }

    function thirdChildMenuCall(menuSeq) {

        // 클릭된 2Depth SEQ 세팅
        $("#2dmenuSeq").val(menuSeq);

        $.ajax({
            url: "/api/menu/childMenu/"+menuSeq
            , type: "POST"
            , success: function (data) {

                if (data == null || data == "" || data.lenght == 0) {

                    alert("하위메뉴가 없습니다.");
                    return false;

                } else {

                    let html = "";

                    $.each(data, function(index, item) {
                        html += '<tr>';
                        html += '   <td>';

                        if (item.useYn == 'Y') {
                            html += '       <div class="visible-f v-show">사용</div>';
                        } else {
                            html += '       <div class="visible-f v-hid">숨김</div>';
                        }

                        html += '   </td>';
                        html += '   <td>'+item.menuName+'</td>';
                        html += '   <td>';
                        html += '       <a class="btn icon-btn" href="javascript:levelUp(\''+item.menuSeq+'\', \''+item.parent+'\', \''+item.level+'\');"><img src="/static/admin/assets/img/icon/up2.png" alt="위"></a>';
                        html += '       <a class="btn icon-btn" href="javascript:levelDown(\''+item.menuSeq+'\', \''+item.parent+'\', \''+item.level+'\');"><img src="/static/admin/assets/img/icon/down2.png" alt="아래"></a>';
                        html += '       <button class="btn panel-open-btn table-btn bg-purple" onclick="javascript:getModifyData(\''+item.menuSeq+'\');">수정</button>';
                        html += '       <button class="btn table-btn bg-deepgray" onclick="javascript:getDeleteData(\''+item.menuSeq+'\');">삭제</button>';
                        html += '   </td>';
                        html += '</tr>';
                    });

                    $("#3depth").html(html);

                }

            }
            , error: function (request, status, error) {
                if (request.status == 400 || request.status == 500 || request.status == 503) {
                    alert("메뉴를 불러오는 도중에 에러가 발생하였습니다.");
                }
            }
        });
    }
    function selectChange(val) {
        if (val == 'BOARD') {
            $(".type_board").removeClass("d-none");
            $(".type_link").addClass("d-none");
        } else if (val == 'LINK') {
            $(".type_link").removeClass("d-none");
            $(".type_board").addClass("d-none");
        } else {
            $(".type_board").addClass("d-none");
            $(".type_link").addClass("d-none");
        }
    }
    function selectModiChange(val) {
        if (val == 'BOARD') {
            $(".type_board").removeClass("d-none");
            $(".type_link").addClass("d-none");
        } else if (val == 'LINK') {
            $(".type_link").removeClass("d-none");
            $(".type_board").addClass("d-none");
        } else if (val == 'ACTION') {
            $(".type_link").removeClass("d-none");
        } else {
            $(".type_board").addClass("d-none");
            $(".type_link").addClass("d-none");
        }
    }

    // 메뉴 순서변경 > 위로 이동
    function levelUp (menuSeq, parent, level) {

        if (level == '1') {
            alert("최상위 메뉴입니다.");
            return false;
        } else {

            if (!confirm("메뉴를 위로 이동 시키겠습니까?")) {
                return false;
            }

            $.ajax({
                url: "/api/menu/levelChange/UP/"+menuSeq+"/"+parent+"/"+level
                , type: "POST"
                , success: function (data) {

                    if (data.return_code == 200) {
                        alert("변경되었습니다.");
                        window.location.reload();
                    }
                }
                , error: function (request, status, error) {
                    if (request.status == 400 || request.status == 500 || request.status == 503) {
                        alert("메뉴 순서변경 도중에 에러가 발생하였습니다.");
                    }
                }
            });
        }
    }

    // 메뉴 순서변경 > 위로 이동
    function levelDown (menuSeq, parent, level) {

        if (!confirm("메뉴를 아래로 이동 시키겠습니까?")) {
            return false;
        }

        $.ajax({
            url: "/api/menu/levelChange/DOWN/"+menuSeq+"/"+parent+"/"+level
            , type: "POST"
            , success: function (data) {

                if (data.return_code == 200) {
                    alert("변경되었습니다.");
                    window.location.reload();
                } else  if (data.return_code == 6000) {
                    alert("최하위 메뉴입니다.");
                }
            }
            , error: function (request, status, error) {
                if (request.status == 400 || request.status == 500 || request.status == 503) {
                    alert("메뉴 순서변경 도중에 에러가 발생하였습니다.");
                }
            }
        });
    }

</script>

<div class="content">
    <div class="menu-table">
        <!-- table-wrap -->
        <div class="table-wrap" data-dep="depth-01">
            <div class="table-header">
                <h3 class="th-tit">1차 메뉴</h3>
                <button class="btn panel-open-btn" type="button" id="dmenuAdd" data-depth="1">추가</button>
            </div>
            <div class="table">
                <table class="t-type-02">
                    <colgroup>
                        <col style="width: 7rem;">
                        <col>
                        <col style="width: 20rem;">
                    </colgroup>
                    <tbody>
                    <c:forEach items="${oneDepthList}" var="list">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${list.useYn eq 'Y'}">
                                        <div class="visible-f v-show">사용</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="visible-f v-hid">숨김</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="#n" onclick="javascript:childMenuCall('${list.menuSeq}');">${list.menuName}</a></td>
                            <td>
                                <a class="btn icon-btn" href="javascript:levelUp('${list.menuSeq}', '${list.parent}', '${list.level}');"><img src="/static/admin/assets/img/icon/up2.png" alt="위"></a>
                                <a class="btn icon-btn" href="javascript:levelDown('${list.menuSeq}', '${list.parent}', '${list.level}');"><img src="/static/admin/assets/img/icon/down2.png" alt="아래"></a>
                                <button class="btn panel-open-btn table-btn bg-purple" onclick="javascript:getModifyData('${list.menuSeq}');">수정</button>
                                <button class="btn table-btn bg-deepgray" onclick="javascript:getDeleteData('${list.menuSeq}');">삭제</button><!--241015-->
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="table-wrap" data-dep="depth-02">
            <div class="table-header">
                <input type="hidden" name="1dmenuSeq" id="1dmenuSeq" />
                <h3 class="th-tit">2차 메뉴</h3>
                <button class="btn panel-open-btn" type="button" id="2dmenuAdd" data-depth="2">추가</button>
            </div>
            <div class="table">
                <table class="t-type-02">
                    <colgroup>
                        <col style="width: 7rem;">
                        <col>
                        <col style="width: 20rem;">
                    </colgroup>
                    <tbody id="2depth"></tbody>
                </table>
            </div>
        </div>
        <div class="table-wrap" data-dep="depth-03">
            <input type="hidden" name="2dmenuSeq" id="2dmenuSeq" />
            <div class="table-header">
                <h3 class="th-tit">3차 메뉴</h3>
                <button class="btn panel-open-btn" type="button" id="3dmenuAdd" data-depth="3">추가</button>
            </div>
            <div class="table">
                <table class="t-type-02">
                    <colgroup>
                        <col style="width: 7rem;">
                        <col>
                        <col style="width: 20rem;">
                    </colgroup>
                    <tbody id="3depth"></tbody>
                </table>
            </div>
        </div>
    </div>

    <!--모달 : 메뉴 등록-->
    <div class="modal-wrap d-none" id="menuAdd">
        <div class="modal menu-modal">
            <div class="panel-header">
                <h4 class="panel-tit">메뉴 등록</h4>
            </div>

            <input type="hidden" name="parent" id="parent" value="${parentInfo.menuSeq}">
            <input type="hidden" name="depth" id="depth" value="${parentInfo.depth+1}">
            <input type="hidden" name="mparent" id="mparent" value="">

            <div class="out-box border-t-1">
                <div class="input-wrap">
                    <span class="label">언어 선택</span>
                    <div>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="langType" id="kor" value="KOR" checked="checked"><span class="radio-label">국문</span>
                        </label>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="langType" id="eng" value="ENG"><span class="radio-label">영문</span>
                        </label>
                    </div>
                </div>
                <div class="input-wrap" data-lang="kor">
                    <label class="label" for="menuName">메뉴명</label>
                    <input class="flex-1" type="text" name="menuName" id="menuName">
                </div>
                <div class="input-wrap">
                    <label class="label" for="urlname">URL명</label>
                    <input class="flex-1 mr-10" type="text" name="urlname" id="urlname">
                    <br>
                    <span>* 띄워쓰기 없이 영문만</span>
                </div>

                <div class="input-wrap">
                    <fieldset class="fieldset">
                        <legend class="label">타입</legend>
                        <div class="select-box">
                            <select class="select type_change" name="menuType" id="menuType" onchange="javascript:selectChange(this.value);">
                                <option value="">선택</option>
                                <option value="PAGE" >페이지</option>
                                <option value="BOARD">게시판</option>
                                <option value="ACTION">개발</option>
                                <option value="LINK">링크</option>
                            </select>
                        </div>
                    </fieldset>
                    <fieldset class="fieldset type_board d-none">
                        <label class="label">게시판선택</label>
                        <div class="select-box">
                            <select class="select seq" name="categorySeq" id="categorySeq">
                                <option value="">선택</option>
                                <c:forEach items="${boardList}" var="boardList" varStatus="status">
                                    <option value="${boardList.categorySeq}">${boardList.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </fieldset>
                </div>
                <div class="input-wrap">
                    <span class="label">페이지 SEO</span>
                    <div>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="seoUseYn" id="seoUseYn01" value="Y" checked="checked"><span class="radio-label">사용</span>
                        </label>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="seoUseYn" id="seoUseYn02" value="N"><span class="radio-label">사용안함</span>
                        </label>
                    </div>
                </div>
                
                <div class="input-wrap">
                   <label class="label" for="seoTitle">TITLE</label>
                   <input class="flex-1" type="text" name="seoTitle" id="seoTitle" value=""/>
                </div>

                <div class="input-wrap">
                   <label class="label" for="seoDesc">DESCRIPTION</label>
                   <input class="flex-1" type="text" name="seoDesc" id="seoDesc" value=""/>
                </div>

                <div class="input-wrap">
                   <label class="label" for="seoKeyword">KEYWORD</label>
                   <input class="flex-1" type="text" name="seoKeyword" id="seoKeyword" value=""/>
                </div>

                <div class="input-wrap">
                   <label class="label" for="seoImg">IMG</label>
                   <input class="flex-1" type="text" name="seoImg" id="seoImg" value=""/>
                </div>

                <div class="input-wrap" style="border-bottom: 3rem solid #e3e6e3 !important;">
                   <label class="label" for="seoUrl">URL</label>
                   <input class="flex-1" type="text" name="seoUrl" id="seoUrl" value=""/>
                </div>
                
                
                
                <div class="input-wrap type_link d-none">
                    <label class="label" for="link">외부링크</label>
                    <input class="flex-1" type="text" name="link" id="link" value="">
                </div>
                <div class="input-wrap">
                    <label class="label">사용유무</label>
                    <div class="select-box">
                        <select class="select" name="useYn" id="useYn">
                            <option value="Y">사용</option>
                            <option value="N">숨김</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-botton mt-30 txt-center">
                <button class="btn menu-add-btn form-btn bg-deep-purple mr-10" type="button" onclick="doSave()">등록</button>
                <button class="btn modal-close form-btn bg-black" type="reset">취소</button>
            </div>
        </div>
    </div>

    <!--모달 : 메뉴 수정-->
    <div class="modal-wrap d-none" id="menuModify">
        <input type="hidden" name="menuSeq" id="menuSeq" value="" />
        <div class="modal menu-modal">
            <div class="panel-header">
                <h4 class="panel-tit">메뉴 수정</h4>
            </div>
            <div class="out-box border-t-1">
                <div class="input-wrap">
                    <span class="label">언어 선택</span>
                    <div>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="mlangType" id="mkor" value="KOR" checked="checked"><span class="radio-label">국문</span>
                        </label>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="mlangType" id="meng" value="ENG"><span class="radio-label">영문</span>
                        </label>
                    </div>
                </div>
                <div class="input-wrap">
                    <label class="label" for="urlname">URL명</label>
                    <input class="flex-1 mr-10" type="text" name="murlname" id="murlname" value="">
                    <br>
                    <span>* 띄워쓰기 없이 영문만</span>
                </div>

                <div class="input-wrap" data-lang="kor">
                    <label class="label" for="mmenuName" data-lang="eng">메뉴명</label>
                    <input class="flex-1" type="text" name="mmenuName" id="mmenuName" value="">
                </div>

                <div class="input-wrap">
                    <fieldset class="fieldset">
                        <legend class="label">타입</legend>
                        <div class="select-box">
                            <select class="select type_change" name="mmenuType" id="mmenuType" onchange="javascript:selectModiChange(this.value);">
                                <option value="">선택</option>
                                <option value="PAGE">페이지</option>
                                <option value="BOARD">게시판</option>
                                <option value="ACTION">개발</option>
                                <option value="LINK">링크</option>
                            </select>
                        </div>
                    </fieldset>
                    <fieldset class="fieldset type_board d-none">
                        <label class="label">게시판선택</label>
                        <div class="select-box">
                            <select class="select seq" name="mcategorySeq" id="mcategorySeq">
                                <option value="">선택</option>
                                <c:forEach items="${boardList}" var="boardList" varStatus="status">
                                    <option value="${boardList.categorySeq}">${boardList.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </fieldset>
                </div>
                <div class="input-wrap">
                    <span class="label">페이지 SEO</span>
                    <div>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="mseoUseYn" id="mseoUseYn01" value="Y"><span class="radio-label">사용</span>
                        </label>
                        <label class="radio-wrap">
                            <input class="radio-btn" type="radio" name="mseoUseYn" id="mseoUseYn02" value="N"><span class="radio-label">사용안함</span>
                        </label>
                    </div>
                </div>
                
                <div class="input-wrap">
	               <label class="label" for="seoTitle">TITLE</label>
	               <input class="flex-1" type="text" name="mseoTitle" id="mseoTitle" value=""/>
	            </div>
	
	            <div class="input-wrap">
	               <label class="label" for="seoDesc">DESCRIPTION</label>
	               <input class="flex-1" type="text" name="mseoDesc" id="mseoDesc" value=""/>
	            </div>
	
	            <div class="input-wrap">
	               <label class="label" for="seoKeyword">KEYWORD</label>
	               <input class="flex-1" type="text" name="mseoKeyword" id="mseoKeyword" value=""/>
	            </div>
	
	            <div class="input-wrap">
	               <label class="label" for="seoImg">IMG</label>
	               <input class="flex-1" type="text" name="mseoImg" id="mseoImg" value=""/>
	            </div>
	
	            <div class="input-wrap" style="border-bottom: 3rem solid #e3e6e3 !important;">
	               <label class="label" for="seoUrl">URL</label>
	               <input class="flex-1" type="text" name="seoUrl" id="mseoUrl" value=""/>
	            </div>
	            
                
                <div class="input-wrap type_link d-none">
                    <label class="label" for="link">외부링크</label>
                    <input class="flex-1" type="text" name="mlink" id="mlink" value="">
                </div>
                <div class="input-wrap">
                    <label class="label">사용유무</label>
                    <div class="select-box">
                        <select class="select" name="museYn" id="museYn">
                            <option value="Y">사용</option>
                            <option value="N">숨김</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-botton mt-30 txt-center">
                <button class="btn menu-add-btn form-btn bg-deep-purple mr-10" type="button" onclick="doUpdate()">수정</button>
                <button class="btn modal-close form-btn bg-black" type="reset">취소</button>
            </div>
        </div>
    </div>

</div>
</div>
<!-- // content-wrap -->

</div>
<!-- // site-wrap -->
<!--모달-->
<div class="modal-wrap d-none">
    <div class="modal-page"></div>
</div>
<!--modal-wrap end-->
<script type="text/javascript">

    $("#dmenuAdd").on("click", function () {
        // 2dmenuSeq
        $("#parent").val(1);
        $("#depth").val($(this).attr('data-depth'));
        $("#menuAdd").removeClass("d-none");
    });

    $("#2dmenuAdd").on("click", function () {
        // 2dmenuSeq
        if ($("#1dmenuSeq").val() != '' && $("#1dmenuSeq").val() != undefined) {
            $("#parent").val($("#1dmenuSeq").val());
            $("#depth").val($(this).attr('data-depth'));
            $("#menuAdd").removeClass("d-none");
        }
    });

    $("#3dmenuAdd").on("click", function () {
        // 2dmenuSeq
        if ($("#2dmenuSeq").val() != '' && $("#2dmenuSeq").val() != undefined) {
            $("#parent").val($("#2dmenuSeq").val());
            $("#depth").val($(this).attr('data-depth'));
            $("#menuAdd").removeClass("d-none");
        }
    });

    function doSave() {
        var langType = $('input[name=langType]:checked').val();
        var parent = $("#parent").val();
        var depth = $("#depth").val();
        var menuName = $("#menuName").val();
        var urlname = $("#urlname").val();
        var menuType = $("#menuType").val();
        var categorySeq = $("#categorySeq").val();
        var seoUseYn = $('input[name=seoUseYn]:checked').val();
        var useYn = $("#useYn").val();
        var link = $("#link").val();
        
        var seoTitle = $("#seoTitle").val();
        var seoDesc = $("#seoDesc").val();
        var seoKeyword = $("#seoKeyword").val();
        var seoImg = $("#seoImg").val();
        var seoUrl = $("#seoUrl").val();

        if (menuType == "") {

            alert("타입음 필수 값입니다.");
            return false;

        } else if (menuType == 'LINK') {
            if (link == "") {
                alert("타입이 링크인 경우 외부링크는 필수 값입니다.");
                $("#link").focus();
                return false;
            }
        }

        let jsonData =  {
            parent: parent,
            depth: depth,
            langType: langType,
            menuName: menuName,
            urlname: urlname,
            menuType: menuType,
            categorySeq: categorySeq,
            seoUseYn: seoUseYn,
            useYn: useYn,
            link: link,
            seoTitle: seoTitle,
            seoDesc: seoDesc,
            seoKeyword: seoKeyword,
            seoImg: seoImg,
            seoUrl: seoUrl
        }

        console.log("jsonData ::: " + JSON.stringify(jsonData));

        if (!confirm("메뉴를 추가하시겠습니까?")) {
            return false;
        }

        $.ajax({
            url: "/api/menu/create"
            , type: "POST"
            , processData: false
            , contentType: "application/json"
            , dataType: "json"
            , data: JSON.stringify(jsonData)
            , success: function (data) {

                console.log("data :: " + data)

                if (data.return_code == 200) {
                    alert('추가되었습니다');
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

    // 수정 데이터 조회
    function getModifyData(menuSeq) {

        $.ajax({
            url: "/api/menu/getMenuData/"+menuSeq
            , type: "POST"
            , processData: false
            , success: function (data) {

                console.log("data :: " + JSON.stringify(data))

                // 불어온 값 세팅
                $("#menuSeq").val(data.menuSeq);
                $("#mparent").val(data.parent);
                $("#murlname").val(data.urlname);
                $("#mmenuName").val(data.menuName);
                $("#mlink").val(data.link);
                $("#mmenuType").val(data.menuType).prop("selected", true);
                $("#mcategorySeq").val(data.categorySeq).prop("selected", true);
                $("input:radio[name='mseoUseYn']:radio[value='"+data.seoYn+"']").prop("checked", true);
                $("#museYn").val(data.useYn).prop("selected", true);
                
                $("#mseoTitle").val(data.seoTitle);
                $("#mseoDesc").val(data.seoDesc);
                $("#mseoKeyword").val(data.seoKeyword);
                $("#mseoImg").val(data.seoImg);
                $("#mseoUrl").val(data.seoUrl);

                if (data.menuType == 'LINK') {
                    $(".type_link").removeClass("d-none");
                }

                if (data.link != null || data.link != "" || data.link != undefined) {
                    $(".type_link").removeClass("d-none");
                }

                // 레이어팝업 노출
                $("#menuModify").removeClass("d-none");

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

    // 메뉴삭제
    function getDeleteData(menuSeq) {

        if (!confirm("메뉴를 삭제하시겠습니까?")) {
            return false;
        }

        $.ajax({
            url: "/api/menu/delete/"+menuSeq
            , type: "DELETE"
            , processData: false
            , success: function (data) {

                if (data.return_code == 200) {
                    alert('삭제되었습니다');
                    location.href = "/admin/menu/1";
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

    function doUpdate() {
        let menuSeq = $("#menuSeq").val();
        let lang = $('input[name=mlangType]:checked').val();
        let parent = $("#mparent").val();
        let menuName = $("#mmenuName").val();
        let urlname = $("#murlname").val();
        let menuType = $("#mmenuType").val();
        let categorySeq = $("#mcategorySeq").val();
        let seoUseYn = $('input[name=mseoUseYn]:checked').val();
        let useYn = $("#museYn").val();
        let link = $("#mlink").val();
        
        let seoTitle = $("#mseoTitle").val();
        let seoDesc = $("#mseoDesc").val();
        let seoKeyword = $("#mseoKeyword").val();
        let seoImg = $("#mseoImg").val();
        let seoUrl = $("#mseoUrl").val();

        if (menuType == 'LINK') {
            if (link == "") {
                alert("타입이 링크인 경우 외부링크는 필수 값입니다.");
                $("#link").focus();
                return false;
            }
        } else if (menuType == 'BOARD') {
            if (categorySeq == "") {
                alert("타입이 게시판인 경우 게시판 선택은 필수입니다.");
                return false;
            }
        }

        let updateData =  {
            menuSeq: menuSeq,
            parent: parent,
            lang: lang,
            menuName: menuName,
            urlname: urlname,
            menuType: menuType,
            categorySeq: categorySeq,
            seoUseYn: seoUseYn,
            useYn: useYn,
            link: link,
            seoTitle: seoTitle,
            seoDesc: seoDesc,
            seoKeyword: seoKeyword,
            seoImg: seoImg,
            seoUrl: seoUrl
        }

        console.log("updateData :: " + JSON.stringify(updateData));

        if (!confirm("메뉴를 수정하시겠습니까?")) {
            return false;
        }

        $.ajax({
            url: "/api/menu/modify"
            , type: "POST"
            , processData: false
            , contentType: "application/json"
            , dataType: "json"
            , data: JSON.stringify(updateData)
            , success: function (data) {

                console.log("data :: " + data)

                if (data.return_code == 200) {
                    alert('추가되었습니다');
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

    $('.levelBtn').on('click', function() {

        let thisRow = $(this).closest('tr');
        let seq = thisRow.find('input:eq(1)').val();
        let level = thisRow.find('input:eq(2)').val();

        $('input[name="level"]').each(function (index, item) {
            console.log("index : " + index + "   ___ item : " + item.value);
        });

        if (confirm("변경하시겠습니까?")) {

            $.ajax({
                url:"/api/menu/level-change/" + seq + "/" + level
                , type: "PUT"
                , processData: false
                , contentType: false
                , success: function(data) {
                    if (data.return_code == 200) {
                        alert('변경되었습니다.되었습니다');
                        location.href = "/admin/menu/${parent}";
                    }
                }
                , error: function (request, status, error){
                    if(request.status == 403){
                        alert("로그인 정보가 없습니다.");
                        location.href = "/auth/login";
                    }
                    if (request.status == 400 || request.status == 500 || request.status == 503) {
                        alert("삭제에 실패했습니다. 시스템관리자에게 문의해주세요.");
                    }
                }
            })
        }
    });

    $('input[name="visible_chk"]').on('change', function () {
        let menu_seq = $(this).attr('data-menu-seq');

        if ($(this).is(':checked')) {
            $.ajax({
                type: 'GET',
                url: '/api/menu/use_yn/' + menu_seq,
                success: function (data) {
                    alert("체크되었습니다.");
                },
                error: function (e) {
                    // TODO 에러 화면
                    alert('error');
                }
            })
        } else {

            $.ajax({
                type: 'GET',
                url: '/api/menu/use_yn/' + menu_seq,
                success: function (data) {
                    alert("해지되었습니다.");
                },
                error: function (e) {
                    // TODO 에러 화면
                    alert('error');
                }
            })
        }
    });

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
            items.push($(this).val());
        });

        if(items.length == 0){
            alert('선택된 내역이 없습니다.');
            return false;
        }


        if(confirm('정말 삭제하겠습니까?')){
            let objParam = {
                "seq": items
            };
            $.ajax({
                url:"/api/menu/delete"
                , type: "POST"
                , dataType: "json"
                , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                , data: objParam
                , success: function(data) {
                    if (data.return_code == 200) {
                        alert('삭제되었습니다');
                        location.href = "/admin/menu/${parent}";
                    }
                }
                , error: function (request, status, error){
                    if(request.status == 403){
                        alert("로그인 정보가 없습니다.");
                        location.href = "/auth/login";
                    }
                    if (request.status == 400 || request.status == 500 || request.status == 503) {
                        alert("삭제에 실패했습니다. 시스템관리자에게 문의해주세요.");
                    }
                }
            })

        }else{
            return false;
        }


    });

</script>
</body>

</html>