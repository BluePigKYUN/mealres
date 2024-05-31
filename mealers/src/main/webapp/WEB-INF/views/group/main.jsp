<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 게시물</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    body {
        background-color: #f5f8fa;
        font-family: Arial, sans-serif;
    }
    
    .card {
        border: none;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    }
    
    .card-footer a {
        color: #6c757d;
        text-decoration: none;
    }
    
    .card-footer a:hover {
        color: #212529;
    }
    
    .bi {
        font-size: 1.2rem;
        vertical-align: middle;
    }
    
    .list-group-item {
        border: none;
        padding: 0.5rem 0;
    }
    
    .comment-list {
        max-height: 200px;
        overflow-y: auto;
    }
    
    .btn-sm {
        padding: 0.25rem 0.5rem;
        font-size: 0.875rem;
        border-radius: 0.2rem;
    }
</style>
</head>
<header>
    <jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="card mb-3">
                    <div class="card-body">
                        <textarea class="form-control" rows="3" placeholder="무슨 일이 있었나요?" maxlength="140"></textarea>
                        <small id="charCount" class="form-text text-muted">0/140</small>
                        <div class="d-flex justify-content-between mt-2">
                            <div class="form-group">
                                <label for="uploadImage" class="form-label">
                                    <i class="bi-image me-2"></i>사진 첨부
                                </label>
                                <input type="file" id="uploadImage" class="form-control" accept="image/*">
                                <div id="preview" class="mt-2"></div>
                            </div>
                            <div class="g_btn_box"><button class="btn btn-primary btn-sm">게시하기</button></div>
                        </div>
                    </div>
                </div>

                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex">
                            <img src="https://via.placeholder.com/50" class="rounded-circle me-2" alt="프로필 이미지">
                            <div>
                                <h5 class="mb-0">불꽃남자</h5>
                                <small class="text-muted">3분 전</small>
                            </div>
                        </div>
                        <p class="mt-2 mb-0">오예 금요일</p>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="comment-btn me-3" data-bs-toggle="modal" data-bs-target="#commentModal"><i class="bi bi-chat me-1"></i>댓글 달기</a>
                        <a href="#" class="me-3"><i class="bi bi-heart me-1"></i>좋아요</a>
                        <a href="#"><i class="bi bi-share me-1"></i>공유하기</a>
                    </div>
                    <div class="card-footer">
                        <ul class="list-group list-group-flush comment-list">
                            <!-- 댓글 목록 -->
                        </ul>
                    </div>
                </div>

                <!-- 추가 게시물 -->
            </div>
        </div>
    </div>

    <!-- 댓글 모달창 -->
    <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="commentModalLabel">댓글 달기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" rows="3" placeholder="댓글을 입력하세요"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="submitComment">댓글 등록</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        
    
        $('#charCount').text('0/140');
        $('textarea').on('input', function() {
            const maxLength = 140;
            const currentLength = $(this).val().length;
            const remainingChars = maxLength - currentLength;

            if (remainingChars < 0) {
                $(this).val($(this).val().substr(0, maxLength));
            }

            $('#charCount').text(`${currentLength}/${maxLength}`);
        });

        // 사진 미리보기 기능
        $('#uploadImage').on('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function() {
                    $('#preview').html(`<img src="${reader.result}" class="img-fluid">`);
                }
                reader.readAsDataURL(file);
            } else {
                $('#preview').empty();
            }
        });

        // 댓글 달기
        $('.comment-btn').click(function() {
            $('#commentModal').modal('show');
        });

        // 댓글 등록
        $('#submitComment').click(function() {
            var commentText = $('#commentModal textarea').val();
            
            $.ajax({
                url: '/submit-comment',
                type: 'POST',
                data: { comment: commentText },
                success: function(response) {
                    
                    $('#commentModal').modal('hide');
                    // 댓글 목록을 업데이트
                },
                error: function() {
                    
                    alert('댓글 등록에 실패했습니다.');
                }
            });
        });
    </script>
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </footer>
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fas fa-arrow-up"></i></a>
    <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
</body>
</html>