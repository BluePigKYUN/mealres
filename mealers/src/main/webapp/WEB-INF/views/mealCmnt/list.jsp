<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
		 
	<style type="text/css">
	.ratio-4x3 {
    position: relative;
    width: 100%;
  }

  .ratio-4x3 img {   
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover; /* 이미지가 비율에 맞게 잘리도록 설정 */
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


	<!-- Fruits Shop Start-->
	<div class="container-fluid fruite py-1">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4 my-2">
						<div class="col-xl-3">
							<div>
								<h2>식단 커뮤니티</h2>
							</div>	
						</div>
						<div class="col-6"></div>
						<div class="col-xl-3">
							<div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
								<label for="meals ml-2">정렬</label> <select id="meals" name="meallist" class="border-0 form-select-md bg-light me-4" form="mealform">
									<option value="recent">최신순</option>
									<option value="hitcount">조회순</option>
									<option value="popular">인기순</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row g-4">
						<div class="col-lg-13">
							<div class="row g-4 justify-content-center">
								<div class="col-ms-4 col-lg-4 col-xl-3 pb-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1587116861219-230ac19df971?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid  rounded-top">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램1</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom ">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-ms-6 col-lg-6 col-xl-3 pb-3 ">
									<div class="rounded position-relative fruite-item ">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://flexible.img.hani.co.kr/flexible/normal/970/777/imgdb/resize/2019/0926/00501881_20190926.JPG" class="img-fluid  rounded-top">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램2</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom ">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-lg-6 col-xl-3 pb-3">
									<div class="rounded position-relative fruite-item ">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
												class="img-fluid w-100 rounded-top " >
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute " style="top: 10px; left: 10px; ">웃지마민병관</div>
											
										</div>
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom ">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-lg-6 col-xl-3 pb-3">
									<div class="rounded position-relative fruite-item ">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1582716454502-f0925ab107aa?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
												class="img-fluid w-100 rounded-top " >
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램3</div>
											
										</div>
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom " >
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-ms-4 col-lg-4 col-xl-3 pb-2">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1587116861219-230ac19df971?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid  rounded-top ">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램1</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-ms-4 col-lg-4 col-xl-3 pb-2">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1587116861219-230ac19df971?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid  rounded-top ">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램1</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom ">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-ms-4 col-lg-4 col-xl-3 pb-2">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://images.unsplash.com/photo-1587116861219-230ac19df971?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid  rounded-top ">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램1</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-ms-4 col-lg-4 col-xl-3 pb-2">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img ratio ratio-4x3">
											<img src="https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/472/5108241b97436af498bf14ba4ab3d68a_res.jpeg" class="img-fluid  rounded-top ">
										</div>
										
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램1</div>
										</div>
										
										<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom">
											<div class="d-flex justify-content-between mt-2">
												<p class="py-1">2시간전</p>
												<p class="py-1">2024-05-29</p>
											</div>
											<h4 class="pb-2 pt-3 text-center">오늘 점심식단입니다</h4>
											<p>내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.</p>
											<div class="d-flex flex-lg-wrap position-relative start-25 mt-5">
												<p class="text-dark mb-2 pe-2">댓글10</p> 
												<p class="text-dark mb-2 pe-2">좋아요8</p>
												<p class="text-dark mb-3">조회수20</p>
											</div>
										</div>
									</div>
								</div>
								
								<div style="text-align: right">
									<button type="button" class="text-white bg-secondary px-3 pt-1 rounded border-secondary" onclick="location.href='${pageContext.request.contextPath}/mealCmnt/write';">글쓰기</button>
								</div>
								
								<div class="col-6 d-flex justify-content-evenly mt-3">
									<select name="schCategory" class="rounded drop-down h-50 p-4 w-25 me-2">
										<option value="subcon">제목+내용</option>
										<option value="subject">제목</option>
										<option value="content">내용</option>
										<option value="writer">작성자</option>
									</select>
										 
									<div class="input-group w-75  d-flex">
										<input type="search" class="form-control p-4 h-50" placeholder="검색" aria-describedby="search-icon-1"> 
										<span id="search-icon-1" class="input-group-text p-4 h-50">
											<i class="fa fa-search"></i>
										</span>
									</div>
								</div>
								
								<nav aria-label="Page navigation example">
									<ul class="pagination d-flex justify-content-center">
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
			</div>
		</div>
	</div>
	<!-- Fruits Shop End-->


	

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>

	<!-- Back to Top -->
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
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