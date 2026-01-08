<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/WEB-INF/jsp/eng/include/header_sub_eng.jsp" />
  <!-- contents -->
<main class="content-wrap sub" id="Sub">
    <div class="contact">
        <div class="visual">
            <div class="tit"><img src="/static/img/sub/contact/contact.png"></div>
            <div class="txt">OMNIFIT Hong Kong is ready to serve you and <br>ensure customer satisfaction across Hong Kong.</div>
        </div>
        <div class="content">
            <div class="inner">
                <div class="head">
                    <div class="txt">OMNIFIT HONG KONG</div>
                    <div class="tit">Information</div>
                </div>
                <form id="writeForm">
                    <div class="form" id="writeForm">
                        <dl>
                            <dt>Your name</dt>
                            <dd>
                                <div class="inp">
                                    <input type="text" placeholder="name" name="name">
                                </div>
                            </dd>
                        </dl>
                        <dl>
                            <dt>Your email</dt>
                            <dd>
                                <div class="inp">
                                    <input type="text" placeholder="email" name="email">
                                </div>
                            </dd>
                        </dl>
                        <dl>
                            <dt>Subject</dt>
                            <dd>
                                <div class="inp">
                                    <input type="text" placeholder="Subject" name="subject">
                                </div>
                            </dd>
                        </dl>
                        <dl>
                            <dt>Your message (optional)</dt>
                            <dd>
                                <div class="inp">
                                    <textarea placeholder="Your message" name="content"></textarea>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </form>
                <div class="button">
                    <button type="button" id="inqformBtn">Submit</button>
                </div>
            </div>
        </div>
    </div>
</main>
<div class="footer-wrap" id="Footer">
 <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</div>
</body>

 <script type="text/javascript">
   $("#inqformBtn").on("click", function(event) {
     event.preventDefault();

     const name = $("input[name='name']");
     const email = $("input[name='email']");
     const subject = $("input[name='subject']");
     const content = $("textarea[name='content']");

     if (name.val().trim() == "") {
       alert("Please enter your name.");
       name.focus();
       return false;
     }

     if (email.val() == "") {
       alert("Please enter your email address.");
       email.focus();
       return false;
     }

     const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

     if (!emailPattern.test(email.val())) {
         console.log(email.val());
         alert("Invalid email format.");
         return false;
     }

     if (subject.val() == "") {
       alert("Please enter your subject.");
       subject.focus();
       return false;
     }

     var form = jQuery("#writeForm")[0];
     var formData = new FormData(form);

     formData.append("category", "inq")

     for (let pair of formData.entries()) {
         console.log(pair[0] + ', ' + pair[1]);
     }

     if (!confirm("Do you want to submit your report?")) return false;

     $.ajax({
       url: "/api/contract/save",
       type: "POST",
       processData: false,
       contentType: false,
       data: formData,
       success: function(data) {
         if (data.return_code == 200) {
           alert("Your submission has been completed.");
           location.href = "/omnifit/contact/inq";
         } else {
           alert(data.return_message);
         }
       },
       error: function(request, status, error) {
         if (request.status == 403) {
           alert("Login information not found.");
           location.href = "/auth/login";
         }
         if (request.status == 400 || request.status == 500 || request.status == 503) {
           alert("Registration failed. Please contact the system administrator.");
         }
       }
     });
   });
 </script>

 </html>