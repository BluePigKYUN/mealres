<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<style>
.custom-card {
	max-width: 350px;
	margin: 20px auto;
	border: 1px solid #ddd;
	border-radius: 15px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.custom-card-header {
	background-color: #20c997;
	color: white;
	font-weight: bold;
	text-align: center;
	padding: 10px;
}

.custom-card-body {
	font-size: 0.9rem;
	color: #555;
	padding: 15px;
}

.custom-card-footer {
	background-color: #f8f9fa;
	text-align: center;
	padding: 10px;
	font-size: 0.8rem;
	color: #777;
}
</style>
</head>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
<body>
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">그룹방</h1>
	</div>
	<!-- Page -->
	<div class="container mt-5">
		<div class="row">

			<div class="col-lg-8">
				<div class="card mb-4">
					<a href="#!"><img class="card-img-top"
						src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
					<div class="card-body">
						<div class="small text-muted">정원</div>
						<h2 class="card-title">그룹명</h2>
						<p class="card-text">그룹소개글</p>
						<a class="btn btn-primary" href="#!">입장</a>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-6">
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">정원</div>
								<h2 class="card-title h4">그룹명</h2>
								<p class="card-text">소개글</p>
								<a class="btn btn-primary" href="#!">입장</a>
							</div>
						</div>
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">정원</div>
								<h2 class="card-title h4">그룹명</h2>
								<p class="card-text">소개글</p>
								<a class="btn btn-primary" href="#!">입장</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">정원</div>
								<h2 class="card-title h4">그룹명</h2>
								<p class="card-text">소개글</p>
								<a class="btn btn-primary" href="#!">입장</a>
							</div>
						</div>
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">정원</div>
								<h2 class="card-title h4">그룹명</h2>
								<p class="card-text">소개글</p>
								<a class="btn btn-primary" href="#!">입장</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Pagination-->
				<nav aria-label="Page navigation example">
					<ul class="pagination d-flex justify-content-center pt-4">
						<li class="page-item m_prev"><a class="page-link" href="#"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item m_next"><a class="page-link" href="#"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
					</ul>
				</nav>
			</div>
			<!-- Side widgets-->
			<div class="col-lg-4">
				<!-- Search widget-->
				<div class="card mb-4">
					<div class="card-header">Search</div>
					<div class="card-body">
						<div class="input-group">
							<input class="form-control" type="text" placeholder="그룹명 검색"
								aria-label="Enter search term..."
								aria-describedby="button-search" />
							<button class="btn btn-primary" id="button-search" type="button">Go!</button>
						</div>
					</div>
				</div>
				<!-- Categories widget-->
				<div class="card mb-4">
					<div class="card-header"></div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-6">
								<ul class="list-unstyled mb-0">
									<li><a
										href="${pageContext.request.contextPath}/group/write">가입</a></li>
									<li><a
										href="${pageContext.request.contextPath}/group/main">리스트</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- Side widget-->
				<div class="card custom-card">
					<div class="card-header custom-card-header">공지사항</div>
					<div class="card-body custom-card-body">다양한 그룹을 둘러보고 마음에 드는
						그룹에 가입 신청하세요. 그룹장의 승인을 받으면 활동에 참여할 수 있습니다. 같은 목표를 가진 사람들과 소통하며 즐거운
						시간을 보내세요!</div>
					<div class="card-footer custom-card-footer">마지막 업데이트:
						2024-05-31</div>
				</div>
			</div>
		</div>
	</div>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
</body>
</html>
