<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">

.content {
   width: 75%;
   margin: 0 auto;
}

.content .border .w-50 {
	flex: 1;
	overflow: hidden;
}

.content .border img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.topContent {
	border-bottom: 1px solid black;
}


.replyContent {
	border-bottom: 1px solid #EAEAEA;
}

.replyContent:last-child {
	border-bottom: none;
}

.left-content, .right-content {
	flex: 1;
	display: flex;
	flex-direction: column;
}

</style>
</head>


<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>
	
	
	<div class="container-fluid ">
		<div class="container ">
			<div class="row g-4 content my-5 pb-3">
			
				<div class="col-md-6 d-flex" >
					<div class="border border-3 border-secondary rounded d-flex flex-column w-100 left-content" >
						<div class="imgbox flex-grow-1">
							<img src="${pageContext.request.contextPath}/uploads/mealCmnt/${dto.fileName}" class="img-fluid rounded object-fit-cover" style="max-height: 400px;">
						</div>
						
						<div class="contentbox flex-grow-1">
							<div class="d-flex flex-row justify-content-between pt-4 pb-3 px-3 ">
									<div class="text-white bg-secondary px-2 rounded w-25 py-1 text-center" >${dto.mem_Nick}</div>
								<div class="align-self-center">두시간전</div>
							</div>

							<h3 class="fw-bold ms-5 py-3 ps-1">${dto.subject}</h3>
							<div class="ms-5 w-75 pt-3 ps-1">${dto.content}</div>


							<div
								class="d-flex flex-row justify-content-between pb-3 px-4 mt-5 ">
								<div>댓글10 좋아요${dto.likeCount} 조회수${dto.hitCount}</div>
								<div>${dto.reg_date}</div>
								
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="col-md-6  border border-2 border-start-0 rounded-end pe-3 right-content" >
					<div class="replyBox" style="height: 70%" >
						<div class="col-lg-12 mt-4 topContent" >
							<h6>댓글 3개 </h6>
						</div>
							
						<div class="replyContent pb-3">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-2 ">
								<p>명수(닉네임)</p>
								<div class="d-flex">
									<p>2024-05-31 00:56</p>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적시셨네</div>
							</div>
						</div>

						<div class="replyContent pb-3">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적시셨네</div>
							</div>
						</div>
						
						<div class="replyContent pb-3">
							<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
								<div>명수(닉네임)</div>
								<div class="d-flex">
									<div>2024-05-31 00:56</div>
									<a class="mx-2">삭제</a>
								</div>
							</div>
							<div>
								<div>아버지나를낳으시고바지적삼다적시셨네</div>
							</div>
						</div>
					</div>
					
					<form action="#" class="replywrite mb-4" style="height: 30%">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="rounded">
									<textarea name="reply" class="form-control border" cols="30"
										rows="4" placeholder="댓글을 입력하세요 *"></textarea>
								</div>
							</div>
							<div class="col-lg-12 h-25 my-3">
								<div class="d-flex justify-content-between mt-1">
									<button type="button" class="btn text-white bg-primary text-primary rounded-pill" onclick="location.href='${pageContext.request.contextPath}/mealCmnt/list';">목록</button>
									<button type="button" class="btn border border-primary text-primary rounded-pill">등록</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	

	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
		<i class="fa fa-arrow-up"></i>
	</a>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
	</footer>
</body>

</html>