<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mealers</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

	<!-- 음식 사진 배너 -->
	<div class="container-fluid page-header py-5">
	    <h1 class="text-center text-white display-6">영양성분 검색</h1>
	</div>
	
	<div class="container-fluid py-5 mb-5">
		<div class="container">
       		<div class="row">
           		<div class="col-md-8">
					<div class="row g-5 align-items-center">
                        <form class="position-relative mx-auto" name="searchForm" action="${pageContext.request.contextPath}/search/main" method="post">
                            <input name="kwd" value="${kwd}" class="form-control border-2 border-secondary py-3 px-4 rounded-pill" type="text" placeholder="음식 이름 검색">
                            <button type="button" onclick="searchList()" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 2%;">검색하기</button>
                        </form>
					</div>
					<div class="row">
						<div class="col-6">
							<h4 class="ms-3 pt-3"> 밀러 등록 </h4>
							<ul class="list-group my-3">
								<c:forEach var="dto" items="${list}">
									<c:if test="${dto.userNum == 0}">
										<li class="list-group-item list-group-item-action d-flex gap-2">
											<div class="me-auto ">
												  <a href="${articleUrl}&num=${dto.food_num}" class="" style="color: black">
												  	${dto.food_name} (${dto.maker}, ${dto.kcal}kcal)
												  </a>
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						
						<div class=" col-6">
							<h4 class="ms-3 pt-3"> 유저 등록 </h4>
							<ul class="list-group my-3">
								<c:forEach var="dto" items="${list}">
									<c:if test="${dto.userNum != 0}">
										<li class="list-group-item list-group-item-action d-flex gap-2">
											<div class="me-auto ">
												  <a href="${articleUrl}&num=${dto.food_num}" class="" style="color: black">
												  	${dto.food_name} (${dto.maker}, ${dto.kcal}kcal)
												  </a>
											</div>
											<span class="badge bg-primary rounded-pill ">유저등록</span>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
					
					<div class="my-3">
						검색결과가 없습니다...&nbsp;
						<a href="${pageContext.request.contextPath}/search/reg">눌러서 영양정보 등록하기</a>
					</div>
					
					<div class="my-3">
						원하는 식품이 없다면 ? &nbsp;
						<a href="${pageContext.request.contextPath}/search/reg">눌러서 영양정보 등록하기</a>
					</div>
					


           		</div>
           		
           		<div class="col-md-4">
                	<h3 class="mb-3">이번주 인기 식품</h3>
					<ul class="list-group list-group-numbered mt-4">
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="${pageContext.request.contextPath}/search/item" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
							<span class="badge bg-primary rounded-pill ">유저등록</span>
						</li>
						
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="${pageContext.request.contextPath}/search/item" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
						</li>
						
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="${pageContext.request.contextPath}/search/item" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
						</li>
						
					</ul>
            	</div>
           	</div>
        </div>
    </div>
           
	
	
	
	

</body>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</footer>
</html>