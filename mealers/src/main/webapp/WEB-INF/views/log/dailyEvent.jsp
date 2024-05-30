<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일정관리</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-fluid py-5 mt-5">
	<div class="container py-5 my-5">
        <div class="row">
            <div class="col-md-8">
                <h2>일정관리</h2>
                <div class="calendar bg-white p-4 rounded shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <!-- arrow 누르면 다음달 이전달로 가게 구현해야함 -->
                        <span class="arrow">&lt;</span>
                        <span class="date">2024-05-30</span>
                        <span class="arrow">&gt;</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>S</span>
                        <span>M</span>
                        <span>T</span>
                        <span>W</span>
                        <span>T</span>
                        <span>F</span>
                        <span>S</span>
                    </div>
                    <div class="days d-flex justify-content-between">
                        <!-- 나머지 달력은 여기다가 코드 c:forEach 돌려야함 -->
                    </div>
                </div>
                <button id="addEventBtn" class="btn btn-success mt-4">일정등록</button>
            </div>
            <div class="col-md-4">
                <h3>오늘일정</h3>
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        새벽
                        <span class="badge bg-primary rounded-pill">5:00-6:00</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        아침
                        <span class="badge bg-primary rounded-pill">8:00-9:00</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        점심
                        <span class="badge bg-primary rounded-pill">12:00-13:00</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        물품구매
                        <span class="badge bg-primary rounded-pill">15:00-16:00</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        퇴근시간
                        <span class="badge bg-primary rounded-pill">17:00-18:00</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
   </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>


<footer>
   	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>

<script type="text/javascript">
document.getElementById('addEventBtn').addEventListener('click', function() {
    window.open('${pageContext.request.contextPath}/log/popup.jsp', '일정추가', 'width=500,height=400');
});
</script>

</body>
</html>