<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>

<style type="text/css">
.viewer {
	cursor: pointer;
	width: 500px;
	height: 350px;
	background-image: url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	background-repeat: no-repeat;
	background-position: center;
	background-color: #ebebeb;
}

</style>

<script type="text/javascript">
$(function() {
	$(".viewer").click(function() {
		$("form[name=CmntForm] input[name=photoSelect]").trigger("click");
	});
	
	
});

</script>
    
</head>
<body>
    <!-- 헤더 영역 -->
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>
    
    <!-- Single Page Header start -->
	<div class="container-fluid page-header py-5 ">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>
	<!-- Single Page Header End -->

    <!-- 본문 영역 -->
    <div class="container-fluid my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card bg-gradient-primary border border-secondary shadow rounded-lg">
                    <div class="card-body">
                        <h3 class="card-title mb-4 py-3 ps-2"> 식단 커뮤니티 </h3>
                       
                        <form name="CmntForm" method="post" enctype="multipart/form-data">
                        	<div class="form-group mt-3 mb-4 d-flex justify-content-center">
                        		<div class="viewer rounded"></div>
                                <input type="file" name="photoSelect" accept="image/*" id="selectFile" class="form-control" style="display: none">
                            </div>
                            
                            <c:if test="${mode=='update'}">
                                <div class="form-group mb-3">
                                    <label class="form-label">첨부된 파일</label>
                                    <div class="form-control bg-light rounded-pill px-3 py-2">
                                        <c:if test="${not empty dto.saveFilename}">
                                            <a href="javascript:deleteFile('${dto.num}');" class="text-danger me-2"><i class="bi-trash"></i></a>
                                            ${dto.originalFilename}
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group mb-3 mx-5">
                                <label for="subject" class="form-label">제목</label>
                                <input type="text" name="subject" id="subject" class="form-control" value="${dto.subject}" required>
                            </div>
                            <div class="form-group mb-3 mx-5">
                                <label for="content" class="form-label">내용</label>
                                <textarea name="content" id="content" class="form-control" rows="8" required>${dto.content}</textarea>
                            </div>
                            
                            <div class="text-end mt-4 mb-3 me-5">
                                <button type="button" class="btn btn-light bg-secondary text-white " onclick="submitContents(this.form);">
                                    ${mode=='update'?'수정완료':'등록'}
                                </button>
                                <button type="button" class="btn border border-secondary ms-2" onclick="location.href='${pageContext.request.contextPath}/mealCmnt/list';">
                                    ${mode=='update'?'수정취소':'취소'}
                                </button>
                                <input type="hidden" name="category" value="${category}">
                                <c:if test="${mode=='update'}">
                                    <input type="hidden" name="num" value="${dto.num}">
                                    <input type="hidden" name="page" value="${page}">
                                    <input type="hidden" name="fileSize" value="${dto.fileSize}">
                                    <input type="hidden" name="saveFilename" value="${dto.saveFilename}">
                                    <input type="hidden" name="originalFilename" value="${dto.originalFilename}">
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 푸터 영역 -->
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fas fa-arrow-up"></i></a>
    <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
</body>
</html>