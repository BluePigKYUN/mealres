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
.tblack {color: black;}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

	<!-- 음식 사진 배너 -->
	<div class="container-fluid page-header py-5">
	    <h1 class="text-center text-white display-6">식품영양성분</h1>
	</div>
	
	<div class="container-fluid mt-5">
		<div class="container">
			<div class="row mb-5">
	                    <div class="col-lg-8">
	                        <h1 class="fw-bold mb-3">신라면</h1>
	                        <h5 class="mb-3">제조사: 농심</h5>
	                        <hr>
	                        <div class="row p-3 my-3 mx-1" style="background: #eee;">
	                        	<h5>총 영양 요약</h5>
	                        	<div class="col-3" style="border: 2px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">칼로리</div>
	                        		<div class="text-center">990</div>
	                        	</div>
	                        	<div class="col-3" style="border: 2px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">칼로리</div>
	                        		<div class="text-center">990</div>
	                        	</div>
	                        	<div class="col-3" style="border: 2px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">칼로리</div>
	                        		<div class="text-center">990</div>
	                        	</div>
	                        	<div class="col-3" style="border: 2px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">칼로리</div>
	                        		<div class="text-center">990</div>
	                        	</div>
	                        </div>
	                        <div class="input-group quantity mb-5" style="width: 100px;">
	                            <div class="input-group-btn">
	                                <button class="btn btn-sm btn-minus rounded-circle bg-light border" >
	                                    <i class="fa fa-minus"></i>
	                                </button>
	                            </div>
	                            <input type="text" class="form-control form-control-sm text-center border-0" value="1">
	                            <div class="input-group-btn">
	                                <button class="btn btn-sm btn-plus rounded-circle bg-light border">
	                                    <i class="fa fa-plus"></i>
	                                </button>
	                            </div>
	                        </div>
	                        <a href="#" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
	                    </div>
	                    
	                    <div class="col-lg-4">
	                        <div class="position-relative mx-auto">
	                            <input class="form-control border-2 border-secondary py-3 px-4 rounded-pill" type="text" placeholder="음식 이름 검색">
	                            <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 0%;">검색하기</button>
	                        </div>
	                        <div  class="p-3 my-4" style="border: solid 5px #eee;">
	                        	<h4>영양 정보</h4>
	                        	<hr class="mt-3">
	                        	<span class="tblack">총 중량</span>
	                        	<span class="float-end tblack fw-bold"> 707g</span>
	                        	<br>
	                        	<span class="tblack">1회 제공량</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr style="height: 10px;">
	                        	<span class="float-end tblack">1회 제공량 당</span>
	                        	<br>
	                        	<hr class="mt-2" style="height: 4px; background-color: black;">
	                        	<span class="tblack">칼로리</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">탄수화물</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">당류</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">지방</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">포화지방</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">불포화지방</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">나트륨</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">콜레스테롤</span>
	                        	<span class="float-end tblack fw-bold"> 77g</span>
	                        	<hr class="mt-2" style="height: 4px; background-color: black;">
	                        	
	                        	
	                        	
	                        	<div class="mt-3"></div>
	                        </div>
	                    </div>
			</div>
		</div>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>