<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>그룹 게시물</title>
<style>
body {
	background-color: #f5f8fa;
	font-family: Arial, sans-serif;
	padding-top
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
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
		<div class="container">
			<div class="row">
				<div class="col-md-8">
					<!-- 그룹 게시글 작성폼 -->
					<form id="postForm">
						<input type="hidden" name="groupnum" value="${groupNum}">
						<!-- groupnum을 hidden 필드로 전송 -->
						<div class="card mb-3">
							<div class="card-body">
								<textarea class="form-control" name="content" rows="3"
									placeholder="무슨 일이 있었나요?" maxlength="140"></textarea>
								<small id="charCount" class="form-text text-muted">0/140</small>
								<div class="d-flex justify-content-between mt-2">
									<div class="form-group">
										<label for="uploadImage" class="form-label"><i
											class="bi-image me-2"></i>사진 첨부</label> <input type="file"
											id="uploadImage" class="form-control" name="image"
											accept="image/*">
										<div id="preview" class="mt-2"></div>
									</div>
									<div class="g_btn_box">
										<button type="button" class="btn btn-primary btn-sm"
											onclick="submitForm()">게시하기</button>
									</div>
								</div>
							</div>
						</div>
					</form>
					<!-- 그룹 게시글 리스트 -->
					<div class="card mb-3" id="postList">
						<c:forEach var="post" items="${list}" varStatus="status">
							<div class="card mb-3">
								<div class="card-body">
									<div class="d-flex">
										<img src="${pageContext.request.contextPath}/uploads/member/${sessionScope.member.fileName}" 
										<%-- "${pageContext.request.contextPath}/resources/images/default.png" --%>
										<%-- ${post.imageUrl ? post.imageUrl : ''} --%>
											class="rounded-circle me-2" alt="프로필 이미지">
										<div>
											<h5 class="mb-0">${post.reg_Date}</h5>
											<small class="text-muted">${post.groupNum}</small>
										</div>
									</div>
									<p class="mt-2 mb-0">${post.content}</p>
								</div>
								<div class="card-footer">
									<a href="#" class="comment-btn me-3" ><!-- data-bs-toggle="modal"
										data-bs-target="#commentModal" --><i class="bi bi-chat me-1"></i>댓글
										달기</a> <a href="#" class="me-3"><i class="bi bi-heart me-1"></i>좋아요</a>
									<a href="#"><i class="bi bi-share me-1"></i>공유하기</a>
								</div>
							</div>
						</c:forEach>
						<!-- 게시물 생성 -->
					</div>
					<!-- 마지막 감시 DIV -->
					<div class="sentinel" data-loading="false"></div>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />

	<script>
    function submitForm() {
        var formData = new FormData(document.getElementById('postForm'));

        $.ajax({
            url: '${pageContext.request.contextPath}/post/insert',
            type: 'POST',
            data: formData,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success: function(response) {
                console.log(response); // 서버 응답 데이터 확인
                if (response.state === "true") {
                    let post = JSON.parse(response.post);
                    $('#postList').prepend(createPostHTML(post)); // append 대신 prepend 사용
                    $('#postForm')[0].reset();
                    $('#preview').empty();
                    alert('게시물이 저장되었습니다.');
                } else {
                    alert('게시물 저장에 실패했습니다.');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('오류가 발생했습니다: ' + textStatus);
            }
        });
    }

    let htmlText = "";
    function createPostHTML(post) {
        return `
            <div class="card mb-3">
                <div class="card-body">
                    <div class="d-flex">
                        <img src="${post.imageUrl ? post.imageUrl : ''}" class="rounded-circle me-2" alt="프로필 이미지">
                        <div>
                            <h5 class="mb-0">` + post.userNum + `</h5>
                            <small class="text-muted">` + post.groupNum + `</small>
                        </div>
                    </div>
                    <p class="mt-2 mb-0">` + post.content + `</p>
                </div>
                <div class="card-footer">
                    <a href="#" class="comment-btn me-3" data-bs-toggle="modal" data-bs-target="#commentModal"><i class="bi bi-chat me-1"></i>댓글 달기</a>
                    <a href="#" class="me-3"><i class="bi bi-heart me-1"></i>좋아요</a>
                    <a href="#"><i class="bi bi-share me-1"></i>공유하기</a>
                </div>
            </div>
        `;
    }

    document.addEventListener('DOMContentLoaded', function() {
        function ajaxFun(url, method, query, dataType, fn) {
            const sentinelNode = document.querySelector('.sentinel');

            $.ajax({
                type: method,
                url: url,
                data: query,
                dataType: dataType,
                success: function(data) {
                    fn(data);
                },
                beforeSend: function(jqXHR) {
                    sentinelNode.setAttribute('data-loading', 'true');
                    jqXHR.setRequestHeader("AJAX", true);
                },
                error: function(jqXHR) {
                    if (jqXHR.status === 403) {
                        login();
                        return false;
                    } else if (jqXHR.status === 400) {
                        alert("요청 처리가 실패 했습니다.");
                        return false;
                    }
                    console.log(jqXHR.responseText);
                }
            });
        }

        function addNewContent(data) {
            const itemCount = document.querySelector('.item-count');

            if (itemCount) {
                let dataCount = data.dataCount;
                let pageNo = data.pageNo;
                let total_page = data.total_page;


                listNode.setAttribute('data-pageNo', pageNo);
                listNode.setAttribute('data-totalPage', total_page);

                sentinelNode.style.display = 'none';

                if (parseInt(dataCount) === 0) {
                    listNode.innerHTML = '';
                    return;
                }

                for (let post of data.list) {
                    $('#postList').append(createPostHTML(post));
                }

                if (pageNo < total_page) {
                    sentinelNode.setAttribute('data-loading', 'false');
                    sentinelNode.style.display = 'block';
                    io.observe(sentinelNode); // 관찰할 대상 등록
                }
            }
        }

        const listNode = document.querySelector('#postList');
        const sentinelNode = document.querySelector('.sentinel');

        function loadContent(page) {
            let url = '${pageContext.request.contextPath}/group/list';
            let query = "pageNo=" + page + "&groupNum=" + '${groupNum}';
            
            ajaxFun(url, "get", query, "json", addNewContent);
        }

        const ioCallback = (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    let loading = sentinelNode.getAttribute('data-loading');
                    if (loading !== 'false') {
                        return;
                    }

                    observer.unobserve(entry.target);

                    let pageNo = parseInt(listNode.getAttribute('data-pageNo'));
                    let total_page = parseInt(listNode.getAttribute('data-totalPage'));

                    if (pageNo === 0 || pageNo < total_page) {
                        pageNo++;
                        loadContent(pageNo);
                    }
                }
            });
        };

        const io = new IntersectionObserver(ioCallback);
        io.observe(sentinelNode);

        loadContent(1);
    });
    </script>
</body>
</html>
