<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<style>
.replyDelBtn:hover {
	cursor: pointer;
} 

.replyContent {
	border-bottom: 1px solid #BDBDBD;
}


</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<div class="replyBox mt-0" style="height: 70%">
		<c:if test="${! empty replyList}">
			<div class="col-lg-12 ms-1 me-1 topContent">
				<h6>${replyCount}개 (${pageNo}/${total_page}페이지) </h6>
			</div>
		</c:if>
			
		<c:forEach var="dto" items="${replyList}">		
			<div class="replyContent mx-1 ">
				
				<span class="py-2 ps-3 text-white bg-secondary adoptLine" style="display: none">채택된 댓글</span>
				
				<div class="d-flex justify-content-between fw-bold pb-2 topReply">
					<c:choose>
						<c:when test="${dto.userNum == '1'}">
							<p class="ms-3 pt-3">${dto.mem_Nick} 👑</p>
						</c:when>
						<c:otherwise>
							<p class="ms-3 pt-3">${dto.mem_Nick}</p>							
						</c:otherwise>
					</c:choose>

					<div class="d-flex pt-3 mx-2">
						<p>${dto.reg_date}</p>
						<c:choose>
							<c:when test="${dto.userNum == sessionScope.member.userNum || sessionScope.member.userId == 'admin'}">
								<a class="replyDelBtn text-danger ms-2" data-replyNum="${dto.replyNum}" data-pageNo="${pageNo}">삭제</a>
							</c:when>
							<c:otherwise>
								<a class="text-black-50 ms-2">삭제</a>
							</c:otherwise>
						</c:choose>
						<div>
							<c:if test="${dto.conUserNum == sessionScope.member.userNum}">
								<button type="button" class="border border-primary rounded ms-3 text-primary fw-bold adoptBtn" data-replyNum="${dto.replyNum}" data-pageNo="${pageNo}">
								채택
								</button>
							</c:if>
						</div>
					</div>
				</div>
				
				<div>
					<div class="mx-4 pb-4">${dto.content}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>