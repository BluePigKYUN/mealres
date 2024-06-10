<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일기</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<!-- JangCustom css -->
<link href="/mealers/resources/css/toggleButton.css" rel="stylesheet">
</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

        <!-- Checkout Page Start -->
        <div class="container-fluid py-2 my-3">
            <div class="container my-5">
                    <div class="row g-5">
                        <div class="col-md-12 col-lg-6 col-xl-7">
                        	<h3>기록에 대해...</h3>
                        	<p>오늘의 하루는 어떠셨나요? 밀러즈와 함께 하루를 간직해보는건 어떨까요?</p>
                            <div>
								<table>
									<tr>
										<h5>&nbsp;&nbsp;&nbsp;일기 쓰기</h5>
										<td rowspan = "2">
										<a href = "${pageContext.request.contextPath}/log/diary">
											<img class="mScale" src="/mealers/resources/img/diary_logo.png"></img>
										</a>
										</td>
									</tr>
									<tr>
										<td>
											<h6>일기를 작성할 수 있어요.</h6>
											<p>매일 매일을 작성해보세요.</p>
										</td>
									</tr>
								</table>
                            </div>
                            <div>
                            	<table>
									<tr>
										<td rowspan = "2">
										<h5>&nbsp;&nbsp;&nbsp;일정 기록</h5>
										<a href = "${pageContext.request.contextPath}/log/event">
											<img class="mScale" src="/mealers/resources/img/event_logo.png"></img>
										</a>
										</td>
									</tr>
									<tr>
										<td>
											<h6>일정을 관리해보세요</h6>
											<p>달력을 통해 당신의 일정을 관리할 수 있어요.</p>
										</td>
									</tr>
								</table>
                        	</div>
                     	</div>
            <div class="fixed-button">
                <button class="btn btn-primary" onclick="toggle()">바로가기</button>
                <div id="right-buttons" class="hidden">
                    <a href = "${pageContext.request.contextPath}/log/diary"> 
                    <button class="btn btn-secondary">일기</button></a>
                    <a href = "${pageContext.request.contextPath}/log/event"> 
                    <button class="btn btn-secondary">일정</button></a>
                </div>
            </div>
            	</div>
        </div>
     </div>
        <!-- Checkout Page End -->
        
    <script type="text/javascript">
        function toggle() {
            var buttons = document.querySelector("#right-buttons");
            if (buttons.classList.contains("hidden")) {
                buttons.classList.remove("hidden");
            } else {
                buttons.classList.add("hidden");
            }
        }
    </script>
    
		<footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
        </footer>

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
   </html>