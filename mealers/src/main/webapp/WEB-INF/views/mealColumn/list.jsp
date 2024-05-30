<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
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
                                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/300px-Cat_November_2010-1a.jpg" class="img-fluid w-100 rounded-top" style="max-height: 390px;">
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
                                    
                                 <div id="right-buttons" class="hidden">
				                    <a href = "${pageContext.request.contextPath}/mealColumn/write"> 
				                    	<button type="button" class="text-white btn btn-primary m-2 py-2 rounded-pill">글등록하기</button>
				                    </a>
				                </div>
                                 
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
        <!-- Fruits Shop End-->

        <!-- Footer Start -->
        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        </footer>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
    </body>

</html>