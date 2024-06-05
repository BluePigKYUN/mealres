<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
    	<script type="text/javascript">
    	function searchList() {
    		const f = document.searchForm;
    		f.submit();
    	}
    	</script>
    	
    <style type="text/css">
    /*
        .hero-header {
            background-image: url('https://blog.mealligram.com/wp-content/uploads/2024/01/%E1%84%83%E1%85%A1.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    */
    </style>
    </head>
    <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>
    
        <!-- Hero Start -->
        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h4 class="mb-3 text-secondary">하루하루 쌓아가는 건강, 함께하는 변화</h4>
                        <h1 class="mb-5 display-3 text-primary" style="font-family: Pretendard-Regular">원하는 식품 검색
                        </h1>
                        <form class="position-relative mx-auto" name="searchForm" action="${pageContext.request.contextPath}/search/main" method="post">
                            <input  name="kwd" value="${kwd}" class="form-control border-2 border-secondary-main w-75 py-3 px-4 rounded-pill" type="text" placeholder="Search">
                            <button type="submit" class="btn btn-primary border-2 border-secondary-main py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">영양성분 검색하기 </button>
                        </form>
                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active rounded">
                                     <img src="/mealers/resources/img/hero-img-1.png" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                     <a href="#" class="btn px-4 py-2 text-white rounded">Fruites</a>
                                </div>
                                <div class="carousel-item rounded">
                                    <img src="/mealers/resources/img/hero-img-2.jpg" class="img-fluid w-100 h-100 rounded" alt="Second slide">
                                    <a href="#" class="btn px-4 py-2 text-white rounded">Vesitables</a>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->

        <!-- 컬럼 -->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="tab-class text-center">
                    <div class="row g-4">
                        <div class="col-lg-4 text-start">
                            <h1 class="mb-0">최신 건강 칼럼</h1>
                        </div>
                        <div class="col-lg-8 text-end">
                            <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-1">
                                        <span class="text-dark" style="width: 130px;">식단 칼럼</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-2">
                                        <span class="text-dark" style="width: 130px;">운동 칼럼</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                         <div id="tab-1" class="tab-pane fade show p-0 active">
						        <div class="row g-4">
						            <div class="col-lg-12">
						                <div class="row g-4 m-3">
						                    <c:forEach var="dto" items="${listMealcol}" varStatus="state">
						                        <div class="col-md-6 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/mealColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/mealColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom">
						                                    <h4>${dto.subject}</h4>
						                                    <p>${dto.shortTextContent}</p>
						                                    <p>${dto.reg_date}</p>
						                                </div>
						                            </div>
						                        </div>
						                    </c:forEach>
                                        </div>
                                        <div class="row g-4 mx-3">
						                    <c:forEach var="dto" items="${listMealcol2}" varStatus="state">
						                        <div class="col-md-4 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/mealColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/mealColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom">
						                                    <h4>${dto.shortSubject}</h4>
						                                    <p>${dto.shortTextContent}</p>
						                                    <p>${dto.reg_date}</p>
						                                </div>
						                            </div>
						                        </div>
						                    </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          <!-- 운동 칼럼 시작 -->
                         <div id="tab-2" class="tab-pane fade show p-0 active">
						        <div class="row g-4">
						            <div class="col-lg-12">
						                <div class="row g-4 m-3">
						                    <c:forEach var="dto" items="${listExercol}" varStatus="state">
						                        <div class="col-md-6 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/mealColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/mealColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom">
						                                    <h4>${dto.subject}</h4>
						                                    <p>${dto.shortTextContent}</p>
						                                    <p>${dto.reg_date}</p>
						                                </div>
						                            </div>
						                        </div>
						                    </c:forEach>
                                        </div>
                                        <div class="row g-4 mx-3">
						                    <c:forEach var="dto" items="${listExercol2}" varStatus="state">
						                        <div class="col-md-4 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/mealColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/mealColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom">
						                                    <h4>${dto.shortSubject}</h4>
						                                    <p>${dto.shortTextContent}</p>
						                                    <p>${dto.reg_date}</p>
						                                </div>
						                            </div>
						                        </div>
						                    </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                       <!-- 운동 칼럼 끝 -->
                        </div>
                    </div>
                </div>      
            </div>

        <!-- 인기 커뮤니티 -->
        <div class="container-fluid vesitable py-5">
            <div class="container py-5">
                <h1 class="mb-0">인기 커뮤니티</h1>
                <div class="owl-carousel vegetable-carousel justify-content-center">
                	<c:forEach var="dto" items="${listMealCmnt}" varStatus="state">
                    <div class="border border-secondary rounded position-relative vesitable-item">
                        <div class="vesitable-img">
                            <!--  <img src="${pageContext.request.contextPath}/uploads/mealCmnt/${dto.fileName}" class="img-fluid w-100 rounded-top" alt=""> --> 
                            <img src="/mealers/resources/img/vegetable-item-3.png" class="img-fluid w-100 rounded-top" alt="">
                        </div>
                        <div class="p-4 rounded-bottom">
                            <h4>${dto.subject}</h4>
                            <div>
								<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${dto.mem_Nick}</div>
							</div>
                            <p>${dto.content}</p>
                            <div class="d-flex flex-lg-wrap position-relative start-25 ">
								<span class="text-dark mb-2 pe-2">댓글 10</span> 
								<span class="text-dark mb-3">조회수 ${dto.hitCount}</span>
							</div>
                            <div class="d-flex justify-content-between flex-lg-wrap">
                                <a href="${pageContext.request.contextPath}/mealCmnt/list?${articleUrl}&num=${dto.num}" class="btn border border-secondary rounded-pill px-3 text-secondary">자세히보기</a>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
        <!-- Vesitable Shop End -->

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