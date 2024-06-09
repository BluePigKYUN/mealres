<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
<style>
.custom-card {
    max-width: 100%;
    margin: 20px auto;
    border: 1px solid #ddd;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    animation: float 3s ease-in-out infinite;
}

.custom-card-header {
    background-color: #20c997;
    color: white;
    font-weight: bold;
    text-align: center;
    padding: 10px;
}

.custom-card-body {
    font-size: 0.9rem;
    color: #555;
    padding: 15px;
}

.custom-card-footer {
    background-color: #f8f9fa;
    text-align: center;
    padding: 10px;
    font-size: 0.8rem;
    color: #777;
}

.container-fluid.page-header {
    background-color: #343a40;
    color: white;
    padding: 50px 0;
    text-align: center;
}

.card-img-top {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.card-title {
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.card-text {
    margin-bottom: 15px;
}

.btn-primary:hover {
    background-color: #0056b3;
}

.modal-content {
    border-radius: 15px;
}

.modal-header, .modal-footer {
    border: none;
}

.modal-header .btn-close {
    background: none;
    border: none;
    font-size: 1.5rem;
}

.modal-body .form-control {
    border-radius: 5px;
}

.modal-body .form-label {
    font-weight: bold;
}

.alert-primary {
    background-color: #cce5ff;
    color: #004085;
    border: 1px solid #b8daff;
}

</style>
</head>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
<body>
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">그룹방</h1>
    </div>
    <!-- Page -->
    <div class="container mt-5">
        <div class="row">
            <div class="col-lg-8">
                <c:forEach var="dto" items="${list}" varStatus="state">
                    <div class="card mb-4 custom-card">
                        <img class="card-img-top"
                            src="${pageContext.request.contextPath}/uploads/group/${dto.fileName}"
                            alt="Group Image" />
                        <div class="card-body custom-card-body">
                            <div class="small text-muted">정원</div>
                            <h2 class="card-title">${dto.groupName}</h2>
                            <p class="card-text">${dto.proFile}</p>
                            <a class="btn btn-primary" href="#!">입장</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Side widgets-->
            <div class="col-lg-4">
                <!-- Search widget-->
                <div class="card mb-4">
                    <div class="card-header">Search</div>
                    <div class="card-body">
                        <div class="input-group">
                            <input class="form-control" type="text" placeholder="그룹명 검색"
                                aria-label="Enter search term..."
                                aria-describedby="button-search" />
                            <button class="btn btn-primary" id="button-search" type="button">Go!</button>
                        </div>
                    </div>
                </div>
                <!-- Categories widget-->
                <div class="card mb-4">
                    <div class="card-header"></div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <ul class="list-unstyled mb-0">
                                    <li><a href="#" data-bs-toggle="modal"
                                        data-bs-target="#createGroupModal">만들기</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Side widget-->
                <div class="container mt-5">
                    <button type="button" class="btn btn-secondary" id="popoverButton"
                        data-bs-toggle="popover" title="공지사항"
                        data-bs-content="다양한 그룹을 둘러보고 마음에 드는 그룹에 가입 신청하세요. 그룹장의 승인을 받으면 활동에 참여할 수 있습니다. 같은 목표를 가진 사람들과 소통하며 즐거운 시간을 보내세요!">
                        공지사항 보기</button>
                </div>
            </div>
        </div>
        <!-- Create Group Modal -->
        <div class="modal fade" id="createGroupModal" tabindex="-1"
            aria-labelledby="createGroupModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createGroupModalLabel">그룹 만들기</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-primary" role="alert">그룹에 맞는 특성을
                            표현해주세요!</div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <img id="imagePreview" class="img-fluid rounded shadow" src="#"
                                        alt="Image Preview">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <form name="groupForm" method="post"
                                    enctype="multipart/form-data" class="form-horizontal">
                                    <div class="form-group mb-3">
                                        <label for="subject" class="form-label">그룹명</label> <input
                                            type="text" name="groupName" id="groupName"
                                            class="form-control" value="${dto.groupName}" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="author" class="form-label">닉네임</label> <input
                                            type="text" id="author" class="form-control"
                                            value="${sessionScope.member.userName}" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="content" class="form-label">내용</label>
                                        <textarea name="proFile" id="proFile" class="form-control"
                                            rows="8" required>${dto.proFile}</textarea>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="selectFile" class="form-label"> <i
                                            class="bi-paperclip me-2"></i>첨부파일
                                        </label> <input type="file" name="selectFile" id="selectFile"
                                            class="form-control" onchange="previewImage(this);" required>
                                    </div>
                                    <div class="text-center mt-4">
                                        <button type="button" class="btn btn-light shadow"
                                            onclick="submitContents(this.form);">
                                            등록&nbsp;<i class="bi-check2"></i>
                                        </button>
                                        <button type="button" class="btn btn-light shadow"
                                            data-bs-dismiss="modal">
                                            취소&nbsp;<i class="bi-x"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Create Group Modal -->
    </div>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imagePreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function validateForm() {
            const form = document.forms['groupForm'];
            const groupName = form['groupName'];
            const proFile = form['proFile'];
            const selectFile = form['selectFile'];

            let isValid = true;

            if (!groupName.value.trim()) {
                alert('그룹명을 입력해주세요.');
                groupName.focus();
                isValid = false;
            } else if (!proFile.value.trim()) {
                alert('내용을 입력해주세요.');
                proFile.focus();
                isValid = false;
            } else if (!selectFile.value) {
                alert('첨부파일을 선택해주세요.');
                selectFile.focus();
                isValid = false;
            }

            form.action = "${pageContext.request.contextPath}/group/create";
            return isValid;
        }

        function submitContents(form) {
            if (validateForm()) {
                form.submit();
            }
        }
        document.addEventListener('DOMContentLoaded', function() {
            var popoverTriggerEl = document.getElementById('popoverButton');
            var popover = new bootstrap.Popover(popoverTriggerEl, {
                placement : 'right',
                trigger : 'click'
            });
        });
    </script>
</body>
</html>