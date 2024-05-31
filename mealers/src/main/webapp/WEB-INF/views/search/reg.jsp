<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
	
	<style type="text/css">
		.must::before {
			margin: 10px 5px 0px 0px;
			content: "*";
			color: red;
		}
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
       		
       			<div class="w-50 mx-auto">
       				<div class="fs-3 mb-2">원하는 식품의 영양정보를 등록할 수 있습니다!</div>
	       			<p class="must text-end fs-6"> : 필수입력</p>
	       			<hr>
					<form>
						<div class="row mb-3">
							<label for="inputEmail3" class="col-sm-2 col-form-label must">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="inputPassword3">
							</div>
						</div>
						<button type="submit" class="btn btn-primary float-md-end" style="color: white">등록하기</button>
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