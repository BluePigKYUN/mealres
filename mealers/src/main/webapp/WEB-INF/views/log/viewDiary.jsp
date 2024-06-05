<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>서랍장 열기</title>
<script type="text/javascript">

</script>
</head>
<body>
    <!-- 헤더 영역 -->
    <header>
        <jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>

    <!-- 본문 영역 -->
    <div class="container py-2">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card bg-gradient-primary shadow-lg rounded-lg">
                    <div class="card-body">
                        <h2 class="card-title text-center mt-3">
                            <i class="bi-book-half me-2"></i>순간
                        </h2>
                            <i class="float-end">🌼기록은 향기와 같다🌻 <br>맡을 순 있지만 붙잡을 순 없다👀 </i><br>
                        <form name="viewForm" method="post">
                            <div class="form-group mb-3">
                                <label for="subject" class="form-label">&nbsp;&nbsp;&nbsp;제목</label>
                                <input type="text" name="subject" id="subject" class="form-control" value="${dto.subject}" readonly>
                            </div>
                            <div class="form-group mb-3">
                                <label for="author" class="form-label">&nbsp;&nbsp;&nbsp;작성했던 날짜</label>
                                <input type="text" id="author" class="form-control" value="${dto.reg_date_diary}" readonly>
                            </div>
                            <div class="form-group mb-3">
                                <label for="emotion" class="form-label">
                                    <span class="h6">&nbsp;&nbsp;&nbsp;감정&nbsp;</span>
                                    <span class="${dto.emoji} h5"></span><br>
                                </label>
                            </div>
                            <div class="form-group mb-3">
                                <label for="content" class="form-label">&nbsp;&nbsp;&nbsp;그날의 기억</label>
                                <textarea name="content" id="content" class="form-control" rows="8" readonly>${dto.content}</textarea>
                            </div>
                            
                            <div class="text-center mt-4">
                                <input type="hidden" name="diaryNum" id="diaryNum" value="${diaryNum}">
                                <input type="hidden" name="pageNo" id="pageNo" value="${pageNo}">
                                <button type="button" id="deleteButton" class="btn btn-light shadow" onclick="deleteDiary();">
									일기 지우기<i class="bi bi-scissors"></i>
                                </button>
                                <button type="button" class="btn btn-light shadow" onclick="location.href='${pageContext.request.contextPath}/log/diary?pageNo=${pageNo}';">
									돌아가기<i class="bi bi-back"></i>
                                </button>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
    function deleteDiary() {
		if(confirm("일기를 정말로 삭제하시겠어요?")){
			let query = "${query}";
			let diaryNum = document.getElementById("diaryNum").value;
			let url = "${pageContext.request.contextPath}/log/deleteDiary?" + query + "&diaryNum=" + diaryNum;
			location.href = url;	
		}
	}
    </script>
    
    <!-- 푸터 영역 -->
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fas fa-arrow-up"></i></a>
    <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
</body>
</html>