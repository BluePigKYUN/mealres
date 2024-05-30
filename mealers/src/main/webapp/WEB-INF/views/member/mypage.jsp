<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
</head>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<body>

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">Mypage</h1>
	</div>
	<!-- Single Page Header End -->


	<!-- Mypage -->
	<div class="container-fluid contact py-5">
		<div class="container py-5">
			<div class="p-5 bg-light rounded">
				<div class="row g-4">
					<div class="col-12">
						<div class="text-center mx-auto" style="max-width: 700px;">
 						<img class="d-block mx-auto mb-4"
								src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg"
								alt="" width="72" height="72"> 
							<h1 class="text-primary">요거트맛젤리</h1>
						</div>
					</div>
					<div class="col-lg-12 m_form">
						<div class="d-flex p-4 rounded bg-white">
							<i class="fas fa-map-marker-alt fa-2x text-primary me-4"></i>
							<div class="mb-3">
								<label for="m_name"><h4>닉네임</h4></label> <input type="text"
									class="form-control" id="m_name">
							</div>
						</div>
						<div class="d-flex p-4 rounded bg-white">
							<i class="fas fa-envelope fa-2x text-primary me-4"></i>
							<div class="mb-3">
								<label for="m_email"><h4>이메일</h4></label>
								<div class="m_txt">you@example.com</div>
								<input type="text"
									class="form-control <%-- form-control-plaintext --%>"
									id="m_email"
									<%-- readonly --%>
									placeholder="you@example.com">
								<!-- readonly class="form-control-plaintext" -->
							</div>
						</div>
						<div class="d-flex p-4 rounded bg-white">
							<i class="fa fa-phone-alt fa-2x text-primary me-4"></i>
							<div class="mb-3">
								<label for="m_pwd"><h4>비밀번호</h4></label> <input type="password"
									class="form-control" id="m_pwd">
							</div>
						</div>
						<div class="d-flex p-4 rounded bg-white">
							<i class="fa fa-phone-alt fa-2x text-primary me-4"></i>
							<div class="mb-3">
								<label for="m_pwd2"><h4>비밀번호2</h4></label> <input
									type="password" class="form-control<%--  border-0 --%>"
									id="m_pwd2">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //Mypage -->

	<!-- 내 활동 -->
	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4">
					<div class="col-lg-4 text-start">
						<h1 class="mb-0">내 활동</h1>
					</div>
					<div class="col-lg-8 text-end">
						<ul class="nav nav-pills d-inline-flex text-center mb-5">
							<li class="nav-item"><a
								class="d-flex m-2 py-2 bg-light rounded-pill active"
								data-bs-toggle="pill" href="#tab-1"> <span class="text-dark"
									style="width: 130px;">게시물</span>
							</a></li>
							<li class="nav-item"><a
								class="d-flex py-2 m-2 bg-light rounded-pill"
								data-bs-toggle="pill" href="#tab-2"> <span class="text-dark"
									style="width: 130px;">댓글</span>
							</a></li>
							<li class="nav-item"><a
								class="d-flex m-2 py-2 bg-light rounded-pill"
								data-bs-toggle="pill" href="#tab-3"> <span class="text-dark"
									style="width: 130px;">좋아요</span>
							</a></li>
						</ul>
					</div>
				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<!-- 탭 1 -->
						<table class="table table-hover mob_table">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
									<td><a href="#">제목입니다. 제목입니다.</a></td>
									<td>행복이</td>
									<td>2099-99-99</td>
									<td><span class="badge text-bg-secondary">대기</span></td>
								</tr>
								<tr>
									<th scope="row">2</th>
									<td><a href="#">제목입니다. 제목입니다.</a></td>
									<td>불행이</td>
									<td>2099-99-99</td>
									<td><span class="badge text-bg-success">활동중</span></td>
								</tr>
								<tr>
									<th scope="row">3</th>
									<td><a href="#">제목입니다. 제목입니다.</a></td>
									<td>슬픔이</td>
									<td>2099-99-99</td>
									<td><span class="badge text-bg-success">활동중</span></td>
								</tr>
							</tbody>
						</table>

						<nav aria-label="Page navigation example">
							<ul class="pagination d-flex justify-content-center pt-4">
								<li class="page-item m_prev"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item m_next"><a class="page-link" href="#"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
						<!-- //탭 1 -->
					</div>
					<div id="tab-2" class="tab-pane fade show p-0">
						<!-- 탭 2 -->

						<!-- //탭 2 -->
					</div>
					<div id="tab-3" class="tab-pane fade show p-0">
						<!-- 탭 3 -->

						<!-- //탭 3 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //내 활동 -->

	<!-- 내 활동 -->
	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-4 text-start">
					<h1 class="mb-0">내 그룹</h1>
				</div>
				<table class="table table-hover mob_table">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>행복이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-secondary">대기</span></td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>불행이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-success">활동중</span></td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>슬픔이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-success">활동중</span></td>
						</tr>
					</tbody>
				</table>

				<nav aria-label="Page navigation example">
					<ul class="pagination d-flex justify-content-center pt-4">
						<li class="page-item m_prev"><a class="page-link" href="#"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item m_next"><a class="page-link" href="#"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	</div>
	<!-- //내 활동 -->




	<!-- Footer Start -->
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>
	<!-- Footer End -->


	<!-- Back to Top -->
	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
		class="fa fa-arrow-up"></i></a>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
</body>

</html>