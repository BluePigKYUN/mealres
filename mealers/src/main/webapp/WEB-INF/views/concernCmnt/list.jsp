<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<script
	src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>

<style type="text/css">
.ratio-4x3 {
	position: relative;
	width: 100%;
	height: 0;
	padding-top: 75%;
}

.ratio-4x3 img {
	position: absolute;
	width: 100%;
	height: 100%;
	object-fit: cover;
	max-width: 100%;
	max-height: 100%;
}

.input-group-text:hover, .content-box:hover {
	cursor: pointer;
}

.content-control {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.subject-control {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}

.concern-item:hover {
	box-shadow: 0 0 55px rgba(0, 0, 0, 0.4);
}

.concern-item {
	transition: 0.5s;
}

.sortbox {
	border: 1px solid #BDBDBD;
}

.contentList {
	margin: 0 auto;
}

.menu {
	background: #BDBDBD;
	align-items: center;
}

.menu p {
	display: flex;
	color: white
}

.contents {
	border-bottom: 1px solid #BDBDBD;
}
</style>

</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container-fluid page-header-cmnt py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>

	<div class="container-fluid fruite">
		<div class="container py-5">
			<div class="row g-4">
				<div class="col-lg-12">
					<div class="row g-4">
						<div class="d-flex justify-content-between">
							<div>
								<h2>고민상담 커뮤니티</h2>
							</div>
							<form name="sortForm"
								action="${pageContext.request.contextPath}/concernCmnt/list"
								method="post">
								<div class="ps-3 py-3 rounded mb-4 sortbox">
									<label for="concernSort">정렬</label> <select name="concernSort"
										id="concernSort"
										class="border-0 form-select-md mx-3 concernSort">
										<option value="recent"
											${concernSort=="recent" ? "selected" : ""}>최신순</option>
										<option value="hitcount"
											${concernSort=="hitcount" ? "selected" : ""}>조회순</option>
										<option value="popular"
											${concernSort=="popular" ? "selected" : ""}>인기순</option>
									</select> <input type="hidden" name="concernSort" value="${concernSort}">
									<input type="hidden" name="schCategory" value="${schCategory}">
									<input type="hidden" name="schContent" value="${schContent}">
								</div>
							</form>
						</div>
						<div class="mb-3 ms-5">${dataCount}개(${page}/${total_page}페이지)</div>
					</div>

					<div class="col-12 mb-5 contentList" style="width: 90%">
						<div class="d-flex ps-4 pt-3 menu" style="height: 40px">
							<p class="col-1">번호</p>
							<p class="col-6">제목</p>
							<p class="col-2">작성자</p>
							<p class="col-2">작성일</p>
							<p class="col-1">조회수</p>
						</div>

						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="d-flex ps-4 py-3 contents">
								<div class="col-1">${dataCount-(page-1)*size-status.index}</div>
								<div class="col-6">
									<span><a href="${articleUrl}&num=${dto.num}"
										class="text-reset">${dto.subject}</a></span>
								</div>
								<div class="col-2">${dto.mem_Nick}</div>
								<div class="col-2">${dto.reg_date}</div>
								<div class="col-1">${dto.hitCount}</div>
							</div>
						</c:forEach>
						<div class="mt-4" style="text-align: right">
							<button type="button"
								class="text-white bg-secondary px-3 pt-1 rounded border-secondary"
								onclick="location.href='${pageContext.request.contextPath}/concernCmnt/write';">글쓰기</button>
						</div>

						<form name="searchForm" class="d-flex justify-content-center mt-5 mb-3" action="${pageContext.request.contextPath}/concernCmnt/list" method="post">
							<div class="d-flex mt-3 w-50">
								<select name="schCategory"
									class="form-select rounded drop-down w-25 me-2">
									<option value="subcon" ${schCategory=="subcon"?"selected":""}>제목+내용</option>
									<option value="subject" ${schCategory=="subject"?"selected":""}>제목</option>
									<option value="content" ${schCategory=="content"?"selected":""}>내용</option>
									<option value="mem_Nick"
										${schCategory=="mem_Nick"?"selected":""}>작성자</option>
								</select>

								<div class="input-group w-75 d-flex">
									<input type="text" name="schContent" value="${schContent}"
										class="form-control rounded " placeholder="검색">
									<div class="col-auto p-1">
										<input type="hidden" name="concernSort" value="${concernSort}">
										<button type="button" id="search-icon-1"
											class="input-group-text" onclick="searchList()">
											<i class="fa fa-search search-icon"></i>
										</button>
									</div>

								</div>
							</div>
						</form>
					</div>

					<nav aria-label="Page navigation example">
						<c:if test="${dataCount > 0}">${paging}</c:if>
					</nav>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	</div>

	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
		class="fa fa-arrow-up"></i></a>



	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
	</footer>

	<script type="text/javascript">
		function searchList() {
			const form = document.searchForm;

			form.submit();
		}

		$(function() {
			$(".concernSort").change(function() {
				const form = document.sortForm;
				form.submit();
			});
		});
	</script>

</body>

</html>