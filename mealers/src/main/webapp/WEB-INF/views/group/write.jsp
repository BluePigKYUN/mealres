<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    
    <title>GORUP WRITE</title>
  
    
</head>
<body>
    <!-- 헤더 영역 -->
    <header>
        <jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>

    <!-- 본문 영역 -->
    <div class="container py-5 mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card bg-gradient-primary shadow-lg rounded-lg">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">
                            <i class="bi-pencil-square me-2"></i>글 등록하기
                        </h2>
                        <form name="lectureForm" method="post" enctype="multipart/form-data">
                            <div class="form-group mb-3">
                                <label for="subject" class="form-label">제목</label>
                                <input type="text" name="subject" id="subject" class="form-control" value="${dto.subject}" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="author" class="form-label">닉네임</label>
                                <input type="text" id="author" class="form-control" value="${sessionScope.member.userName}" readonly>
                            </div>
                            <div class="form-group mb-3">
                                <label for="content" class="form-label">내용</label>
                                <textarea name="content" id="content" class="form-control" rows="8" required>${dto.content}</textarea>
                            </div>
                            <div class="form-group mb-3">
                                <label for="selectFile" class="form-label">
                                    <i class="bi-paperclip me-2"></i>첨부파일
                                </label>
                                <input type="file" name="selectFile" id="selectFile" class="form-control">
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
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-light shadow" onclick="submitContents(this.form);">
                                    ${mode=='update'?'수정완료':'등록'}&nbsp;<i class="bi-check2"></i>
                                </button>
                                <button type="button" class="btn btn-light shadow" onclick="location.href='${pageContext.request.contextPath}/lecture/list?category=${category}';">
                                    ${mode=='update'?'수정취소':'취소'}&nbsp;<i class="bi-x"></i>
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