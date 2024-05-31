<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

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

form .input__block{display:flex;gap: 15px;}

form .input__block input {
	display: block;
	/* width: 90%; */
	width: 100%;
	max-width: 680px;
	height: 50px;
	/* margin: 0 auto; */
	border-radius: 8px;
	border: none;
	background: rgba(15, 19, 42, 0.1);
	color: rgba(15, 19, 42, 0.3);
	padding: 0 0 0 15px;
	font-size: 14px;
	font-family: "Montserrat", sans-serif;
}

form .input_btn_box{}


form .input_btn_box .btn_check{
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

/* form .input__block input.repeat__password {
	opacity: 0;
	display: none;
	transition: 0.2s linear;
} */

/* form .signin__btn, */
form .login__btn
 {
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

/* form .signin__btn:hover, */
form .login__btn:hover{
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
				let nickname_block = $("#nickname_block"); // 닉네임 블록 선택자 추가
				//let signin_btn = $("form").find(".signin__btn");

				$("#joinForm").css({ // 블록 숨기기
					"opacity" : "0",
					"display" : "none"
				});

				//----------- sign up ---------------------
				signup.on("click", function(e) {
					e.preventDefault();
					/* $(this).closest(".container").find("h1").text("SIGN UP");
					$(this).css("opacity", "1");
					$(this).siblings().not($(this)).css("opacity", ".6"); */
					
					$(this).parent().parent().siblings("h1").text("SIGN UP");
					$(this).parent().css("opacity", "1");
					$(this).parent().siblings().css("opacity", ".6");
					
					first_input.removeClass("first-input__block").addClass(
							"signup-input__block");
					/* 
					hidden_input.css({
					    "opacity": "1",
					    "display": "block"
					});
					nickname_block.css({ // 닉네임 블록 표시
					    "opacity": "1",
					    "display": "block"
					}); */

					//signin_btn.text("가입하기");
					
					$("#loginForm").css({ // 블록 표시
						"opacity" : "0",
						"display" : "none"
					});
					$("#joinForm").css({ // 블록 숨기기
						"opacity" : "1",
						"display" : "block"
					});
					
				});

				//----------- sign in ---------------------
				signin.on("click", function(e) {
					e.preventDefault();
					/* $(this).closest(".container").find("h1").text("SIGN IN");
					$(this).css("opacity", "1");
					$(this).siblings().not($(this)).css("opacity", ".6"); */
					
					$(this).parent().parent().siblings("h1").text("SIGN IN");
					$(this).parent().css("opacity", "1");
					$(this).parent().siblings().css("opacity", ".6");
					
					first_input.addClass("first-input__block").removeClass(
							"signup-input__block");
					/*
					hidden_input.css({
					   "opacity": "0",
					   "display": "none"
					});
					nickname_block.css({ // 닉네임 블록 숨기기
					   "opacity": "0",
					   "display": "none"
					}); */
					//signin_btn.text("로그인");
					
					
					$("#loginForm").css({ // 블록 표시
						"opacity" : "1",
						"display" : "block"
					});
					$("#joinForm").css({ // 블록 숨기기
						"opacity" : "0",
						"display" : "none"
					});
				});

				//----------- reset ---------------------
				reset.on("click", function(e) {
					e.preventDefault();
					$(this).closest(".container").find("form").find(
							".input__block").find(".input").val("");
				});
			});
</script>
</head>
<body>


	<div class="container">
		<!-- Heading -->
		<h1>Mealers</h1>

		<!-- Links -->
		<ul class="links">
			<li><a href="#" id="signin">로그인</a></li>
			<li><a href="#" id="signup">회원가입</a></li>
			<li><a href="#" id="reset">RESET</a></li>
		</ul>

		<!-- Form -->
		<form name="loginForm" id="loginForm" action="" method="post">
			<div class="first-input input__block first-input__block">
				<input type="text" name="memberId" placeholder="이메일"
					class="input" id="email1" value="admin"/>
			</div>

			<div class="input__block">
				<input type="password" name="memberPwd" placeholder="비밀번호"
					class="input" id="password1" value="admin" />
			</div>

			<button class="login__btn" onclick="sendLogin();">로그인</button>
		</form>

		<form name="joinForm" id="joinForm" action="" method="post">
			<div class="first-input input__block first-input__block input_btn_box">
				<input type="text" name="memberId" placeholder="이메일"
					class="input" id="email2" />
					<button type="button" class="btn_check">확인</button>
			</div>

			<div class="input__block input_btn_box" id="nickname_block">
				<input type="text" placeholder="닉네임" class="input" id="nickname" />
				<button type="button" class="btn_check">확인</button>
			</div>

			<div class="input__block">
				<input type="password" name="memberPwd" placeholder="비밀번호"
					class="input" id="password2" />
			</div>

			<div class="input__block">
				<input type="password" placeholder="비밀번호 확인"
					class="input repeat__password" id="repeat__password" />
			</div>


			<!-- sign in button -->
			<button class="login__btn" onclick="sendLogin();">회원가입</button>
		</form>
	</div>

</body>
</html>