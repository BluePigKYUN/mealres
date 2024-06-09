<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>Mealers</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
body {
	font-family: 'Montserrat', sans-serif;
	background: white;
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
	text-align: center;
	cursor: pointer;
	font-family: 'JalnanGothic';
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

form .input__block {
	display: flex;
	gap: 15px;
}

form .input__block input {
	display: block;
	width: 100%;
	max-width: 680px;
	height: 50px;
	border-radius: 8px;
	border: none;
	background: rgba(15, 19, 42, 0.1);
	color: rgba(15, 19, 42, 0.3);
	padding: 0 0 0 15px;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
}

form .input_btn_box .btn_check {
	background: #20c997;
	color: white;
	display: block;
	width: 20%;
	max-width: 100px;
	height: 50px;
	border-radius: 8px;
	margin: 0 auto;
	border: none;
	cursor: pointer;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
	box-shadow: 0 15px 30px rgba(0, 150, 136, 0.16);
	transition: 0.2s linear;
}

form .input__block input:focus, form .input__block input:active {
	outline: none;
	border: none;
	color: #0f132a;
}

form .login__btn {
	background: #20c997;
	color: white;
	display: block;
	/* width: 92.5%; */
	width: 100%;
	max-width: 680px;
	height: 50px;
	border-radius: 8px;
	margin: 0 auto;
	border: none;
	cursor: pointer;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
	box-shadow: 0 15px 30px rgba(0, 150, 136, 0.16);
	transition: 0.2s linear;
}

form .login__btn:hover {
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

.google__btn, .github__btn {
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

.google__btn.google__btn, .github__btn.google__btn {
	background: #5b90f0;
	color: white;
	box-shadow: 0 15px 30px rgba(91, 144, 240, 0.36);
	transition: 0.2s linear;
}

.google__btn.google__btn .fa, .github__btn.google__btn .fa {
	font-size: 20px;
	padding: 0 5px 0 0;
}

.google__btn.google__btn:hover, .github__btn.google__btn:hover {
	box-shadow: 0 0 0 rgba(91, 144, 240, 0);
}

.google__btn.github__btn, .github__btn.github__btn {
	background: #25282d;
	color: white;
	box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
	transition: 0.2s linear;
}

.google__btn.github__btn .fa, .github__btn.github__btn .fa {
	font-size: 20px;
	padding: 0 5px 0 0;
}

.google__btn.github__btn:hover, .github__btn.github__btn:hover {
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
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.btn_check {
	background: #20c997;
	color: white;
	display: block;
	width: 40%;
	max-width: 680px;
	height: 50px;
	border-radius: 8px;
	margin: 0 auto;
	border: none;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
	box-shadow: 0 15px 30px rgba(0, 150, 136, 0.16);
	transition: 0.2s linear;
}

.btn_check {
	background: #20c997;
	color: white;
	display: block;
	width: 40%;
	max-width: 680px;
	height: 50px;
	border-radius: 8px;
	margin: 0 auto;
	border: none;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
	box-shadow: 0 15px 30px rgba(0, 150, 136, 0.16);
	transition: 0.2s linear;
}

#idCheckResult {
	margin-top: 5px;
	font-size: 12px;
	font-weight: 700;
}
</style>

</head>
<body>
	<div class="container">
		<h1>Mealers</h1>
		<ul class="links">
			<li><a href="#" id="signin">로그인</a></li>
			<li><a href="#" id="signup">회원가입</a></li>
			<li><a href="#" id="reset">RESET</a></li>
		</ul>


		<!-- 로그인 -->
		<form name="loginForm" id="loginForm" action="" method="post">
			<div class="first-input input__block">
				<input type="text" name="memberId" placeholder="아이디" class="input"
					id="memberId" value="test2">
			</div>
			<div class="input__block">
				<input type="password" name="memberPwd" placeholder="비밀번호"
					class="input" id="password1" value="1234">
			</div>
			<!-- 비밀번호 유무 -->
			<p class="form-control-plaintext text-center">${message}</p>
			<button class="login__btn" type="button" onclick="sendLogin();">로그인</button>
		</form>


		<!-- 회원가입 -->
		<form name="joinForm" id="joinForm" method="post">
			<div class="first-input input__block">
				<input type="text" name="email" placeholder="이메일" class="input"
					id="email" />
			</div>
			<div class="input__block">
				<input type="text" name="memberId" placeholder="아이디 (영문, 숫자, 5~20자)"
					class="input" id="memberId2" />
				<button type="button" class="btn_check" onclick="userIdCheck()">확인</button>
				<input type="hidden" name="userIdValid" id="userIdValid"
					value="false">
				<div id="idCheckResult" style="margin-top: 10px;"></div>
				<!-- 이 부분 -->
			</div>
			<div class="input__block">
				<input type="text" name="nickname" placeholder="닉네임" class="input"
					id="nickname" />
			</div>
			<div class="input__block">
				<input type="password" name="memberPwd" placeholder="비밀번호 (최소 8자, 대문자, 소문자, 숫자 포함)"
					class="input" id="password2" />
			</div>
			<div class="input__block">
				<input type="password" placeholder="비밀번호 확인"
					class="input repeat__password" id="repeat__password" />
			</div>
			<p class="form-control-plaintext text-center">${message}</p>
			<button class="login__btn" type="button" onclick="sendJoin();">회원가입</button>
		</form>
	</div>

	<script type="text/javascript">
		//유효성검사
		function validateEmail(email) {
			const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			return emailPattern.test(email);
		}

		function validatePassword(password) {
			const passwordPattern = /^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z\d]{8,}$/;
			return passwordPattern.test(password);
		}

		//로그인
		function sendLogin() {
			const f = document.loginForm;
			let str;

			str = f.memberId.value;
			if (!str) {
				alert("아이디를 입력하세요.");
				f.memberId.focus();
				return;
			}

			str = f.memberPwd.value;
			if (!str) {
				alert("비밀번호를 입력하세요.");
				f.memberPwd.focus();
				return;
			}

			f.action = "${pageContext.request.contextPath}/member/login";
			f.submit();
		}

		//회원가입
		function sendJoin() {
			const f = document.joinForm;
			let str;

			str = f.email.value;
			if (!str || !validateEmail(str)) {
				alert("유효한 이메일을 입력하세요.");
				f.email.focus();
				return;
			}

			str = f.memberId2.value;
			if (!str) {
				alert("ID를 입력하세요.");
				f.userId2.focus();
				return;
			}

			str = f.nickname.value;
			if (!str) {
				alert("닉네임을 입력하세요.");
				f.nickname.focus();
				return;
			}

			str = f.memberPwd.value;
			if (!str || !validatePassword(str)) {
				alert("비밀번호는 최소 8자 이상, 대문자, 소문자, 숫자를 포함해야 합니다.");
				f.memberPwd.focus();
				return;
			}

			const repeatPwd = document.getElementById("repeat__password").value;
			if (str !== repeatPwd) {
				alert("비밀번호가 일치하지 않습니다.");
				document.getElementById("repeat__password").focus();
				return;
			}

			if (f.userIdValid.value === "false") {
				alert("아이디 중복 검사를 실행하세요.");
				f.userId.focus();
				return;
			}

			f.action = "${pageContext.request.contextPath}/member/join";
			f.submit();

		}

		//ajax id 중복검사 
		function userIdCheck() {
			let memberId2 = $("#memberId2").val();

			if (!memberId2) {
				alert("ID를 입력하세요.");
				return;
			}

			let url = "${pageContext.request.contextPath}/member/userIdCheck";
			let query = "memberId=" + memberId2;

			$
					.ajax({
						type : "post",
						url : url,
						data : query,
						dataType : "json",
						success : function(data) {
							let passed = data.passed;

							if (passed === "true") {
								let s = "<span style='font-weight:700;'>사용 가능</span>";
								$("#idCheckResult").html(s);
								$("#userIdValid").val("true");
							} else {
								let s = "<span style='color:red; font-weight:700;'>사용 불가 ID</span>";
								$("#idCheckResult").html(s);
								$("#userIdValid").val("false");
							}
						},
						error : function(e) {
							console.log(e.responseText);
						}
					});
		}

		$(document).ready(
				function() {
					let signup = $(".links").find("li").find("#signup");
					let signin = $(".links").find("li").find("#signin");
					let reset = $(".links").find("li").find("#reset");
					let first_input = $("form").find(".first-input");
					let hidden_input = $("form").find(".input__block").find(
							"#repeat__password");
					let nickname_block = $("#nickname_block");

					$("#joinForm").css({
						"opacity" : "0",
						"display" : "none"
					});

					signup.on("click", function(e) {
						e.preventDefault();
						$(this).parent().parent().siblings("h1")
								.text("SIGN UP");
						$(this).parent().css("opacity", "1");
						$(this).parent().siblings().css("opacity", ".6");

						first_input.removeClass("first-input__block").addClass(
								"signup-input__block");

						$("#loginForm").css({
							"opacity" : "0",
							"display" : "none"
						});
						$("#joinForm").css({
							"opacity" : "1",
							"display" : "block"
						});
					});

					signin.on("click", function(e) {
						e.preventDefault();
						$(this).parent().parent().siblings("h1")
								.text("SIGN IN");
						$(this).parent().css("opacity", "1");
						$(this).parent().siblings().css("opacity", ".6");

						first_input.addClass("first-input__block").removeClass(
								"signup-input__block");

						$("#loginForm").css({
							"opacity" : "1",
							"display" : "block"
						});
						$("#joinForm").css({
							"opacity" : "0",
							"display" : "none"
						});
					});

					reset.on("click", function(e) {
						e.preventDefault();
						$(this).closest(".container").find("form").find(
								".input__block").find(".input").val("");
					});
				});
	</script>
</body>
</html>