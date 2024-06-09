<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>

<style type="text/css">

@keyframes heartMove {
	0% {transform: scale(1)}
	50% {transform: scale(1.3)}
	100% {transform: scale(1)}
}

.content {
   margin: 0 auto;
}

.content .border .w-50 {
	flex: 1;
	overflow: hidden;
}

.content .border img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.topContent {
	border-bottom: 1px solid black;
}

.left-content, .right-content {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.content-box {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 6;
	-webkit-box-orient: vertical;
}

.subject-box {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}



.likeheart {
	font-size: 50px;
	transition: 0.5s;
	background: none;
	border: none;
	
}

.likeheart:hover {
	cursor: pointer;
	animation: heartMove 0.7s forwards;
}



</style>
</head>


<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

	<div class="container-fluid page-header-cmnt py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>
	
	
	<div class="container-fluid ">
		<div class="container ">
			<div class="row g-4 content my-5 w-50" >
				<div class="border border-3 border-secondary rounded px-0 position-relative" style="height: auto; min-height: 800px">
					<div class="flex-grow-1" style="height: 50%">
						<img src="${pageContext.request.contextPath}/uploads/freeCmnt/${dto.fileName}" class="img-fluid rounded object-fit-cover" style="max-height: 460px">
					</div>
					<div class="flex-grow-1" style="height: 50%">
						 <div style="height: 75%">
							<div class="d-flex flex-row justify-content-center align-items-center pt-2 px-3">
								<div class="d-flex w-50">
									<p class="text-white bg-secondary rounded px-2 py-1 text-center ">${dto.mem_Nick}</p>
								</div>	
								<div class="w-50 text-end">
									<button type="button" class="px-2 py-1 likeheart" > <i class="bi bi-heart-fill" style=" color: ${isLikeCmnt?'rgb(255, 0, 0)':'rgb(234, 234, 234)'}"></i></button>
								</div>
							</div>

							<h3 class="fw-bold w-75 ms-5 mb-4 subject-box">${dto.subject}</h3>
							<div class="mx-5 content-box" style="max-height: 180px">${dto.content}</div>
						</div>
						<div class="d-flex justify-content-between pt-5 mx-4" style="height: 25%">
							<p >
								<span>댓글${dto.replyCount}</span> 
								<span>조회수${dto.hitCount}</span>
								<span>좋아요
									<span id="cmntLikeCount">${likeCount}</span> 
								</span> 
							</p>
							<p>${dto.reg_date}</p>
						</div>
					</div>
				</div>
				<div class="col-lg-12 mt-4 px-0 d-flex justify-content-between">
					<div>
						<c:choose>
							<c:when test="${sessionScope.member.userNum == dto.userNum}">
								<button type="button" class="btn border border-secondary text-secondary rounded-pill" onclick="location.href='${pageContext.request.contextPath}/freeCmnt/update?num=${dto.num}&page=${page}&freeSort=${freeSort}';">수정</button>
							</c:when>
							<c:otherwise>
								<button style="display: none"></button>
							</c:otherwise>	
						</c:choose>		
						<c:choose>
							<c:when test="${sessionScope.member.userNum == dto.userNum || sessionScope.member.userId == 'admin'}">		
								<button type="button" class="btn border border-secondary text-secondary rounded-pill ms-1" onclick="deleteFree();">삭제</button>						
							</c:when>
							<c:otherwise>
								<button style="display: none"></button>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<button type="button" class="btn text-white bg-secondary rounded-pill" onclick="location.href='${pageContext.request.contextPath}/freeCmnt/list?${query}';">목록</button>
					</div>
				</div>
			</div>
				
			<div class="row g-4 content mb-5 mt-2 w-75 reply">	
				<form style="height: 30%">		
					<div class="row g-4 reply-write">
						<div class="col-lg-12">
							<div class="rounded">
								<textarea name="reply" class="form-control border" cols="30" rows="4" placeholder="댓글을 입력하세요 *"></textarea>
							</div>
						</div>
						<div class="col-lg-12 h-25 my-2">
							<div class="d-flex justify-content-end mt-1">
								<button type="button" class="btn text-white bg-primary text-primary rounded-pill replySubmit">등록</button>
							</div>
						</div>
					</div>
				</form>
		
				<div id="replyList" class="mt-3"></div>

			</div>
		</div>
	</div>
	

	<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
		<i class="fa fa-arrow-up"></i>
	</a>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
		<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
	</footer>
	
	<script type="text/javascript">
	function login() {
		location.href = "${pageContext.request.contextPath}/member/login";
	}
	
	function ajaxFun(url, method, formData, dataType, fn, file = false) {
		const settings = {
				type: method, 
				data: formData,
				dataType:dataType,
				success:function(data) {
					fn(data);
				},
				beforeSend: function(jqXHR) {
					jqXHR.setRequestHeader('AJAX', true);
				},
				complete: function () {
				},
				error: function(jqXHR) {
					if(jqXHR.status === 403) {
						login();
						return false;
					} else if(jqXHR.status === 400) {
						alert('요청 처리가 실패 했습니다.');
						return false;
			    	}
			    	
					console.log(jqXHR.responseText);
				}
		};
		
		if(file) {
			settings.processData = false; 
			settings.contentType = false;
		}
		
		$.ajax(url, settings);
	}
	
	$(function() {
		
		$(".likeheart").click(function() {
			const $i = $(this).find("i");
			let isNoLike = $i.css("color") === "rgb(234, 234, 234)";
	
			let url = "${pageContext.request.contextPath}/freeCmnt/addlikeCmnt";
			let num  = "${dto.num}";
			let query = "num=" + num + "&isNoLike=" + isNoLike;
			
			const fn = function(data) {
				let state = data.state;
				if(state === "true") {
					let color = "rgb(234, 234, 234)";
					if(isNoLike) {
						color = "rgb(255, 0, 0)";
					}
					$i.css("color", color);
					
					
					let count = data.likeCount;
					$("#cmntLikeCount").text(count); 
				}
			};
			ajaxFun(url, "post", query, "json", fn);
		});
	});
	
	$(function() {
		listPage(1);
	});
	
	function listPage(page) {
		let url = "${pageContext.request.contextPath}/freeCmnt/replyList";
		let query = "num=${dto.num}&pageNo=" + page;
		let selector = "#replyList";
		
		const fn = function(data) {
			$(selector).html(data);
		}
		
		ajaxFun(url, "get", query, "text", fn);
	}
	
	$(function() {
		$(".replySubmit").click(function() {
			let num = "${dto.num}";
			const $d = $(this).closest(".reply-write");
			let content = $d.find("textarea").val().trim();
			
			if(! content) {
				$d.find("textarea").focus();
				return false;
			}
			
			content = encodeURIComponent(content);
			
			let url = "${pageContext.request.contextPath}/freeCmnt/addReply";
			let query = "num=" + num + "&content=" + content;
			
			const fn = function(data) {
				$d.find("textarea").val("");
				let state = data.state;
				if(state === "ok") {
					listPage(1);
				} else {
					alert("댓글 등록에 실패했습니다.");
				}
			};
			ajaxFun(url, "post", query, "json", fn);
		});
	});
	
	$(function() {
		$(".reply").on("click", ".replyDelBtn", function() {
			if(! confirm("댓글을 삭제하시겠습니까?")) {
				return false;
			}
			
			let replyNum = $(this).attr("data-replyNum");
			let page = $(this).attr("data-pageNo");
			
			let url = "${pageContext.request.contextPath}/freeCmnt/removeReply";
			let query = "replyNum=" + replyNum;
			
			const fn = function(data) {
				listPage(page);
			};
			
			ajaxFun(url, "post", query, "json", fn);
		});
	});
	
	</script>
	
	<c:if test="${sessionScope.member.userNum == dto.userNum || sessionScope.member.userId == 'admin'}">
		<script type="text/javascript">
			function deleteFree() {
				if(confirm("글을 삭제하시겠습니까?")) {
					let query = "${query}&num=${dto.num}";
					let url = "${pageContext.request.contextPath}/freeCmnt/delete?" + query;
					location.href = url;
				}
			}
		</script>
	</c:if>
	
	
</body>

</html>