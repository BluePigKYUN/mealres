<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>MealLog - Vegetable Website Template</title>
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
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="/mealers/resources/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="/mealers/resources/css/style_bootstrap.css" rel="stylesheet">
    </head>

    <body>
    	<!-- header -->
            <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>

        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Mealers가 알려주는 건강 정보</h1>
        </div>
        <!-- Single Page Header End -->


        <!-- Fruits Shop Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <div class="col-xl-3">
                                  <h1 class="mb-4 text-primary">식단 칼럼</h1>
                            </div>
                            <div class="col-6"></div>
                            <div class="col-xl-3">
                                <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                    <label for="fruits">정렬</label>
                                    <select id="fruits" name="fruitlist" class="border-0 form-select-sm bg-light me-3" form="fruitform">
                                        <option value="volvo">최신순</option>
                                        <option value="saab">인기순</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                            <div class="col-lg-13">
                                <div class="row g-4 justify-content-center">
                                    <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                   <div class="col-md-6 col-lg-6 col-xl-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="https://i.namu.wiki/i/ESC_-sL2qz0XHQ0yfac2qEoNhWDo-qwLgRdqtyjeAiz_7ZxTdJ17KFWXqzEbm7dYA5G1uTTZECqTudyv-7hRmg.webp" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                 <div><button type="button" class="text-white btn btn-primary m-2 py-2 rounded-pill">글등록하기</button></div>
                                 
                                <div class="input-group w-75 mx-auto d-flex">
                                    <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                                    <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                                </div>
                                    <div class="col-12">
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


        <!-- Footer Start -->
        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        </footer>
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