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

<style type="text/css">
#moreInfo:hover {text-decoration: underline;}
</style>

<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
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
           			<h5> 등록된 음식 데이터 : ${totalCount}</h5>
					<div class="row g-5 align-items-center">
                        <form class="position-relative mx-auto" name="searchForm" action="${pageContext.request.contextPath}/search/main" method="post">
                            <input name="kwd" value="${kwd}" class="form-control border-2 border-secondary py-3 px-4 rounded-pill" type="text" placeholder="음식 이름 검색">
                            <button type="button" onclick="searchList()" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 2%;">검색하기</button>
                        </form>
					</div>
					<div class="mx-3 pt-2"> 총 검색결과 ${dataCount}개</div>
					<div class="row">
						<div class="col-6">
							<h4 class="ms-3 pt-3"> 밀러 등록 </h4>
							<c:if test="${kwd.length() != 0}">
							</c:if>
							<ul id="mealerList" class="list-group my-3">
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
								<c:forEach var="dto" items="${listUser}">
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
					<form id="moreForm">
						<input type="hidden" id="pageCount" name="page" value="${page}">
						<input type="hidden" name="kwd" value="${kwd}">
					</form>
					<c:if test="${list.size() >= 10}">
						<a id="moreInfo" style="color: tomato; cursor: pointer;}">더보기</a>
					</c:if>
					
					<c:if test="${list.isEmpty()}">
						<div class="my-3">
							검색결과가 없습니다...&nbsp;
							<a href="${pageContext.request.contextPath}/search/reg">눌러서 영양정보 등록하기</a>
						</div>
					</c:if>
					
					<div class="my-3">
						원하는 식품이 없다면 ? &nbsp;
						<a href="${pageContext.request.contextPath}/search/reg">눌러서 영양정보 등록하기</a>
					</div>
					


           		</div>
           		
           		<div class="col-md-4">
                	<h3 class="mb-3">이번주 인기 식품</h3>
					<ul class="list-group list-group-numbered mt-4">
						<c:forEach var="dto" items="${listRank}">
							<c:choose>
								<c:when test="${dto.userNum == 0}">
									<li class="list-group-item list-group-item-action d-flex gap-2">
										<div class="me-auto ">
											  <a href="${articleUrl}&num=${dto.food_num}" class="" style="color: black">
											  	${dto.food_name} (${dto.maker}, ${dto.kcal}kcal)
											  </a>
										</div>
									</li>
								</c:when>
								<c:otherwise>
									<li class="list-group-item list-group-item-action d-flex gap-2">
										<div class="me-auto ">
											  <a href="${articleUrl}&num=${dto.food_num}" class="" style="color: black">
											  	${dto.food_name} (${dto.maker}, ${dto.kcal}kcal)
											  </a>
										</div>
										<span class="badge bg-primary rounded-pill ">유저등록</span>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
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
<script type="text/javascript">
	var $j = jQuery.noConflict();
	$j(document).ready(function() {
		
		
		$("#moreInfo").click(function() {
			let page = document.querySelector("#pageCount");
			page.value++;
			
			
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/search/mainAjax",
				data: $("#moreForm").serialize(),
				dataType: "json",
				success: function(data) {
					
					let content = "";
					
					if(data.list.length == 0) {
						alert("마지막입니다.");
						return;
					}
					
					for(let list of data.list) {
						
						content += "<li class=\"list-group-item list-group-item-action d-flex gap-2\">"
						content += "<div class=\"me-auto\">"
						content += "<a href=\"" + data.articleUrl + "&num=" + list.food_num +"\" style=\"color: black\">"
						content	+= list.food_name + "(" + list.maker + ", " + list.kcal + "kcal)"
						content += "</a>"
						content += "</div>"
						content += "</li>"
					}
					
					$("#mealerList li:last").after(content);
				},
				error: function(err) {
					console.log(err.responseText);
				}
			});
		});
	});
</script>
</html>















