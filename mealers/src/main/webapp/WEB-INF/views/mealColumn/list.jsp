<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
    	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<style>
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
        <div class="container-fluid page-header-mealColumn py-5">
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
                                            <div class="fruite-img ratio ratio-4x3">
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
                                            <div class="fruite-img ratio ratio-4x3">
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
                                            <div class="fruite-img ratio ratio-4x3">
                                                <img src="https://flexible.img.hani.co.kr/flexible/normal/970/777/imgdb/resize/2019/0926/00501881_20190926.JPG" class="img-fluid w-100 rounded-top" alt="">
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
                                            <div class="fruite-img ratio ratio-4x3">
                                                <img src="https://pbs.twimg.com/media/FVQXinVaUAA2Lbg.png" class="img-fluid w-100 rounded-top" alt="">
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
                                            <div class="fruite-img ratio ratio-4x3">
                                                <img src="https://image.newsis.com/2023/07/12/NISI20230712_0001313626_web.jpg?rnd=20230712163021" class="img-fluid w-100 rounded-top" style="max-height: 390px;">
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
                                            <div class="fruite-img ratio ratio-4x3">
                                                <img src="https://www.fitpetmall.com/wp-content/uploads/2023/10/230420-0668-1.png" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>12</div>
                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
                                                <h4>Grapes</h4>
                                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                 <div id="right-buttons" class= "d-flex justify-content-end hidden">
				                    <a href = "${pageContext.request.contextPath}/mealColumn/write"> 
				                    	<button type="button" class="text-white btn btn-primary m-3 py-2 rounded-pill">글등록하기</button>
				                    </a>
				                </div>
				                
                              <div class="justify-content-center row board-list-footer">
									<form class="justify-content-center row" name="searchForm" action="${pageContext.request.contextPath}/bbs/list" method="post">
										<div class="col-auto p-1">
											<select name="schType" class="form-select">
												<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
												<option value="userName" ${schType=="userName"?"selected":""}>작성자</option>
												<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
												<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
												<option value="content" ${schType=="content"?"selected":""}>내용</option>
											</select>
										</div>
										<div class="col-auto p-1">
											<input type="text" name="kwd" value="${kwd}" class="form-control">
										</div>
										<div class="col-auto p-1">
											<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
										</div>
									</form>
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
        <!-- Fruits Shop End-->

        <!-- Footer Start -->
        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
			<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
        </footer>
        <!-- Footer End -->
        
    <script type="text/javascript">
    
    </script>
    
    </body>

</html>