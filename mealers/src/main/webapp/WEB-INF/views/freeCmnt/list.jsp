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
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.subject-control {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}

.free-item:hover {
	box-shadow: 0 0 55px rgba(0, 0, 0, 0.4);
	
}

.free-item {
    transition: 0.5s;
}

.sortbox {
	border: 1px solid #BDBDBD;
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

	<div class="container-fluid fruite">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<div class="d-flex justify-content-between">
							<div>
								<h2>자유 커뮤니티</h2>
							</div>	
							<form name="sortForm" action="${pageContext.request.contextPath}/freeCmnt/list" method="post">
								<div class="ps-3 py-3 rounded mb-4 sortbox">
									<label for="freeSort">정렬</label> 
									<select name="freeSort" id="freeSort" class="border-0 form-select-md mx-3 freeSort">
										<option value="recent" ${freeSort=="recent" ? "selected" : ""}>최신순</option>
										<option value="hitcount" ${freeSort=="hitcount" ? "selected" : ""}>조회순</option>
										<option value="popular" ${freeSort=="popular" ? "selected" : ""}>인기순</option>
									</select>
									<input type="hidden" name="freeSort" value="${freeSort}"> 
									<input type="hidden" name="schCategory" value="${schCategory}">
									<input type="hidden" name="schContent" value="${schContent}">
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
										<div class="d-flex justify-content-center">
											<div class="fw-bold align-content-center" style="height: 500px">게시물이 존재하지 않습니다.</div>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach var="dto" items="${list}" varStatus="status">
											<div class="col-md-4 col-lg-4 col-xl-3 pb-3 mb-3" style="max-height: 800px">
												<div class="rounded position-relative free-item content-box" onclick="location.href='${articleUrl}&num=${dto.num}';">
													<div class="fruite-img ratio ratio-4x3">
														<img src="${pageContext.request.contextPath}/uploads/freeCmnt/${dto.fileName}" class="img-fluid rounded-top">
													</div>
													
													<div>
														<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">${dto.mem_Nick}</div>
													</div>
													
													<div class="px-4 pt-2 pb-0 border border-secondary border-top-0 rounded-bottom">
														<div class="d-flex justify-content-between mt-2">
													
															<c:choose>
																<c:when test="${dto.timeGap/60 < 24.0}">
																	<c:choose>
																		<c:when test="${dto.timeGap == 0}">
																			<p class="py-1 text-secondary">지금</p>
																		</c:when>
																		<c:when test="${dto.timeGap < 60}">
																			<p class="py-1 text-secondary">${dto.timeGap}분전</p>
																		</c:when>
																		<c:otherwise>
																			<p class="py-1 text-secondary">${(dto.timeGap/60).toString().substring(0,(dto.timeGap/60).toString().indexOf('.'))}시간전</p>
																		</c:otherwise>
																	</c:choose>	
																</c:when>
																<c:otherwise>
																	<p>&nbsp;</p>
																</c:otherwise>
															</c:choose>
															
														</div>
														<h4 class="pt-1 mb-4 subject-control fw-bold ">${dto.subject}</h4>
														<div class="content-control mb-5" style="height: 50px">${dto.content}</div>
														<div class="d-flex justify-content-between mb-3" >
															<span ><i class="bi bi-eye"></i> ${dto.hitCount}</span>
															<p class="mb-0">${dto.reg_date}</p>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								
								</c:choose>
								

								<div style="text-align: right">
									<button type="button" class="text-white bg-secondary px-3 pt-1 rounded border-secondary" onclick="location.href='${pageContext.request.contextPath}/freeCmnt/write';">글쓰기</button>
								</div>
								
								<form name="searchForm" class="d-flex justify-content-center mt-5 mb-3" action="${pageContext.request.contextPath}/freeCmnt/list" method="post">
									<div class="d-flex mt-3 w-50">
										<select name="schCategory" class="form-select rounded drop-down w-25 me-2">
											<option value="subcon" ${schCategory=="subcon"?"selected":""}>제목+내용</option>
											<option value="subject" ${schCategory=="subject"?"selected":""}>제목</option>
											<option value="content" ${schCategory=="content"?"selected":""}>내용</option>
											<option value="mem_Nick" ${schCategory=="mem_Nick"?"selected":""}>작성자</option>
										</select>
											 
										<div class="input-group w-75 d-flex">
											<input type="text" name="schContent" value="${schContent}" class="form-control rounded " placeholder="검색"> 
											<div class="col-auto p-1">
												<input type="hidden" name="freeSort" value="${freeSort}"> 	
												<button type="button" id="search-icon-1" class="input-group-text" onclick="searchList()"> <i class="fa fa-search search-icon"></i> </button>
											</div>
											
										</div>
									</div>
								</form>

								<nav aria-label="Page navigation example">
									<c:if test="${dataCount > 0}">${paging}</c:if>
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
    	$(".freeSort").change(function() {
    		const form = document.sortForm;
    		form.submit();
    	});
    });
    
    </script>
	
</body>

</html>