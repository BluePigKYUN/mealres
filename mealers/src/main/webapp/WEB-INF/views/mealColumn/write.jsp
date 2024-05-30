<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
    	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
    </head>
    <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>

    <body>
    <div class="container-fluid py-3">
            <div class="container py-5">
            </div>
     </div>
         <div class="container">
		<div class="body-container">
			<h2 class="text-primary py-3">글등록하기</h2>	
			<div class="body-main">
				<form name="lectureForm" method="post"	enctype="multipart/form-data">
					<table class="table write-form">
						<tr>
							<td class="bg-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="bg-light col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.userName}</p>
							</td>
						</tr>
	
						<tr>
							<td class="bg-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control" style="width: 95%; height: 270px;">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td> 
								<input type="file" name="selectFile" class="form-control">
							</td>
						</tr>
						<c:if test="${mode=='update'}">
							<tr>
								<td class="bg-light col-sm-2" scope="row">첨부된파일</td>
								<td> 
									<p class="form-control-plaintext">
										<c:if test="${not empty dto.saveFilename}">
											<a href="javascript:deleteFile('${dto.num}');"><i class="bi bi-trash"></i></a>
											${dto.originalFilename}
										</c:if>
										&nbsp;
									</p>
								</td>
							</tr>
						</c:if>
						
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="submitContents(this.form);">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/lecture/list?category=${category}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<input type="hidden" name="category" value="${category}">
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="fileSize" value="${dto.fileSize}">
									<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
									<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
								</c:if>
							</td>
						</tr>
					</table>
				</form>
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