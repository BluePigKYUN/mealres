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
		.must::before {
			margin: 10px 5px 0px 0px;
			content: "*";
			color: red;
		}
		
		label {color: black;}
	</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	
	<!-- 음식 사진 배너 -->
	<div class="container-fluid page-header py-5">
	    <h1 class="text-center text-white display-6">식품 영양정보 등록</h1>
	</div>
	
	<div class="container-fluid py-5 mb-5">
		<div class="container">
       		<div class="row">
       		
       			<div class="col-lg-6 col-md-10 mx-auto">
       				<div class="fs-3 mb-2">원하는 식품의 영양정보를 등록할 수 있습니다!</div>
	       			<p class="must text-end fs-6"> : 필수입력</p>
	       			<hr>
					<form name="regForm" action="${pageContext.request.contextPath}/search/reg" method="post">
						<div class="row mb-3">
							<label for="inputEmail3" class="col-3 col-form-label must">식품명</label>
							<div class="col-sm-9">
								<input type="text" name="food_name" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">업체명</label>
							<div class="col-sm-9">
								<input type="text" name="maker" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">식품 총 중량(g)</label>
							<div class="col-sm-9">
								<input type="number" name="weight" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-4 col-form-label">영양성분함량단위(g)</label>
							<div class="col-sm-8">
								<input type="number" name="serving_size" class="form-control">
								<p style="font-size: 14px;">예) 100g 당 30kcal → 100 입력</p>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label must">칼로리(kcal)</label>
							<div class="col-sm-9">
								<input type="number" name="kcal" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label must">탄수화물(g)</label>
							<div class="col-sm-9">
								<input type="number" name="tansoo" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label must">단백질(g)</label>
							<div class="col-sm-9">
								<input type="number" name="protein" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label must">지방(g)</label>
							<div class="col-sm-9">
								<input type="number" name="fat" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">당류(g)</label>
							<div class="col-sm-9">
								<input type="number" name="sugar" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">나트륨(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="salt" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">칼슘(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="calcium" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">칼륨(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="potassium" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">콜레스테롤(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="chole" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">포화지방산(g)</label>
							<div class="col-sm-9">
								<input type="number" name="pohwa" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">불포화지방(g)</label>
							<div class="col-sm-9">
								<input type="number" name="bulpohwa" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">오메가3(g)</label>
							<div class="col-sm-9">
								<input type="number" name="omega3" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">카페인(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="caffeine" class="form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-3 col-form-label">아미노산(mg)</label>
							<div class="col-sm-9">
								<input type="number" name="amino" class="form-control">
							</div>
						</div>
						<input type="submit" class="btn btn-primary float-md-end float-sm-end" style="color: white" value="등록하기">
					</form>
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