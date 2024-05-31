<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
    	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
    	
<style type="text/css">
    	
    .body-container {
    		max-width: 1000px;
    		margin: 0 auto;
    	}
    	
    .table-article img { max-width: 100%; }
  
</style>
    </head>
    
    <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>
    
<body>
 	
 	<div class="container-fluid page-header-mealColumn py-5">
            <h1 class="text-center text-white display-6">Mealers가 알려주는 건강 정보</h1>
     </div>
     
	<div class="container">
		<div class="container-fluid fruite py-5">	
			<div class="body-main">
			   <div class="table-responsive rounded">
					<table class="table table-article rounded border border-1">
					    <thead class="align-middle text-center bg-light">
					        <tr>
					            <td colspan="2" class="align-middle text-center rounded-top">
					                <h3 class="text-primary py-2 text-center">제목입니다.</h3>
					            </td>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td align="left" style="text-align: left;">
									이름 : 관리자
								</td>
								<td align="right">
									YYYY-MM-DD | 조회 ${dto.hitCount}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" valign="top" height="200" style="border-bottom: none;">
									${dto.content}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" class="text-center p-3" style="border-bottom: none;">
									<button type="button" class="btn btn-outline-secondary btnSendLectureLike" title="좋아요"><i class="far fa-hand-point-up" style="color: ${isUserLike?'blue':'black'}"></i>&nbsp;&nbsp;<span id="boardLikeCount">${dto.likeCount}</span></button>
								</td>
							</tr>
							
							<tr>
								<td colspan="2">
									<c:if test="${not empty dto.saveFilename}">
										<p class="border text-secondary mb-1 p-2">
											<i class="bi bi-folder2-open"></i>
											<a href="${pageContext.request.contextPath}/lecture/download?num=${dto.num}">${dto.originalFilename}</a>
											[${dto.fileSize} byte]
										</p>
									</c:if>
								</td>
							</tr>
	
							<tr>
								<td colspan="2">
									이전글 :
									<c:if test="${not empty prevDto}">
										<a href="${pageContext.request.contextPath}/lecture/article?${query}&num=${prevDto.num}">${prevDto.subject}</a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									다음글 :
									<c:if test="${not empty nextDto}">
										<a href="${pageContext.request.contextPath}/lecture/article?${query}&num=${nextDto.num}">${nextDto.subject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<c:choose>
								<c:when test="${sessionScope.member.userId==dto.userId}">
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/lecture/update?num=${dto.num}&category=${category}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled>수정</button>
								</c:otherwise>
							</c:choose>
					    	
							<c:choose>
					    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
					    			<button type="button" class="btn btn-light" onclick="deleteLecture();">삭제</button>
					    		</c:when>
					    		<c:otherwise>
					    			<button type="button" class="btn btn-light" disabled>삭제</button>
					    		</c:otherwise>
					    	</c:choose>
						</td>
						<td class="text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/lecture/list?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						<div class='form-header'>
							<span class="bold">질문/답변</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
						</div>
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<textarea class='form-control' name="content"></textarea>
								</td>
							</tr>
							<tr>
							   <td align='right'>
							        <button type='button' class='btn btn-light btnSendReply'>질문 등록</button>
							    </td>
							 </tr>
						</table>
					</form>
					
					<div id="listReply"></div>
				</div>
				
			</div>
		</div>
	</div>
	
	
        <!-- Footer Start -->
        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        </footer>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
    </body>

</html>