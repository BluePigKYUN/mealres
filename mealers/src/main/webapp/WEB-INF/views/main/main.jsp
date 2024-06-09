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
   .hero-header {
    background-image: url('${pageContext.request.contextPath}/resources/images/main_header_22.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}
    
    .diary-item:hover {
    	box-shadow: 0 0 55px rgba(0, 0, 0, 0.4);
	}

	
    .ratio-4x3 {
     	--bs-aspect-ratio: 60%
    }
    
.vesitable .owl-nav .owl-prev {
    position: absolute;
    top: -8px;
    right: 0;
    color: var(--bs-secondary);
    padding: 5px 25px;
    border: 1px solid var(--bs-secondary);
    border-radius: 20px;
    transition: 0.5s;

}

.vesitable .owl-nav .owl-prev:hover {
    background: var(--bs-secondary);
    color: var(--bs-white);
}

.vesitable .owl-nav .owl-next {
    position: absolute;
    top: -8px;
    right: 88px;
    color: var(--bs-secondary);
    padding: 5px 25px;
    border: 1px solid var(--bs-secondary);
    border-radius: 20px;
    transition: 0.5s;
}

.fruite .tab-class .nav-item a.active {
    background: var(--bs-primary) !important;
}
    
    </style>
    </head>
    <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>
    
        <!-- Hero Start -->
        <div class="container-fluid py-4 mb-3 hero-header">
            <div class="container pt-1 pb-4">
                <div class="row m-2 g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h3 class="mb-3 text-secondary">하루하루 쌓아가는 건강, 함께하는 변화</h3>
                        <h4 class="my-2 display-3 text-primary">Mealers와 함께해요 !</h4>
                        <form class="mt-4 position-relative mx-auto" name="searchForm" action="${pageContext.request.contextPath}/search/main" method="post">
                            <input  name="kwd" value="${kwd}" class="form-control border-2 border-secondary-main w-75 py-3 px-4 rounded-pill" type="text" placeholder="원하는 음식을 검색">
                            <button type="submit" class="btn btn-primary border-2 border-secondary-main py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">영양성분 검색 </button>
                        </form>
                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active rounded">
                                     <img src="${pageContext.request.contextPath}/resources/images/hero-img_1.png" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                     <a href="#" class="btn px-4 py-2 text-white rounded">Fruites</a>
                                </div>
                                <div class="carousel-item rounded">
                                    <img src="${pageContext.request.contextPath}/resources/images/hero-img_2.jpg" class="img-fluid w-100 h-100 rounded" alt="Second slide">
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
                            <ul class="nav nav-pills d-inline-flex text-center mb-3">
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
                         <div id="tab-1" class="tab-pane fade show active">
						        <div class="row g-4">
						            <div class="col-lg-12">
						                <div class="row g-4 m-3 mb-4">
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
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom text-center">
						                                    <h4 class="pb-1">${dto.subject}</h4>
						                                    <!--   <p class="mt-3">${dto.shortTextContent}</p> -->
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
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom text-center">
						                                    <h4 class="pb-1">${dto.shortSubject}</h4>
						                                    <!--  <p class="mt-3">${dto.shortTextContent}</p> -->
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
                         <div id="tab-2" class="tab-pane fade">
						        <div class="row g-4">
						            <div class="col-lg-12">
						                <div class="row g-4 m-3">
						                    <c:forEach var="dto" items="${listExrcscol}" varStatus="state">
						                        <div class="col-md-6 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/exrcsColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/exrcsColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom text-center">
						                                    <h4  class="pb-1">${dto.subject}</h4>
						                                       <!--  <p class="mt-3">${dto.shortTextContent}</p> -->
						                                    <p>${dto.reg_date}</p>
						                                </div>
						                            </div>
						                        </div>
						                    </c:forEach>
                                        </div>
                                        <div class="row g-4 mx-3">
						                    <c:forEach var="dto" items="${listExrcscol2}" varStatus="state">
						                        <div class="col-md-4 ${state.index % 2 == 0 ? 'order-md-1' : 'order-md-2'}">
						                            <div class="rounded position-relative fruite-item">
						                                <div class="fruite-img ratio ratio-4x3">
						                                    <a href="${pageContext.request.contextPath}/exrcsColumn/article?page=1&num=${dto.num}&size=9" class="text-reset">
						                                        <img src="${pageContext.request.contextPath}/uploads/exrcsColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
						                                    </a>
						                                </div>
						                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
						                                    <i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}
						                                </div>
						                                <div class="p-4 border border-primary border-top-0 rounded-bottom text-center">
						                                    <h4  class="pb-1">${dto.shortSubject}</h4>
						                                    <!--  <p class="mt-3">${dto.shortTextContent}</p> -->
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
            

<!-- 일기 배너 시작 -->
<div class="container-fluid banner bg-secondary my-2">
    <div class="container py-5">
        <div>
            <div>
                <div class="py-4">
                    <h4 class="display-8 text-center pb-2" style="color: #FFE400">오늘 하루, 어떤 순간을 기록하고 싶으세요?</h4>
                    <h2 class="display-6 text-center text-white">Mealers와 함께 소중한 일상을 기록하세요</h2>
                    <div class="container py-5">
                        <div class="row g-4 justify-content-center"> 
                            <a href="${pageContext.request.contextPath}/log/event" class="text-reset diary-item counter rounded p-5 col-md-6 col-lg-3 g-2 m-2" style="background-color: #F6F6F6; text-decoration: none;">
                     <!-- 옆에 엑박은 무시해도 됩니다.. html5부터 a태그로 div태그 감싸는거 가넝하다고 합니닷 -->
                                <div class="featurs-item text-center rounded bg-light p-4" style="background-color: gray;"> 
                                    <i class="bi bi-calendar-check fa-3x text-secondary"></i>
                                    <div class="featurs-content text-center">
                                        <h5 class="my-2 py-2 text-secondary">일정 기록</h5>
                                        <p class="mt-1 mb-0">달력으로 일정을<br>관리할 수 있어요</p>
                                    </div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/log/diary" class="text-reset diary-item counter rounded p-5 col-md-6 col-lg-3 g-2 m-2" style="background-color: #F6F6F6; text-decoration: none;">
                                <div class="featurs-item text-center rounded bg-light p-4" style="background-color: gray;">
                                    <i class="bi bi-pencil-square fa-3x text-secondary"></i>
                                    <div class="featurs-content text-center">
                                        <h5 class="my-2 py-2 text-secondary">일상 기록</h5>
                                        <p class="mt-1 mb-0">당신의 순간을<br>기록해 보세요</p>
                                    </div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/log/foodi" class="text-reset diary-item counter rounded p-5 col-md-6 col-lg-3 g-2 m-2" style="background-color: #F6F6F6; text-decoration: none;">
                                <div class="featurs-item text-center rounded bg-light p-4" style="background-color: gray;">
                                    <i class="bi bi-egg-fried fa-3x text-secondary"></i>
                                    <div class="featurs-content text-center">
                                        <h5 class="my-2 py-2 text-secondary">식단 기록</h5>
                                        <p class="mt-1 mb-0">매일의 식단을<br>관리할 수 있어요</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 일기 배너 끝 -->

        <!-- 인기 커뮤니티 시작 -->
        <div class="container-fluid vesitable py-5">
            <div class="container py-5">
                <h1 class="mb-0">실시간 인기 커뮤니티</h1>
                <div class="owl-carousel vegetable-carousel justify-content-center">
                	<c:forEach var="dto" items="${listMealCmnt}" varStatus="state">
                    <div class="border border-secondary rounded position-relative vesitable-item">
                        <div class="vesitable-img">
                            <!--  <img src="${pageContext.request.contextPath}/uploads/mealCmnt/${dto.fileName}" class="img-fluid w-100 rounded-top" alt=""> --> 
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdzcu5K55vm0QzxXsXf8j-XmOnJkc77sGhKw&s" class="img-fluid w-100 rounded-top" alt="">
                        </div>
                        <div class="p-4 rounded-bottom">
                            <h4 class="cmnt-subject">${dto.subject}</h4>
                            <div>
								<!--   <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-person-fill"></i> ${dto.mem_Nick} </div> -->
								<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"> 식단 커뮤니티</div>
							</div>
                            <p class="cmnt-content">${dto.content}</p>
                            <div class="d-flex flex-lg-wrap position-relative start-25 ">
								<span class="text-dark mb-2 pe-2">댓글 10</span> 
								<span class="text-dark mb-3">조회수 ${dto.hitCount}</span>
							</div>
                            <div class="d-flex justify-content-between flex-lg-wrap">
                                <a href="${pageContext.request.contextPath}/mealCmnt/article?${articleUrl}&num=${dto.num}&page=1&mealSort=popular" class="btn border border-secondary rounded-pill px-3 text-secondary">자세히보기</a>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                	<c:forEach var="dto" items="${listExerCmnt}" varStatus="state">
                    <div class="border border-primary rounded position-relative vesitable-item">
                        <div class="vesitable-img">
                            <!--   <img src="${pageContext.request.contextPath}/uploads/exerCmnt/${dto.fileName}" class="img-fluid w-100 rounded-top" alt=""> -->
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdzcu5K55vm0QzxXsXf8j-XmOnJkc77sGhKw&s" class="img-fluid w-100 rounded-top" alt="">
                        </div>
                        <div class="p-4 rounded-bottom">
                            <h4 class="cmnt-subject">${dto.subject}</h4>
                            <div>
								<!--   <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-person-fill"></i> ${dto.mem_Nick} </div> -->
								<div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">  운동 커뮤니티</div>
							</div>
                            <p class="cmnt-content">${dto.content}</p>
                            <div class="d-flex flex-lg-wrap position-relative start-25 ">
								<span class="text-dark mb-2 pe-2">댓글 10</span> 
								<span class="text-dark mb-3">조회수 ${dto.hitCount}</span>
							</div>
                            <div class="d-flex justify-content-between flex-lg-wrap">
                                <a href="${pageContext.request.contextPath}/exerCmnt/article?${articleUrl}&num=${dto.num}&page=1&exerSort=popular" class="btn border border-primary rounded-pill px-3 text-primary">자세히보기</a>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const contents = document.querySelectorAll('.cmnt-content');
        contents.forEach(content => {
            const maxLength = 30;
            if (content.textContent.length > maxLength) {
                content.textContent = content.textContent.substring(0, maxLength) + '...';
            }
        });
    });
    document.addEventListener("DOMContentLoaded", function() {
        const contents = document.querySelectorAll('.cmnt-subject');
        contents.forEach(content => {
            const maxLength = 18;
            if (content.textContent.length > maxLength) {
                content.textContent = content.textContent.substring(0, maxLength) + '...';
            }
        });
    });
</script>

</html>