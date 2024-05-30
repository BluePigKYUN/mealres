<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>

<style type="text/css">

.content {
   width: 75%;
   margin: 0 auto; /* 가운데 정렬 */
}

.content .border .w-50 {
	flex: 1;
	overflow: hidden;
}

.content .border img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.topContent {
	border-bottom: 1px solid black;
}

.replyContent {
	border-bottom: 1px solid light-gray;
}

</style>
</head>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<body>

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>
	<!-- Single Page Header End -->


	<!-- Single Product Start -->
	<div class="container-fluid py-1 my-4">
		<div class="container py-1 ">
			<div class="row g-4 mb-7 content">
				<div class="w-50 ">
					<div class="border border-3 border-secondary rounded "
						style="max-height: 800px">
						<div style="max-height: 50%">
							<div>
								<a href="#"> <img src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
									class="img-fluid rounded-start object-fit-cover" alt="Image">
								</a>
							</div>
						</div>
						<div style="max-height: 50%">
							<div
								class="d-flex flex-row justify-content-between pt-4 px-4 pb-4">
								<div>
									<div class="text-white bg-secondary px-2 rounded">닉네임인데우짤램1</div>
								</div>
								<div class="">두시간전</div>
							</div>

							<h3 class="fw-bold ms-5 py-4 ps-1">웃지마민병관</h3>

							<div class="ms-5 w-75 pt-3 ps-1">이봐 강호식! 조용히해...
								김은수! 웃지마 민병관! 너 지금 재미없지 강호식! 웃지마 이호창! 곧 헤어질 거야 정태철~ 김순찬이! 변민석이!
								상태야~~ 홍씨.. 홍팍표. 홍석천. 홍록기. 홍길동. 홍진경. 홍익대.</div>


							<div
								class="d-flex flex-row justify-content-between pt-1 pb-3 px-4 mt-5 ">
								<div>댓글10 좋아요15 조회수30</div>
								<div>2024-05-29</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="w-50 border border-2 border-start-0 rounded-end pe-3" style="max-height: 800px">
					
					<div class="replyBox" style="max-height: 80%">
						<div class="col-lg-12 mt-4 topContent">
							<h6>댓글 3개 </h6>
						</div>
						
						<div class="replyContent pb-1">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적지셨네</div>
							</div>
						</div>
						
						<div class="replyContent pb-1">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적지셨네</div>
							</div>
						</div>
						
						<div class="replyContent pb-1">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적지셨네</div>
							</div>
						</div>
						
						<div class="replyContent pb-1">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적지셨네</div>
							</div>
						</div>
					</div>
					
					<form action="#"  style="max-height: 20%">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="border-bottom rounded mt-3">
									<textarea name="reply" class="form-control border-0" cols="30"
										rows="5" placeholder="댓글을 입력하세요 *"></textarea>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="d-flex justify-content-end mb-5">
									<a href="#" class="btn border border-primary text-primary rounded-pill px-3 py-2">등록</a>
								</div>
							</div>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	<!-- Single Product End -->


	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>


	<!-- Back to Top -->
	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
		<i class="fa fa-arrow-up"></i>
	</a>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>


	<!-- Copyright Start -->
	<div class="container-fluid copyright bg-dark py-4">
		<div class="container">
			<div class="row">
				<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
					<span class="text-light"><a href="#"><i
							class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All
						right reserved.</span>
				</div>
				<div class="col-md-6 my-auto text-center text-md-end text-white">
					<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
					<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
					<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
					Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
						Codex</a> Distributed By <a class="border-bottom"
						href="https://themewagon.com">ThemeWagon</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->

</body>

</html>