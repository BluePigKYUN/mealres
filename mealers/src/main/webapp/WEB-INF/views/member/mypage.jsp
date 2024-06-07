<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<!--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>

<style type="text/css">
.h4 {
	font-size: 1.5rem;
	font-weight: bold;
}

.hidden {
	display: none;
}

.button-container {
	margin-top: 20px;
}

.button-container button {
	margin-right: 10px;
}

.bg-danger {
	background-color: #F88264 !important;
}

.btn-danger {
	color: #1b1919;
	background-color: #756d6e91;
	border-color: #7c5559;
}

.btn-danger:hover {
	color: #3a3a3a;
	background-color: #baaeaf;
	border-color: #080808;
}
</style>
</head>
<body>
	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="bg-light rounded p-5">
					<!-- 프로필 사진 업로드 -->
					<div class="text-center mb-4">
						<div class="profile-picture-container">
							<img id="profile-picture-preview" src="default-profile.png"
								alt="Profile Picture" class="rounded-circle"
								style="width: 150px; height: 150px; object-fit: cover; cursor: pointer;">
							<input type="file" id="profile-picture" class="form-control mt-2"
								accept="image/*" style="display: none;">
						</div>
					</div>

					<h1 class="text-primary text-center mb-4">${dto.mem_Nick}</h1>
					<form action="" id="pwdForm" name="pwdForm" method="post">
						<div class="mb-3">
							<i class="bi bi-person-fill fa-2x text-primary me-4"></i> <label
								for="m_name" class="h4">ID</label> <input type="text"
								class="form-control" id="memberId" name="memberId"
								value="${dto.memberId}" readonly>
						</div>
						<div class="mb-3">
							<i class="bi bi-person-fill fa-2x text-primary me-4"></i> <label
								for="m_name" class="h4">닉네임</label> <input type="text"
								class="form-control" id="mem_Nick" name="mem_Nick"
								value="${dto.mem_Nick}">
						</div>
						<div class="mb-3">
							<i class="fas fa-envelope fa-2x text-primary me-4"></i> <label
								for="nickname" class="form-label fw-bold">이메일</label> <input
								type="text" class="form-control" id="mem_Email" name="mem_Email"
								value="${dto.mem_Email}">
						</div>
						<div class="mb-3">
							<label for="current_password" class="form-label fw-bold">
								<i class="bi bi-file-lock2 text-primary me-2"></i> 현재 비밀번호
							</label> <input type="password" class="form-control" id="memberPwd"
								name="memberPwd" autocomplete="current-password">
							<button type="button" class="btn btn-link"
								id="change-password-btn">비밀번호 변경</button>
						</div>

						<div id="new-password-container" class="hidden">
							<div class="mb-3">
								<label for="newpassword" class="form-label fw-bold"> <i
									class="bi bi-file-lock2 text-primary me-2"></i> 비밀번호 변경
								</label> <input type="password" class="form-control" id="newpassword">
							</div>

							<div class="mb-3">
								<label for="confirmpassword" class="form-label fw-bold">
									<i class="bi bi-file-lock2 text-primary me-2"></i> 비밀번호 확인
								</label> <input type="password" class="form-control"
									id="confirmpassword" name="confirmpassword">
							</div>
						</div>
						<input type="hidden" name="mode" id="mode" value="">
					</form>
					<div class="text-center button-container">
						<button type="submit" class="btn btn-primary" id="submit-btn"
							onclick="sendOk(1)">변경</button>
						<button type="button" class="btn btn-danger" onclick="sendOk(2)">회원
							탈퇴</button>
					</div>
					<div class="d-grid">
						<p class="form-control-plaintext text-center">${message}</p>
					</div>
				</div>
			</div>
		</div>
	</div>


	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
	</footer>

	<script>
	
		//비밀번호 확인
		function sendOk(flag) {
			const f = document.pwdForm;

			let str = f.memberPwd.value;
			if (!str) {
				alert("패스워드를 입력하세요. ");
				f.memberPwd.focus();
				return;
			}

			if (flag == 1) {

				let strpwd = f.confirmpassword.value;

				if (strpwd == "") {
					f.mode.value = "update";
					console.log(strpwd);
				} else {
					f.mode.value = "pwdupdate";
					console.log(strpwd);
				}
			}

			else if (flag == 2) {
				alert("탈퇴 시 복구할 수 없습니다. 진행하시겠습니까?")
				f.mode.value = "delete";
			}

			f.action = "${pageContext.request.contextPath}/member/pwd";
			f.submit();
		}

		$(document).ready(function() {
			/* $('#submit-btn').click(function(event) {
			    event.preventDefault();
			    validatePassword();
			}); */

			$('#change-password-btn').click(function() {
				$('#new-password-container').toggleClass('hidden');
			});
		});

		function previewProfilePicture(event) {
			const reader = new FileReader();
			reader.onload = function() {
				const output = document
						.getElementById('profile-picture-preview');
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		}

		$(document).ready(function() {
			$('#profile-picture-preview').click(function() {
				$('#profile-picture').click();
			});

			$('#profile-picture').change(function(event) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#profile-picture-preview').attr('src', e.target.result);
				};
				reader.readAsDataURL(event.target.files[0]);
			});
		});
	</script>
</body>
</html>
