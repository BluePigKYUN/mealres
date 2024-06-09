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
                            <ul class="nav nav-pills d-inline-flex text-center mb-5 activity_tab">
                                <li class="nav-item">
                                    <span class="nav-link active bg-primary text-white rounded-pill" data-bs-toggle="pill">
                                        <a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=1">게시물</a>
                                    </span>
                                </li>
                                <li class="nav-item">
                                    <span class="nav-link bg-success text-white rounded-pill" data-bs-toggle="pill">
                                        <a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=2">댓글</a>
                                    </span>
                                </li>
                                <li class="nav-item">
                                    <span class="nav-link bg-danger text-white rounded-pill" data-bs-toggle="pill">
                                        <a style="width: 130px;" href="${pageContext.request.contextPath}/member/activity?mode=3">좋아요</a>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                        <%
                        String[] dtoType = {"식단", "운동", "자유", "우수회원", "고민", "식단컬럼", "운동컬럼"};
                        String[] dtoUrl = {"mealCmnt/article", "exerCmnt/article", "freeCmnt/article", "oMemberCmnt/article",
                                "concernCmnt/article", "mealColumn/article", "exrcsColumn/article"};
                        request.setAttribute("dtoType", dtoType);
                        request.setAttribute("dtoUrl", dtoUrl);
                        %>
                        <div id="tab-1" class="tab-pane fade show p-0 active">
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
                                                <td>
                                                    <c:set var="index" value="${dto.type}" />
                                                    <span class="badge type_${dto.type}">
                                                        <c:out value="${dtoType[index-1]}" />
                                                    </span>
                                                </td>
                                                <td class="left">
                                                    <a href="../<c:out value="${dtoUrl[index-1]}" />?num=${dto.num}" class="text-reset">${dto.subject}</a>
                                                </td>
                                                <td>${dto.reg_date}</td>
                                                <td>
                                                    <button class="btn-delete" type="button" onclick="deleteBtn(${dto.num}, ${dto.type});">
                                                        <i class="bi bi-x-square-fill"></i>
                                                    </button>
                                                </td>
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
                                    <tbody>
                                        <c:forEach var="dto" items="${list}" varStatus="status">
                                            <tr>
                                                <td>${dataCount - (pageNo-1) * size - status.index}</td>
                                                <td>
                                                    <c:set var="index" value="${dto.type}" />
                                                    <span class="badge type_${dto.type}">
                                                        <c:out value="${dtoType[index-1]}" />
                                                    </span>
                                                </td>
                                                <td class="left">
                                                    <a href="../<c:out value="${dtoUrl[index-1]}" />?num=${dto.num}" class="text-reset">${dto.content}</a>
                                                </td>
                                                <td>${dto.reg_date}</td>
                                                <td>
                                                    <button class="btn-delete2" type="button" onclick="deleteBtn2(${dto.replyNum}, ${dto.type});">
                                                        <i class="bi bi-x-square-fill"></i>
                                                    </button>
                                                </td>
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
                                        <!-- 좋아요 탭 내용 여기에 추가 -->
                                    </tbody>
                                </table>
                            </c:if>
                            <!-- //탭 3 -->

                            <!-- 페이징 처리 -->
                            <nav aria-label="Page navigation example">
                                <ul class="pagination d-flex justify-content-center pt-4">
                                    <li class="page-item m_prev">
                                        <a class="page-link" href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${startPage}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == pageNo ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item m_next ${pageNo == total_page ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/member/activity?mode=${mode}&pageNo=${pageNo + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                        <input type="hidden" id="mode" value="${param.mode}">
                                        <input type="hidden" id="pageNo" value="${param.pageNo}">
                                        <input type="hidden" id="replyNum" value="${dto.replyNum}">
                                    </li>
                                </ul>
                            </nav>
                            <!-- //페이징 처리 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
    </footer>
    <script>
    function deleteBtn(postNum, postType) {
        if (confirm("삭제하시겠습니까?")) {
            let mode = document.getElementById("mode").value;
            let pageNo = document.getElementById("pageNo").value;
            let url = "${pageContext.request.contextPath}/member/postDelete?num=" + postNum + "&type=" + postType + "&mode=" + mode + "&pageNo=" + pageNo;
            location.href = url;
        }
    }

    function deleteBtn2(replyNum, postType) {
        if (confirm("삭제하시겠습니까?")) {
            let mode = document.getElementById("mode").value;
            let pageNo = document.getElementById("pageNo").value;
            let url = "${pageContext.request.contextPath}/member/replyDelete?num=" + replyNum + "&type=" + postType + "&mode=" + mode + "&pageNo=" + pageNo;
            location.href = url;
        }
    }
    </script>
</body>
</html>
