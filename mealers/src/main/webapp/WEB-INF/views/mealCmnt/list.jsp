<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
		 
<style type="text/css">
.ratio-4x3 {
 	position: relative;
    width: 100%;
    height: 0;
    padding-top: 75%;
}

.ratio-4x3 img {   
    position: absolute;
    width: 100%;
    height: 100%;
    object-fit: cover;
    max-width: 100%;
    max-height: 100%;
}

.input-group-text:hover, .content-box:hover {
	cursor: pointer;
}

.content-control {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
}

.subject-control {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}

.meal-item:hover {
	box-shadow: 0 0 55px rgba(0, 0, 0, 0.4);
	
}

.meal-item {
    transition: 0.5s;
}

</style>

</head>
	
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

	<div class="container-fluid page-header-cmnt py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>

	<div class="container-fluid fruite py-1">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4 my-2">
						<div class="d-flex justify-content-between">
							<div>
								<h2>식단 커뮤니티</h2>
							</div>	
							<form name="sortForm" action="${pageContext.request.contextPath}/mealCmnt/list" method="post">
								<div class="bg-light ps-3 py-3 rounded mb-4">
									<label for="mealSort">정렬</label> 
									<select name="mealSort" id="mealSort" class="border-0 form-select-md bg-light mx-3 mealSort">
										<option value="recent" ${mealSort=="recent"?"selected":""}>최신순</option>
										<option value="hitcount" ${mealSort=="hitcount"?"selected":""}>조회순</option>
										<option value="popular" ${mealSort=="popular"?"selected":""}>인기순</option>
									</select>
								</div>
							</form>
						</div>
						<div class="mb-3">${dataCount}개 (${page}/${total_page}페이지)	</div>
					</div>
					<div class="row g-4">
						<div class="col-lg-12">
							<div class="row g-4 justify-content-start">
								<c:choose>
									<c:when test="${empty list}">
										<div class="d-flex">
											<div class=" d-flex fw-bold justify-content-center align-content-center" style="height: 500px">게시물이 존재하지 않습니다.</div>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach var="dto" items="${list}" varStatus="status">
											<div class="col-md-4 col-lg-4 col-xl-3 pb-3 mb-3" style="max-height: 600px">
												<div class="rounded position-relative meal-item content-box" onclick="location.href='${articleUrl}&num=${dto.num}';">
													<div class="fruite-img ratio ratio-4x3">
														<img src="${pageContext.request.contextPath}/uploads/mealCmnt/${dto.fileName}" class="img-fluid  rounded-top">
													</div>
													
													<div>
														<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${dto.mem_Nick}</div>
													</div>
													
													<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom">
														<div class="d-flex justify-content-between mt-2">
															
															<c:choose>
																<c:when test="${dto.timeGap/60 < 24}">
																	<c:choose>
																		<c:when test="${dto.timeGap == 0}">
																			<p class="py-1 text-secondary">지금</p>
																		</c:when>
																		<c:when test="${dto.timeGap < 60}">
																			<p class="py-1 text-secondary">${dto.timeGap}분전</p>
																		</c:when>
																		<c:otherwise>
																			<p class="py-1 text-secondary">${Math.floor(dto.timeGap/60)}시간전</p>
																		</c:otherwise>
																	</c:choose>	
																</c:when>
															</c:choose>
															<p class="py-1">${dto.reg_date}</p>
														</div>
														<div class="pt-3 mb-4 text-center subject-control fw-bold fs-5">${dto.subject}</div>
														<div class="content-control" style="min-height: 72px">${dto.content}</div>
														<div class="d-flex flex-lg-wrap position-relative start-25 ">
															<span class="text-dark mb-2 pe-2">댓글10</span> 
															<span class="text-dark mb-2 pe-2">좋아요${dto.likeCount}</span>
															<span class="text-dark mb-3">조회수${dto.hitCount}</span>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								
								</c:choose>
								

								<div style="text-align: right">
									<button type="button" class="text-white bg-secondary px-3 pt-1 rounded border-secondary" onclick="location.href='${pageContext.request.contextPath}/mealCmnt/write';">글쓰기</button>
								</div>
								
								<form name="searchForm" class="d-flex justify-content-center mt-5" action="${pageContext.request.contextPath}/mealCmnt/list" method="post">
									<div class="d-flex mt-3 w-50">
										<select name="schCategory" class="form-select rounded drop-down w-25 me-2 ">
											<option value="subcon" ${schType=="subcon"?"selected":""}>제목+내용</option>
											<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
											<option value="content" ${schType=="content"?"selected":""}>내용</option>
											<option value="mem_Nick" ${schType=="mem_Nick"?"selected":""}>작성자</option>
										</select>
											 
										<div class="input-group w-75 d-flex">
											<input type="text" name="schContent" value="${schContent}" class="form-control " placeholder="검색"> 
											<button type="button" id="search-icon-1" class="input-group-text" onclick="searchList()">
												<i class="fa fa-search"></i>
											</button>
										</div>
									</div>
								</form>
								
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
	
	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

	
	
	 <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
        <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
    </footer>
    
    <script type="text/javascript">
    function searchList() {
    	const form = document.searchForm;

    	form.submit();
    }
    
    $(function() {
    	$(".mealSort").change(function() {
    		const form = document.sortForm;
    		form.submit();
    	});
    });
    
    </script>
	
</body>

</html>