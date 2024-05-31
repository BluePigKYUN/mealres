<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
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
                        <div class="position-relative mx-auto">
                            <input class="form-control border-2 border-secondary py-3 px-4 rounded-pill" type="text" placeholder="음식 이름 검색">
                            <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 2%;">검색하기</button>
                        </div>
					</div>
					<ul class="list-group my-4">
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="#" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
							<span class="badge bg-primary rounded-pill ">유저등록</span>
						</li>
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="#" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
						</li>
					</ul>
					
					<div class="mx-auto mb-4">
						원하는 결과가 없다면? 
						<a href="${pageContext.request.contextPath}/search/reg">눌러서 식품 영양정보 등록하러 가기</a>					
					</div>
					<div class="mx-auto mb-4">
						검색결과가 없습니다...
						<a href="${pageContext.request.contextPath}/search/reg">눌러서 식품 영양정보 등록하러 가기</a>					
					</div>

           		</div>
           		
           		<div class="col-md-4">
                	<h3 class="mb-3">이번주 인기 식품</h3>
					<ul class="list-group list-group-numbered mt-4">
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="#" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
							<span class="badge bg-primary rounded-pill ">유저등록</span>
						</li>
						
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="#" class="" style="color: black">
								  	월드콘 (농심, 388kcal)
								  </a>
							</div>
						</li>
						
						<li class="list-group-item list-group-item-action d-flex gap-2">
							<div class="me-auto ">
								  <a href="#" class="" style="color: black">
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