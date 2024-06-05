<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mealers</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<script type="text/javascript">
function sendOk() {
	const f = document.regForm
	
	f.action = "${pageContext.request.contextPath}/search/item";
	f.method = "POST";
	f.submit();	
}
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	
	<!-- 음식 사진 배너 -->
	<div class="container-fluid page-header py-5">
	    <h1 class="text-center text-white display-6">영양성분 등록</h1>
	</div>
	
	<div class="container-fluid py-5 mb-5 position-relative">
		<h3 class="position-absolute top-50 start-50 translate-middle">등록에 성공했습니다!</h3>
		<div class="position-absolute top-100 start-50 translate-middle d-flex">
			<a href="${pageContext.request.contextPath}/search/main">검색페이지로 돌아가기</a>
			<h5>&nbsp;/&nbsp;</h5>
			<form name="regForm" enctype="multipart/form-data">
				<a href="#" onclick="sendOk();">등록한 음식 페이지로 가기</a>
				<input type="hidden" name="kwd" value="${kwd}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="num" value="${num}">
			</form>
		</div>
	</div>
	<div style="height: 85px;"></div>
	

</body>
<footer>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</footer>
</html>