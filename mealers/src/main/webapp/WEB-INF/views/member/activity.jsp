<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>

<style type="text/css">
.h4 {
	font-size: 1.5rem;
	font-weight: bold;
}

.hidden {
	display: none;
}

.button-container {
	margin-top: 20px;
}

.button-container button {
	margin-right: 10px;
}

.bg-danger {
	background-color: #F88264 !important;
}

.btn-danger {
	color: #1b1919;
	background-color: #756d6e91;
	border-color: #7c5559;
}

.btn-danger:hover {
	color: #3a3a3a;
	background-color: #baaeaf;
	border-color: #080808;
}
</style>

</head>
<body>
	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-md-10">
				<div class="bg-light rounded p-5">
					<div class="row mb-4">
						<div class="col-lg-4 text-start">
							<h1 class="mb-0">내 활동</h1>
						</div>
						<div class="col-lg-8 text-end">
							<ul class="nav nav-pills d-inline-flex text-center mb-5">
								<li class="nav-item"><span
									class="nav-link active bg-primary text-white rounded-pill"
									data-bs-toggle="pill">
										<a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=1"> 
												게시물
										</a> <!-- ${pageContext.request.contextPath}/member/activity?mode=tab1 -->
									</span>
								</li>
								<li class="nav-item"><span
									class="nav-link bg-success text-white rounded-pill"
									data-bs-toggle="pill">
										<a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=2">
												댓글
										</a> <!-- ${pageContext.request.contextPath}/member/activity?mode=tab2 -->
								</span></li>
								<li class="nav-item"><span
									class="nav-link bg-danger text-white rounded-pill"
									data-bs-toggle="pill" >
									
									<a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=3"> 
											좋아요
									</a>
								</span></li>

							</ul>
						</div>
					</div>
					<div class="tab-content">
					
						
						<div id="tab-1" class="tab-pane fade show p-0 active">
							${mode == '1' ? 'active' : ''}
							<!-- 탭 1 나의 게시물 -->
							<c:if test="${mode == '1'}">
							<table class="table table-hover mob_table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">게시판</th>
										<th scope="col">제목</th>
										<th scope="col">작성일</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr>
											<td>${dataCount - (pageNo-1) * size - status.index}</td>
											<td>${dto.type}</td>
											<td class="left">
												<a href="${articleUrl}&num=${dto.num}" class="text-reset">${dto.subject}</a>
											</td>
											<td>${dto.content}</td>
											<td>${dto.reg_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</c:if>
							<!-- //탭 1 -->
							
							<!-- 탭 2 댓글 -->
							<c:if test="${mode == '2'}">
							<table class="table table-hover mob_table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">게시판</th>
										<th scope="col">내용</th>
										<th scope="col">작성일</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<!-- 댓글 -->
								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr>
											<td>${totalCount - (page-1) * size - status.index}</td>
											<td>${dto.num}</td>
											<td class="left"><a href="${articleUrl}&num=${dto.num}"
												class="text-reset">${dto.content}</a></td>
											<td>${dto.content}</td>
											<td>${dto.reg_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</c:if>
							<!-- //탭 2 -->
							
							<!-- 탭 3 -->
							<c:if test="${mode == '3'}">
							<table class="table table-hover mob_table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">게시판</th>
										<th scope="col">작성일</th>
										<th scope="col">상태</th>
									</tr>
								</thead>

								<tbody>
									<%-- <c:forEach var="dto" items="${list}" varStatus="status">
										<tr>
											<td>${totalCount - (page-1) * size - status.index}</td>
											<td class="left"><a href="${articleUrl}&num=${dto.num}"
												class="text-reset">${dto.subject}</a></td>
											<td>${dto.subject}</td>
											<td>${dto.reg_date}</td>
										</tr>
									</c:forEach> --%>
								</tbody>
							</c:if>
							<!-- //탭 3 -->
							
							
							<!--페이징처리-->
							<nav aria-label="Page navigation example">
								<ul class="pagination d-flex justify-content-center pt-4">
									<li class="page-item m_prev"><a class="page-link"
										href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${startPage}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
									<c:forEach var="i" begin="${startPage}" end="${endPage}">
										<li class="page-item ${i == pageNo ? 'active' : ''}"><a
											class="page-link"
											href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${i}">${i}</a>
										</li>
									</c:forEach>
									<li
										class="page-item m_next ${pageNo == total_page ? 'disabled' : ''}">
										<a class="page-link"
										href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${pageNo + 1}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a>
									</li>
								</ul>
							</nav>
							<!--//페이징처리 -->

						</div>
						

						<!-- 탭 2 댓글 -->
						<%-- <div id="tab-2" class="tab-pane fade show p-0">
							<table class="table table-hover mob_table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">게시판</th>
										<th scope="col">내용</th>
										<th scope="col">작성일</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<!-- 댓글 -->
								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr>
											<td>${totalCount - (page-1) * size - status.index}</td>
											<td>${dto.num}</td>
											<td class="left"><a href="${articleUrl}&num=${dto.num}"
												class="text-reset">${dto.content}</a></td>
											<td>${dto.content}</td>
											<td>${dto.reg_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- //댓글 -->
							<nav aria-label="Page navigation">
								<ul class="pagination d-flex justify-content-center pt-4">
									<li class="page-item m_prev"><a class="page-link" href="#"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
									<li class="page-item"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item m_next"><a class="page-link" href="#"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</ul>
							</nav>
						</div>
						<!-- //탭 2 -->

						<!-- 탭 3 -->
						<div id="tab-3" class="tab-pane fade show p-0">

							<table class="table table-hover mob_table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">게시판</th>
										<th scope="col">작성일</th>
										<th scope="col">상태</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr>
											<td>${totalCount - (page-1) * size - status.index}</td>
											<td class="left"><a href="${articleUrl}&num=${dto.num}"
												class="text-reset">${dto.subject}</a></td>
											<td>${dto.subject}</td>
											<td>${dto.reg_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<nav aria-label="Page navigation">
								<ul class="pagination d-flex justify-content-center pt-4">
									<li class="page-item m_prev"><a class="page-link" href="#"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
									<li class="page-item"><a class="page-link" href="#">1</a></li>
									<li class="page-item m_next"><a class="page-link" href="#"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</ul>
							</nav>
						</div> --%>
						<!-- //탭 3 -->
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- //내 활동 -->

	<!-- 내 활동 -->
	<!-- <div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-4 text-start">
					<h1 class="mb-0">내 그룹</h1>
				</div>
				<table class="table table-hover mob_table">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>행복이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-secondary">대기</span></td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>불행이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-success">활동중</span></td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td><a href="#">제목입니다. 제목입니다.</a></td>
							<td>슬픔이</td>
							<td>2099-99-99</td>
							<td><span class="badge text-bg-success">활동중</span></td>
						</tr>
					</tbody>
				</table>

				<nav aria-label="Page navigation example">
					<ul class="pagination d-flex justify-content-center pt-4">
						<li class="page-item m_prev"><a class="page-link" href="#"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item m_next"><a class="page-link" href="#"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div> -->
	<!-- //내 활동 -->


	<!-- Footer Start -->
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
	</footer>
	<!-- Footer End -->
	<script>
		/* 	document.getElementById('change-password-btn').addEventListener(
					'click',
					function() {
						document.getElementById('new-password-container').classList
								.toggle('hidden');
					});
		 */
		/* function cancel() {
			// 취소 버튼 클릭 시 동작
			alert('취소되었습니다.');
		}

		function deleteAccount() {
			// 회원 탈퇴 버튼 클릭 시 동작
			if (confirm('정말로 회원 탈퇴하시겠습니까?')) {
				alert('회원 탈퇴가 완료되었습니다.');
			}
		} */
	</script>
</body>
</html>