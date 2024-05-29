<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- 오렌지 바가 넣을거면 밑 div 지우시오 -->
<div class="container-fluid py-5 my-5">

</div>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>