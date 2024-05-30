<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
	 <jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
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
					<div class="row g-4">
						<div class="col-xl-3">
							<div>
								<h2>우수회원 커뮤니티</h2>
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
								<div class="col-ms-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img h-50">
											<img src="https://images.unsplash.com/photo-1619371042685-827b1c646923?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램</div>
											
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
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img h-50">
											<img src="https://images.unsplash.com/photo-1587116861219-230ac19df971?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
												class="img-fluid w-100 rounded-top">
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램</div>
											
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
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img h-50">
											<img src="https://images.unsplash.com/photo-1591814468924-caf88d1232e1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
												class="img-fluid w-100 rounded-top object-fit-cover">
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램</div>
											
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
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img h-50">
											<img src="https://images.unsplash.com/photo-1582716454502-f0925ab107aa?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
												class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div>
											<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">닉네임인데우짤램</div>
											
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
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img">
											<img src=""
												class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div
											class="text-white bg-secondary px-3 py-1 rounded position-absolute"
											style="top: 10px; left: 10px;">Fruits</div>
										<div
											class="p-4 border border-secondary border-top-0 rounded-bottom">
											<h4>Banana</h4>
											<p>Lorem ipsum dolor sit amet consectetur adipisicing
												elit sed do eiusmod te incididunt</p>
											<div class="d-flex justify-content-between flex-lg-wrap">
												<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
												<!-- <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a> -->
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img">
											<img src=""
												class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div
											class="text-white bg-secondary px-3 py-1 rounded position-absolute"
											style="top: 10px; left: 10px;">Fruits</div>
										<div
											class="p-4 border border-secondary border-top-0 rounded-bottom">
											<h4>Oranges</h4>
											<p>Lorem ipsum dolor sit amet consectetur adipisicing
												elit sed do eiusmod te incididunt</p>
											<div class="d-flex justify-content-between flex-lg-wrap">
												<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
												<!-- <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a> -->
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img">
											<img src=""
												class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div
											class="text-white bg-secondary px-3 py-1 rounded position-absolute"
											style="top: 10px; left: 10px;">Fruits</div>
										<div
											class="p-4 border border-secondary border-top-0 rounded-bottom">
											<h4>Raspberries</h4>
											<p>Lorem ipsum dolor sit amet consectetur adipisicing
												elit sed do eiusmod te incididunt</p>
											<div class="d-flex justify-content-between flex-lg-wrap">
												<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
												<!-- <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a> -->
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-lg-6 col-xl-3">
									<div class="rounded position-relative fruite-item">
										<div class="fruite-img">
											<img src=""
												class="img-fluid w-100 rounded-top" alt="">
										</div>
										<div
											class="text-white bg-secondary px-3 py-1 rounded position-absolute"
											style="top: 10px; left: 10px;">Fruits</div>
										<div
											class="p-4 border border-secondary border-top-0 rounded-bottom">
											<h4>Grapes</h4>
											<p>Lorem ipsum dolor sit amet consectetur adipisicing
												elit sed do eiusmod te incididunt</p>
											<div class="d-flex justify-content-between flex-lg-wrap">
												<p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
												<!-- <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a> -->
											</div>
										</div>
									</div>
								</div>
								<div class="col-12 d-flex justify-content-evenly">
									<div class="input-group w-50 mx-auto d-flex">
										<input type="search" class="form-control p-3 h-50" placeholder="검색" aria-describedby="search-icon-1"> 
										<span id="search-icon-1" class="input-group-text p-3 h-50">
											<i class="fa fa-search"></i>
										</span>
									</div>
								
									<div class="pagination d-flex justify-content-center mt-5">
										<a href="#" class="rounded">&laquo;</a> 
										<a href="#" class="active rounded">1</a> 
										<a href="#" class="rounded">2</a>
										<a href="#" class="rounded">3</a> 
										<a href="#" class="rounded">4</a>
										<a href="#" class="rounded">5</a> 
										<a href="#" class="rounded">6</a>
										<a href="#" class="rounded">&raquo;</a>
									</div>
								</div>
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