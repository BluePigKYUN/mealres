﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
body{
  font-family: 'Montserrat', sans-serif;
  background:white;
}

.container {
  display: block;
  max-width: 680px;
  width: 80%;
  margin: 120px auto;
}

h1 {
  color: #20c997;
  font-size: 48px;
  letter-spacing: -3px;
  text-align: center;
  margin: 120px 0 80px 0;
  transition: 0.2s linear;
  font-family: JalnanGothic;
  font-weight: 900;
}

.links {
  list-style-type: none;
}
.links li {
  display: inline-block;
  margin: 0 20px 0 0;
  transition: 0.2s linear;
}
.links li:nth-child(2) {
  opacity: 0.6;
}
.links li:nth-child(2):hover {
  opacity: 1;
}
.links li:nth-child(3) {
  opacity: 0.6;
  float: right;
}
.links li:nth-child(3):hover {
  opacity: 1;
}
.links li a {
  text-decoration: none;
  color: #0f132a;
  font-weight: bolder;
  text-align: center;
  cursor: pointer;
}

form {
  width: 100%;
  max-width: 680px;
  margin: 40px auto 10px;
}
form .input__block {
  margin: 20px auto;
  display: block;
  position: relative;
}
form .input__block.first-input__block::before {
  content: "";
  position: absolute;
  top: -15px;
  left: 50px;
  display: block;
  width: 0;
  height: 0;
  background: transparent;
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-bottom: 15px solid rgba(15, 19, 42, 0.1);
  transition: 0.2s linear;
}
form .input__block.signup-input__block::before {
  content: "";
  position: absolute;
  top: -15px;
  left: 150px;
  display: block;
  width: 0;
  height: 0;
  background: transparent;
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-bottom: 15px solid rgba(15, 19, 42, 0.1);
  transition: 0.2s linear;
}
form .input__block input {
  display: block;
  width: 90%;
  max-width: 680px;
  height: 50px;
  margin: 0 auto;
  border-radius: 8px;
  border: none;
  background: rgba(15, 19, 42, 0.1);
  color: rgba(15, 19, 42, 0.3);
  padding: 0 0 0 15px;
  font-size: 14px;
  font-family: "Montserrat", sans-serif;
}
form .input__block input:focus, form .input__block input:active {
  outline: none;
  border: none;
  color: #0f132a;
}
form .input__block input.repeat__password {
  opacity: 0;
  display: none;
  transition: 0.2s linear;
}
form .signin__btn {
  background: #20c997;
  color: white;
  display: block;
  width: 92.5%;
  max-width: 680px;
  height: 50px;
  border-radius: 8px;
  margin: 0 auto;
  border: none;
  cursor: pointer;
  font-size: 14px;
  font-family: "Montserrat", sans-serif;
  box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
  transition: 0.2s linear;
}
form .signin__btn:hover {
  box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

.separator {
  display: block;
  margin: 30px auto 10px;
  text-align: center;
  height: 40px;
  position: relative;
  background: transparent;
  color: rgba(15, 19, 42, 0.4);
  font-size: 13px;
  width: 90%;
  max-width: 680px;
}
.separator::before {
  content: "";
  position: absolute;
  top: 8px;
  left: 0;
  background: rgba(15, 19, 42, 0.2);
  height: 1px;
  width: 45%;
}
.separator::after {
  content: "";
  position: absolute;
  top: 8px;
  right: 0;
  background: rgba(15, 19, 42, 0.2);
  height: 1px;
  width: 45%;
}

.google__btn,
.github__btn {
  display: block;
  width: 90%;
  max-width: 680px;
  margin: 20px auto;
  height: 50px;
  cursor: pointer;
  font-size: 14px;
  font-family: "Montserrat", sans-serif;
  border-radius: 8px;
  border: none;
  line-height: 40px;
}
.google__btn.google__btn,
.github__btn.google__btn {
  background: #5b90f0;
  color: white;
  box-shadow: 0 15px 30px rgba(91, 144, 240, 0.36);
  transition: 0.2s linear;
}
.google__btn.google__btn .fa,
.github__btn.google__btn .fa {
  font-size: 20px;
  padding: 0 5px 0 0;
}
.google__btn.google__btn:hover,
.github__btn.google__btn:hover {
  box-shadow: 0 0 0 rgba(91, 144, 240, 0);
}
.google__btn.github__btn,
.github__btn.github__btn {
  background: #25282d;
  color: white;
  box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
  transition: 0.2s linear;
}
.google__btn.github__btn .fa,
.github__btn.github__btn .fa {
  font-size: 20px;
  padding: 0 5px 0 0;
}
.google__btn.github__btn:hover,
.github__btn.github__btn:hover {
  box-shadow: 0 0 0 rgba(37, 40, 45, 0);
}

footer p {
  text-align: center;
}
footer p .fa {
  color: #e91e63;
}
footer p a {
  text-decoration: none;
  font-size: 17px;
  margin: 0 5px;
}
footer p a .fa-facebook {
  color: #3b5998;
}
footer p a .fa-twitter {
  color: #1da1f2;
}
footer p a .fa-instagram {
  color: #f77737;
}
footer p a .fa-linkedin {
  color: #0077b5;
}
footer p a .fa-behance {
  color: #1769ff;
}

@font-face {
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

</style>

<script type="text/javascript">
	function sendLogin() {
		const f = document.loginForm;
		let str;

		str = f.memberId.value;
		if (!str) {
			f.memberId.focus();
			return;
		}

		str = f.memberPwd.value;
		if (!str) {
			f.memberPwd.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/member/login";
		f.submit();
	}

	$(document).ready(
			function() {
				let signup = $(".links").find("li").find("#signup");
				let signin = $(".links").find("li").find("#signin");
				let reset = $(".links").find("li").find("#reset");
				let first_input = $("form").find(".first-input");
				let hidden_input = $("form").find(".input__block").find(
						"#repeat__password");
				let signin_btn = $("form").find(".signin__btn");

				//----------- sign up ---------------------
				signup.on("click", function(e) {
					e.preventDefault();
					$(this).parent().parent().siblings("h1").text("SIGN UP");
					$(this).parent().css("opacity", "1");
					$(this).parent().siblings().css("opacity", ".6");
					first_input.removeClass("first-input__block").addClass(
							"signup-input__block");
					hidden_input.css({
						"opacity" : "1",
						"display" : "block"
					});
					signin_btn.text("Sign up");
				});

				//----------- sign in ---------------------
				signin.on("click", function(e) {
					e.preventDefault();
					$(this).parent().parent().siblings("h1").text("SIGN IN");
					$(this).parent().css("opacity", "1");
					$(this).parent().siblings().css("opacity", ".6");
					first_input.addClass("first-input__block").removeClass(
							"signup-input__block");
					hidden_input.css({
						"opacity" : "0",
						"display" : "none"
					});
					signin_btn.text("Sign in");
				});

				//----------- reset ---------------------
				reset.on("click", function(e) {
					e.preventDefault();
					$(this).parent().parent().siblings("form").find(
							".input__block").find(".input").val("");
				})
			});
</script>
</head>
<body>

<%-- 	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header> --%>



		<div class="container">
			<!-- Heading -->
			<h1>Mealers</h1>

			<!-- Links -->
			<ul class="links">
				<li><a href="#" id="signin">SIGN IN</a></li>
				<li><a href="#" id="signup">SIGN UP</a></li>
				<li><a href="#" id="reset">RESET</a></li>
			</ul>

			<!-- Form -->
			<form name="loginForm" action="" method="post">
				<!-- email input -->
				<div class="first-input input__block first-input__block">
					<input type="text" name="memberId" placeholder="ID" class="input" id="email" />
				</div>
				
				<!-- password input -->
				<div class="input__block">
					<input type="password" name="memberPwd" placeholder="Password" class="input"
						id="password" />
				</div>
				<!-- repeat password input -->
				<div class="input__block">
					<input type="password"  placeholder="Repeat password"
						class="input repeat__password" id="repeat__password" />
				</div>
				<!-- sign in button -->
				<button class="signin__btn" onclick="sendLogin();">Sign in</button>
			</form>
			<!-- separator -->
		<!-- 	<div class="separator">
				<p>OR</p>
			</div> -->
			<!-- google button -->
	<!-- 		<button class="google__btn">
				<i class="fa fa-google"></i> Sign in with Google
			</button> -->
			<!-- google button -->
	<!-- 		<button class="github__btn">
				<i class="fa fa-github"></i> Sign in with GitHub
			</button> -->
		</div>


		<%-- 	<div class="container">
			<div class="body-container">

				<div class="row">
					<div class="col-md-6 offset-md-3">
						<div class="border mt-5 p-4">
							<form name="loginForm" action="" method="post" class="row g-3">
								<h3 class="text-center">
									<i class="bi bi-lock"></i> 회원 로그인
								</h3>
								<div class="col-12">
									<label class="mb-1">아이디</label> <input type="text"
										name="memberId" class="form-control" placeholder="아이디">
								</div>
								<div class="col-12">
									<label class="mb-1">패스워드</label> <input type="password"
										name="memberPwd" class="form-control" autocomplete="off"
										placeholder="패스워드">
								</div>
								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="rememberMe"> <label class="form-check-label"
											for="rememberMe"> 아이디 저장</label>
									</div>
								</div>
								<div class="col-12">
									<button type="button" class="btn btn-primary float-end"
										onclick="sendLogin();">
										&nbsp;Login&nbsp;<i class="bi bi-check2"></i>
									</button>
								</div>
							</form>
							<hr class="mt-4">
							<div class="col-12">
								<p class="text-center mb-0">
									<a href="#" class="text-decoration-none me-2">아이디 찾기</a> <a
										href="#" class="text-decoration-none me-2">패스워드 찾기</a> <a
										href="${pageContext.request.contextPath}/"
										class="text-decoration-none">회원가입</a>
								</p>
							</div>
						</div>

						<div class="d-grid">
							<p class="form-control-plaintext text-center text-primary">${message}</p>
						</div>

					</div>
				</div>

			</div>
		</div> --%>

<!-- 		<footer>
			<p>
				Thank you for watching <i class="fa fa-heart"></i> <i
					class="fa fa-heart"></i> <i class="fa fa-heart"></i>
			</p>
			<p>
				Chouaib Blgn : <a href="https://www.facebook.com/chouaib45"> <i
					class="fa fa-facebook"></i>
				</a> <a href="http://twitter.com/chouaibblgn45"> <i
					class="fa fa-twitter"></i>
				</a> <a href="http://instagram.com/chouaib_blgn"> <i
					class="fa fa-instagram"></i>
				</a> <a href="http://linkedin.com/in/chouaibblgn/"> <i
					class="fa fa-linkedin"></i>
				</a> <a href="https://www.behance.net/geek30"> <i
					class="fa fa-behance"></i>
				</a>
			</p>
		</footer> -->

	

<%-- 	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer> --%>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />

</body>
</html>