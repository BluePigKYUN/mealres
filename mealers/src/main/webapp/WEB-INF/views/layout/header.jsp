<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>


        <div class="container-fluid fixed-top">
            <div class="container topbar bg-primary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                    </div>
                    <div class="top-link pe-2">
                    </div>
                </div>
            </div>
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="${pageContext.request.contextPath}/main" class="navbar-brand"><h1 class="text-primary display-6">Mealers</h1></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                         <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">칼로리 검색</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="${pageContext.request.contextPath}/search/main" class="dropdown-item">음식 칼로리 검색</a>
                                    <a href="#" class="dropdown-item">음식 등록하기</a>
                                </div>
                            </div>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">칼럼</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="${pageContext.request.contextPath}/mealColumn/list" class="dropdown-item">식단 칼럼</a>
                                    <a href="${pageContext.request.contextPath}/mealColumn/list" class="dropdown-item">운동 칼럼</a>
                                </div>
                            </div>
                             <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">커뮤니티</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="${pageContext.request.contextPath}/mealCmnt/list" class="dropdown-item">식단 커뮤니티</a>
                                    <a href="${pageContext.request.contextPath}/exerCmnt/list" class="dropdown-item">운동 커뮤니티</a>
                                    <a href="${pageContext.request.contextPath}/freeCmnt/list"class="dropdown-item">자유 커뮤니티</a>
                                    <a href="${pageContext.request.contextPath}/oMemberCmnt/list"class="dropdown-item">우수회원 커뮤니티</a>
                                    <a href="${pageContext.request.contextPath}/concernCmnt/list"class="dropdown-item">고민상담 커뮤니티</a>
                                    <a href="${pageContext.request.contextPath}/group/list"class="dropdown-item">그룹방</a>
                                </div>
                            </div>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">목표</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="mealers/member/login" class="dropdown-item">카테고리1</a>
                                    <a href="mealers/member/login" class="dropdown-item">카테고리1</a>
                                </div>
                            </div>
                             <div class="nav-item dropdown">
                                <a href="contact.html" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">기록</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="${pageContext.request.contextPath}/log/main" class="dropdown-item">소개</a>
                                    <a href="${pageContext.request.contextPath}/log/event" class="dropdown-item">일정기록</a>
                                    <a href="${pageContext.request.contextPath}/log/diary" class="dropdown-item">일상기록</a>
                                    <a href="${pageContext.request.contextPath}/log/foodi" class="dropdown-item">음식기록</a>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <a href="${pageContext.request.contextPath}/member/login" class="position-relative me-4 my-auto">
                                <i class="bi bi-box-arrow-in-right fa-2x"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/member/mypage" class="my-auto">
                                <i class="fas fa-user fa-2x"></i>
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>