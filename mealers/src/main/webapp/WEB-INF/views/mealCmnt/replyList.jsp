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
			<div class="col-lg-12 topContent mx-2">
				<h6>${replyCount}개 (${pageNo}/${total_page}페이지) </h6>
			</div>
		</c:if>
			
		<c:forEach var="dto" items="${replyList}">		
			<div class="replyContent">
				<div class="d-flex justify-content-between fw-bold pt-3 pb-2">
					<c:choose>
						<c:when test="${dto.userNum == '1'}">
							<p class="ms-3">${dto.mem_Nick} 👑</p>
						</c:when>
						<c:otherwise>
							<p class="ms-3">${dto.mem_Nick}</p>							
						</c:otherwise>
					</c:choose>
					
					<div class="d-flex">
						<p class="me-2">${dto.reg_date}</p>
						<c:choose>
							<c:when test="${dto.userNum == sessionScope.member.userNum || sessionScope.member.userId == 'admin'}">
								<a class="mx-2 replyDelBtn text-danger" data-replyNum="${dto.replyNum}" data-pageNo="${pageNo}">삭제</a>
							</c:when>
							<c:otherwise>
								<a class="mx-2 text-black-50">삭제</a>
							</c:otherwise>
						</c:choose>
						
					</div>
				</div>
				
				<div>
					<div class="mx-4 pb-4">${dto.content}</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="page-navigation">
		${paging}
	</div>	
</body>
</html>