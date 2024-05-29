<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>

     <head>
        <meta charset="utf-8">
        <title>기록 - 기록의 기능들</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="/mealers/resources/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="/mealers/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="/mealers/resources/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="/mealers/resources/css/style_bootstrap.css" rel="stylesheet">
        
        <!-- JangCustom css -->
        <link href="/mealers/resources/css/toggleButton.css" rel="stylesheet">
    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <div class="container topbar bg-primary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">123 Street, New York</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">Email@Example.com</a></small>
                    </div>
                    <div class="top-link pe-2">
                        <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                        <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                        <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                    </div>
                </div>
            </div>
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="index.html" class="navbar-brand"><h1 class="text-primary display-6">MealLog</h1></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="index.html" class="nav-item nav-link">Home</a>
                            <a href="shop.html" class="nav-item nav-link">Shop</a>
                            <a href="shop-detail.html" class="nav-item nav-link">Shop Detail</a>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="cart.html" class="dropdown-item">Cart</a>
                                    <a href="chackout.html" class="dropdown-item active">Chackout</a>
                                    <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                                </div>
                            </div>
                            <div class="nav-item dropdown">
                                <a href="contact.html" class="nav-link dropdown-toggle nav-item active" data-bs-toggle="dropdown">기록</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="${pageContext.request.contextPath}/log/main" class="dropdown-item">소개</a>
                                    <a href="${pageContext.request.contextPath}/log/event" class="dropdown-item">일정기록</a>
                                    <a href="${pageContext.request.contextPath}/log/diary" class="dropdown-item">일상기록</a>
                                    <a href="${pageContext.request.contextPath}/log/foodi" class="dropdown-item">음식기록</a>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                            </a>
                            <a href="#" class="my-auto">
                                <i class="fas fa-user fa-2x"></i>
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        
                <!-- Single Page Header start -->
        <div class="container-fluid py-4">
            <h1 class="text-center display-6 text-black"></h1>
            <ol class="breadcrumb justify-content-center mb-0">
            </ol>
        </div>
        <!-- Single Page Header End -->


        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->

        <!-- Checkout Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-md-12 col-lg-6 col-xl-7">
                        	<h3>기록에 대해...</h3>
                        	<p>오늘의 하루는 어떠셨나요? 밀러즈와 함께 하루를 간직해보는건 어떨까요?</p>
                            <div>
								<table>
									<tr>
										<h5>&nbsp;&nbsp;&nbsp;일기 쓰기</h5>
										<td rowspan = "2">
										<a href = "${pageContext.request.contextPath}/log/diary">
											<img class="mScale" src="/mealers/resources/img/diary_logo.png"></img>
										</a>
										</td>
									</tr>
									<tr>
										<td>
											<p>
											<h6>일기를 작성할 수 있어요.</h6>매일 매일을 작성해보세요.	
											</p>
										</td>
									</tr>
								</table>
                            </div>
                            <div>
                                <table>
									<tr>
										<td rowspan = "2">
										<h5>&nbsp;&nbsp;&nbsp;식단 기록</h5>
											<a href = "${pageContext.request.contextPath}/log/foodi">
											<img class="mScale" src="/mealers/resources/img/meal_logo.png"></img>
											</a>
										</td>
									</tr>
									<tr>
										<td>
											<p><h6>식단을 기록해봐요.</h6>먹은 음식을 매일매일 작성할 수 있어요.</p>
										</td>
									</tr>
								</table>
                            </div>
                            <div>
                            	<table>
									<tr>
										<td rowspan = "2">
										<h5>&nbsp;&nbsp;&nbsp;일정 기록</h5>
										<a href = "${pageContext.request.contextPath}/log/event">
											<img class="mScale" src="/mealers/resources/img/event_logo.png"></img>
										</a>
										</td>
									</tr>
									<tr>
										<td>
											<p><h6>일정을 관리해보세요.</h6>달력을 통해 당신의 일정을 관리할 수 있어요.</p>
										</td>
									</tr>
								</table>
                        	</div>
                     	</div>
            <div class="fixed-button">
                <button class="btn btn-primary" onclick="toggle()">바로가기</button>
                <div id="right-buttons" class="hidden">
                    <a href = "${pageContext.request.contextPath}/log/event"> 
                    <button class="btn btn-secondary">일정</button></a>
                    <a href = "${pageContext.request.contextPath}/log/diary"> 
                    <button class="btn btn-secondary">일상</button></a>
                    <a href = "${pageContext.request.contextPath}/log/foodi"> 
                    <button class="btn btn-secondary">음식</button></a>
                </div>
            </div>
            	</div>
        </div>
        <!-- Checkout Page End -->
        
    <script>
        function toggle() {
            var buttons = document.getElementById("right-buttons");
            if (buttons.classList.contains("hidden")) {
                buttons.classList.remove("hidden");
            } else {
                buttons.classList.add("hidden");
            }
        }
        
        
    </script>

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
            <div class="container py-5">
                <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                    <div class="row g-4">
                        <div class="col-lg-3">
                            <a href="#">
                                <h1 class="text-primary mb-0">MealLog</h1>
                                <p class="text-secondary mb-0">Fresh products</p>
                            </a>
                        </div>
                        <div class="col-lg-3">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->




        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/mealers/resources/lib/easing/easing.min.js"></script>
    <script src="/mealers/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="/mealers/resources/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/mealers/resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/mealers/resources/js/main.js"></script>
    </body>

</html>