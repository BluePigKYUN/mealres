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


	<!-- Single Product Start -->
	<div class="container-fluid py-5 mt-5">
		<div class="container py-5">
			<div class="row g-4 mb-5">
				<div class="col-lg-8 col-xl-9">
					<div class="row g-4">
						<div class="col-lg-6">
							<div class="border rounded">
								<a href="#"> 
									<img src="" class="img-fluid rounded" alt="Image">
								</a>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="d-flex flex-row justify-content-between">
								<div class="fw-bold mb-3">울지마민병관</div>
								<div class="">두시간전</div>
							</div>
							
							<h5 class="fw-bold mt-3 mb-5">제목입니다.</h5>
							
							<div class="mb-5">The generated Lorem Ipsum is therefore always
								free from repetition injected humour, or non-characteristic
								words etc.</div>
							
							<div class="d-flex flex-row justify-content-between mt-2">
								<div class="fw-bold mb-3">댓글10 좋아요15 조회수30</div>
								<div >2024-05-29</div>
							</div>
							
							
						</div>
						<div class="col-lg-12">
							<h6>댓글</h6>
							<hr>
							<div class="tab-content mb-5">
								
								<div class="tab-pane" id="nav-mission" role="tabpanel"
									aria-labelledby="nav-mission-tab">
									<div class="d-flex">
										<img src="" class="img-fluid rounded-circle p-3"
											style="width: 100px; height: 100px;" alt="">
										<div class="">
											<p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
											<div class="d-flex justify-content-between">
												<h5>Jason Smith</h5>
												<div class="d-flex mb-3">
													<i class="fa fa-star text-secondary"></i> <i
														class="fa fa-star text-secondary"></i> <i
														class="fa fa-star text-secondary"></i> <i
														class="fa fa-star text-secondary"></i> <i
														class="fa fa-star"></i>
												</div>
											</div>
											<p>The generated Lorem Ipsum is therefore always free
												from repetition injected humour, or non-characteristic words
												etc. Susp endisse ultricies nisi vel quam suscipit</p>
										</div>
									</div>
									<div class="d-flex">
										<img src="" class="img-fluid rounded-circle p-3"
											style="width: 100px; height: 100px;" alt="">
										<div class="">
											<p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
											<div class="d-flex justify-content-between">
												<h5>Sam Peters</h5>
												<div class="d-flex mb-3">
													<i class="fa fa-star text-secondary"></i> <i
														class="fa fa-star text-secondary"></i> <i
														class="fa fa-star text-secondary"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star"></i>
												</div>
											</div>
											<p class="text-dark">The generated Lorem Ipsum is
												therefore always free from repetition injected humour, or
												non-characteristic words etc. Susp endisse ultricies nisi
												vel quam suscipit</p>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="nav-vision" role="tabpanel">
									<p class="text-dark">Tempor erat elitr rebum at clita. Diam
										dolor diam ipsum et tempor sit. Aliqu diam amet diam et eos
										labore. 3</p>
									<p class="mb-0">Diam dolor diam ipsum et tempor sit. Aliqu
										diam amet diam et eos labore. Clita erat ipsum et lorem et sit</p>
								</div>
							</div>
						</div>
						<form action="#">
							<h4 class="mb-5 fw-bold">Leave a Reply</h4>
							<div class="row g-4">
								<div class="col-lg-6">
									<div class="border-bottom rounded">
										<input type="text" class="form-control border-0 me-4"
											placeholder="Yur Name *">
									</div>
								</div>
								<div class="col-lg-6">
									<div class="border-bottom rounded">
										<input type="email" class="form-control border-0"
											placeholder="Your Email *">
									</div>
								</div>
								<div class="col-lg-12">
									<div class="border-bottom rounded my-4">
										<textarea name="" id="" class="form-control border-0"
											cols="30" rows="8" placeholder="Your Review *"
											spellcheck="false"></textarea>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="d-flex justify-content-between py-3 mb-5">
										<div class="d-flex align-items-center">
											<p class="mb-0 me-3">Please rate:</p>
											<div class="d-flex align-items-center"
												style="font-size: 12px;">
												<i class="fa fa-star text-muted"></i> <i class="fa fa-star"></i>
												<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
													class="fa fa-star"></i>
											</div>
										</div>
										<a href="#"
											class="btn border border-secondary text-primary rounded-pill px-4 py-3">
											Post Comment</a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="col-lg-4 col-xl-3">
					<div class="row g-4 fruite">
						<div class="col-lg-12">
							<div class="input-group w-100 mx-auto d-flex mb-4">
								<input type="search" class="form-control p-3"
									placeholder="keywords" aria-describedby="search-icon-1">
								<span id="search-icon-1" class="input-group-text p-3"><i
									class="fa fa-search"></i></span>
							</div>
							<div class="mb-4">
								<h4>Categories</h4>
								<ul class="list-unstyled fruite-categorie">
									<li>
										<div class="d-flex justify-content-between fruite-name">
											<a href="#"><i class="fas fa-apple-alt me-2"></i>Apples</a> <span>(3)</span>
										</div>
									</li>
									<li>
										<div class="d-flex justify-content-between fruite-name">
											<a href="#"><i class="fas fa-apple-alt me-2"></i>Oranges</a>
											<span>(5)</span>
										</div>
									</li>
									<li>
										<div class="d-flex justify-content-between fruite-name">
											<a href="#"><i class="fas fa-apple-alt me-2"></i>Strawbery</a>
											<span>(2)</span>
										</div>
									</li>
									<li>
										<div class="d-flex justify-content-between fruite-name">
											<a href="#"><i class="fas fa-apple-alt me-2"></i>Banana</a> <span>(8)</span>
										</div>
									</li>
									<li>
										<div class="d-flex justify-content-between fruite-name">
											<a href="#"><i class="fas fa-apple-alt me-2"></i>Pumpkin</a>
											<span>(5)</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-lg-12">
							<h4 class="mb-4">Featured products</h4>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded"
										alt="Image">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded" alt="">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded" alt="">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded me-4" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded"
										alt="">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded me-4" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded"
										alt="">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex align-items-center justify-content-start">
								<div class="rounded me-4" style="width: 100px; height: 100px;">
									<img src="" class="img-fluid rounded"
										alt="">
								</div>
								<div>
									<h6 class="mb-2">Big Banana</h6>
									<div class="d-flex mb-2">
										<i class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i
											class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
									</div>
									<div class="d-flex mb-2">
										<h5 class="fw-bold me-2">2.99 $</h5>
										<h5 class="text-danger text-decoration-line-through">4.11
											$</h5>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-center my-4">
								<a href="#"
									class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew
									More</a>
							</div>
						</div>
						<div class="col-lg-12">
							<div class="position-relative">
								<img src="" class="img-fluid w-100 rounded"
									alt="">
								<div class="position-absolute"
									style="top: 50%; right: 10px; transform: translateY(-50%);">
									<h3 class="text-secondary fw-bold">
										Fresh <br> Fruits <br> Banner
									</h3>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<h1 class="fw-bold mb-0">Related products</h1>
			<div class="vesitable">
				<div class="owl-carousel vegetable-carousel justify-content-center">
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Parsely</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Parsely</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top bg-light" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Banana</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Bell Papper</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Potatoes</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Parsely</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Potatoes</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<img src=""
								class="img-fluid w-100 rounded-top" alt="">
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">Vegetable</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>Parsely</h4>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit
								sed do eiusmod te incididunt</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
								<a href="#"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
									class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Single Product End -->


	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>


	<!-- Back to Top -->
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"> <i class="fa fa-arrow-up"></i> </a>
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