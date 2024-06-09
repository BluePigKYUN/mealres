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
        <div class="container-fluid page-header-exrcsColumn py-5">
            <h1 class="text-center text-white display-6">Mealers가 알려주는 최신 건강 정보</h1>
        </div>
        <!-- Single Page Header End -->


        <!-- Fruits Shop Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <div class="col-xl-3">
                                  <h1 class="mb-4 text-primary">운동 칼럼</h1>
                            </div>
                            <div class="col-6"></div>
                            <div class="col-xl-3">
                                <div class="ps-3 py-3 rounded d-flex justify-content-end mb-4">
                                    <div class="col-auto">
                                    <form name="listForm" method="post">
										<c:if test="${dataCount != 0 }">
											<select name="size" class="form-select" onchange="changeList();">
												<option value="6" ${size==6 ? "selected" : ""}> 6개 출력 </option>
												<option value="9" ${size==9 ? "selected" : ""}> 9개 출력 </option>
												<option value="12" ${size==12 ? "selected" : ""}> 12개 출력 </option>
												<option value="15" ${size==15 ? "selected" : ""}> 15개 출력 </option>
											</select>
										</c:if>
										
										<input type="hidden" name="size" value="${size}">
										<input type="hidden" name="page" value="${page}">
										<input type="hidden" name="schType" value="${schType}">
										<input type="hidden" name="kwd" value="${kwd}">
										</form>
									</div>
                                </div>
                            </div>
                            
                        </div>
                            <div class="col-lg-13">
                                <div class="row g-4 justify-content-center">
                                	<c:forEach var="dto" items="${list}" varStatus="state">
	                                    <div class="col-md-6 col-lg-6 col-xl-4">
	                                        <div class="rounded position-relative fruite-item">
	                                            <div class="fruite-img ratio ratio-4x3">
	                                       			<a href="${articleUrl}&num=${dto.num}" class="text-reset">
	                                                	<img src="${pageContext.request.contextPath}/uploads/exrcsColumn/${dto.saveFilename}" class="img-fluid w-100 rounded-top" alt=""> 
	                                                </a>
	                                            </div>
	                                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;"><i class="bi bi-eye" style="letter-spacing: 10px;"></i>${dto.hitCount}</div>

	                                            <div class="p-4 border border-primary border-top-0 rounded-bottom">
	                                                <h4>${dto.shortSubject}</h4>
	                                                <p>${dto.shortTextContent}</p>
	                                               <p>${dto.reg_date}</p>
	                                            </div>
	                                        </div>
	                                    </div>
                                    </c:forEach>
                                    
                                    
                                    
                                    </div>
                                  
                                   
                                 <c:if test="${sessionScope.member.userNum == '1'}">
                                 <div id="right-buttons" class= "d-flex justify-content-end hidden">
				                    <a href = "${pageContext.request.contextPath}/exrcsColumn/write"> 
				                    	<button type="button" class="text-white btn btn-primary m-3 mt-4 py-2 rounded-pill">글등록하기</button>
				                    </a>
				                </div>
				                </c:if>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
				                
				                <div>
				                	<div class="col-auto me-auto my-4 mt-4 pt-3">${dataCount}개 (${page}/${total_page} 페이지)</div>
				                </div>
				                
                              <div class="justify-content-center row board-list-footer">
									<form class="mb-4 justify-content-center row" name="searchForm" action="${pageContext.request.contextPath}/exrcsColumn/list" method="post">
										<div class="col-auto p-1">
											<select name="schType" class="form-select">
												<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
												<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
												<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
												<option value="content" ${schType=="content"?"selected":""}>내용</option>
											</select>
										</div>
										<div class="col-auto p-1">
											<input type="text" name="kwd" value="${kwd}" class="form-control">
										</div>
										<div class="col-auto p-1">
										<input type="hidden" name="size" value="${size}">
											<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
										</div>
									</form>
							</div>

						
     						<nav class="text-center text-primary" aria-label="Page navigation example">
     							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
     						</nav>
							    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
			<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
        </footer>
        <!-- Footer End -->
        
    <script type="text/javascript">
    function searchList() {
    	const f = document.searchForm;
    	f.submit();
    }
    
    function changeList() {
    	 var size = document.querySelector('select[name="size"]').value;
    	    var form = document.forms['listForm']; // 폼 요소를 찾음
    	    form.action = '${pageContext.request.contextPath}/exrcsColumn/list?size=' + size; // 폼의 action 속성을 설정
    	    form.submit(); // 폼 제출
    }
    
    </script>
    
    </body>

</html>