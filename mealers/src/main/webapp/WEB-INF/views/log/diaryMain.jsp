<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일기</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-fluid py-5">
	<div class="container py-5 my-5">
       
		<div class="row">
			<div class="col-lg-8">
				<h2 class="mb-4">작은 서랍장(일기)</h2>
				<div class="list-group">
					<div class="list-group-item d-flex align-items-start">
						<div class="me-3">
							<i class="bi bi-calendar3"></i>
						</div>
						<div>
							<span class="fw-bold d-block">날짜를 출력할 부분</span>
							<p class="mb-0 d-block">일기 제목을 출력할 부분</p>
						</div>
                        <button type="button" class="btn ms-auto">일기 보기</button>
                    </div>
                </div>
				<div class="page-navigation">
					페이지네이션 해야할 곳
					${dataCount==0 ? "등록된 게시글이 없습니다." : paging}
				</div>
           	</div>
	        <div class="col-lg-4">
	            <div class="mb-4">
	                <h3>오늘 일기 미리보기<br>(제목과 날짜만 표시)</h3>
	                <div class="d-flex align-items-center bg-light p-3 rounded">
	                    <button class="btn btn-primary me-3">버튼</button>
	                    <div>
	                        <div class="d-flex align-items-center">
	                            <i class="bi bi-calendar3 me-2"></i>
	                            <span class="fw-bold">2024-05-29</span>
	                        </div>
	                        <p class="mb-0">프로젝트 언제 끝날까요?</p>
	                    </div>
	                </div>
	            </div>
	            <div class="mb-4">
	                <h3>선택한 감정들</h3>
	                <ul class="list-group">
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-smile me-2"></i> 80% 기쁨
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-laughing me-2"></i> 10% 신남
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-frown me-2"></i> 5% 슬픔
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-angry me-2"></i> 3% 분노
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-neutral me-2"></i> 2% 그냥그럼
	                    </li>
	                </ul>
	            </div>
	            <div>
	                <h3>일주일 전 일기</h3>
	                <ul class="list-group">
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">날짜를 출력할 부분</span>
	                            <p class="mb-0">제목을 출력할 부분</p>
	                        </div>
	                    </li>
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">2024-05-29</span>
	                            <p class="mb-0">최근일기만 출력</p>
	                        </div>
	                    </li>
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">2024-05-29</span>
	                            <p class="mb-0">최대 3개 까지만</p>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<footer>
   	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>