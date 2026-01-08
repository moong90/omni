<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--폰트-->
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/fonts/fonts.css">

    <!--css-->
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/css/reset.css">
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/css/base.css">
    <link type="text/css" rel="stylesheet" href="/static/admin/assets/css/login.css">

    <!--js-->
    <script src="/static/admin/assets/js/jquery-3.6.0.js"></script>
    <script src="/static/admin/assets/js/common.js"></script>


    <title>OMNIFIT CMS ADMIN</title>

    <script type="text/javascript">

        $(document).ready(function() {
            $("#password").keypress(function(e){
                if(e.keyCode && e.keyCode == 13){
                    $("#loginBtn").trigger("click");
                    return false;
                }
            });
        });

        function doSave() {
            var userId = $('#user_id').val();
            var password = $('#password').val();

            if (userId == "") {
                alert("아이디를 입력 해주세요");
                return false;
                $('#user_id').focus();
            }
            if (password == "") {
                alert("비밀번호를 입력해주세요");
                return false;
                $('#password').focus();
            }
            let json = {
                userId: userId,
                password: password
            };
            $.ajax({
                url : "/api/auth/login",
                type: 'POST',
                dataType: 'json',
                contentType:"application/json;charset=UTF-8",
                data : JSON.stringify(json)
                , success:function(data) {
                    if (data.return_code==200) {
                        location.href="/admin";
                    } else {
                        alert(data.return_message);
                    }
                }
                , error:function(request,status,error) {
                    if(request.status == 403){
                        alert("로그인 정보가 없습니다.");
                        location.href= "/view/login";
                    }
                    if(request.status == 400 || request.status == 500 || request.status == 503){
                        alert("등록에 실패했습니다. 시스템관리자에게 문의해주세요.");
                    }
                }
            });
        }
    </script>
</head>
<body>

    <div class="site-wrap">
        <div class="content-wrap login">
            <!-- login-wrap-->
            <section class="login-wrap">
                <h2 class="login-tit">
                    LOGIN <br>
                    <span>OMNIFIT CMS ADMIN에 오신것을 환영합니다.</span>
                </h2>
                <form>
                    <fieldset class="fieldset">
                        <div class="input-box">
                            <label class="id" for="user_id">아이디</label>
                            <input id="user_id" name="user_id" type="text" placeholder="아이디" value="admin" required />
                        </div>
                        <div class="input-box">
                            <label class="pw" for="password">비밀번호</label>
                            <input id="password" name="password" type="password" value="1q2w3e4r5t" placeholder="********" required />
                        </div>
                        <div class="btn-box">
                            <a onclick="doSave();" class="btn login-btn" id="loginBtn" style="cursor:pointer;">로그인</a>
                        </div>
                    </fieldset>
                </form>
            </section>
            <!-- //login-wrap -->
        </div>
    </div>
</body>
</html>