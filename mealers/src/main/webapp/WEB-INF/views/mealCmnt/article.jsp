<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>

<style type="text/css">

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


.replyContent {
	border-bottom: 1px solid #EAEAEA;
}

.replyContent:last-child {
	border-bottom: none;
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
	-webkit-line-clamp: 5;
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
}

</style>
</head>


<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>
	
	
	<div class="container-fluid ">
		<div class="container ">
			<div class="row g-4 content my-5 w-50" >
				<div class="border border-3 border-secondary rounded px-0 position-relative" style="height: auto; min-height: 800px">
					<div class="flex-grow-1" style="height: 50%">
						<img src="${pageContext.request.contextPath}/uploads/mealCmnt/${dto.fileName}" class="img-fluid rounded object-fit-cover" >
					</div>
						
					<button type="button" class="px-2 py-1 position-absolute likeheart" style="top: 10px; right: 10px;"> <i class="bi bi-heart-fill" style="color: ${isLikeCmnt?'rgb(255, 0, 0)':'white'}"></i>&nbsp;&nbsp;</button> 
					
					<div class="flex-grow-1" style="height: 50%">
						 <div style="height: 75%">
							<div class="d-flex flex-row justify-content-between pt-4 pb-3 px-3 ">
									
								<div class="text-white bg-secondary px-2 rounded w-25 py-1 text-center">${dto.mem_Nick}</div>
								<div class="align-self-center">두시간전</div>
							</div>

							<h3 class="fw-bold ms-5 py-3 ps-1 mb-0 ">${dto.subject}</h3>
							<div class="ms-5 w-75 ps-1 mt-2 content-box " style="max-height: 180px">${dto.content}</div>
						</div>
						<div class="d-flex justify-content-between bottom-0 start-0 bottom-item pt-5 mb-1" style="height: 25%">
							<p class="ms-4 mb-1">
								<span>댓글10</span> 
								<span>좋아요
									<span id="cmntLikeCount">${likeCount}</span>
								</span> 
								<span>조회수${dto.hitCount}</span>
							</p>
							<p class="me-4">${dto.reg_date}</p>
						</div>
					</div>
				</div>
				<div class="col-lg-12 h-25 mt-4 px-0 d-flex justify-content-between">
					<div>
						<button type="button" class="btn border border-secondary text-secondary rounded-pill" >수정</button>
						<button type="button" class="btn border border-secondary text-secondary rounded-pill ms-1" >삭제</button>
					</div>
					<button type="button" class="btn text-white bg-secondary rounded-pill ms-1" onclick="location.href='${pageContext.request.contextPath}/mealCmnt/list';">목록</button>
				</div>
			</div>	
			<div class="row g-4 content mb-5 mt-2 pb-3 w-75" style="height: auto;">	
				<form action="#" class="replywrite " style="height: 30%">
					<div class="row g-4">
						<div class="col-lg-12">
							<div class="rounded">
								<textarea name="reply" class="form-control border" cols="30"
									rows="4" placeholder="댓글을 입력하세요 *"></textarea>
							</div>
						</div>
						<div class="col-lg-12 h-25 my-2">
							<div class="d-flex justify-content-end mt-1">
								<button type="button" class="btn text-white bg-primary text-primary rounded-pill">등록</button>
							</div>
						</div>
					</div>
				</form>
				
				<div class="replyBox mt-0" style="height: 70%" >
					<div class="col-lg-12 topContent" >
						<h6>댓글 3개 </h6>
					</div>
							
					<div class="replyContent pb-3">
						<div class="d-flex justify-content-between fw-bold pt-3 pb-2 ">
							<p>명수(닉네임)</p>
							<div class="d-flex">
								<p>2024-05-31 00:56</p>
								<a class="mx-2">삭제</a>
							</div>
						</div>
						<div>
							<div>아버지나를낳으시고바지적삼다적시셨네</div>
						</div>
					</div>
					<div class="replyContent pb-3">
						<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
							<div>명수(닉네임)</div>
							<div class="d-flex">
								<div>2024-05-31 00:56</div>
								<a class="mx-2">삭제</a>
							</div>
						</div>
						<div>
							<div>아버지나를낳으시고바지적삼다적시셨네</div>
						</div>
					</div>
					
					<div class="replyContent pb-3">
						<div class="d-flex justify-content-between fw-bold pt-3 pb-2 ">
							<p>명수(닉네임)</p>
							<div class="d-flex">
								<p>2024-05-31 00:56</p>
								<a class="mx-2">삭제</a>
							</div>
						</div>
						<div>
							<div>아버지나를낳으시고바지적삼다적시셨네</div>
						</div>
					</div>
					
					<div class="replyContent pb-3">
						<div class="d-flex justify-content-between fw-bold pt-3 pb-2 ">
							<p>명수(닉네임)</p>
							<div class="d-flex">
								<p>2024-05-31 00:56</p>
								<a class="mx-2">삭제</a>
							</div>
						</div>
						<div>
							<div>아버지나를낳으시고바지적삼다적시셨네</div>
						</div>
					</div>
					
					<div class="replyContent pb-3">
						<div class="d-flex justify-content-between fw-bold pt-4 pb-3 ">
							<div>명수(닉네임)</div>
							<div class="d-flex">
								<div>2024-05-31 00:56</div>
								<a class="mx-2">삭제</a>
							</div>
						</div>
						<div>
							<div>아버지나를낳으시고바지적삼다적시셨네</div>
						</div>
					</div>
						
					<div class="sentinel" data-loading="false"></div>
				</div>
					
				
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
			settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
			settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
		}
		
		$.ajax(url, settings);
	}
	
	$(function() {
		
		$(".likeheart").click(function() {
			const $i = $(this).find("i");
			let isNoLike = $i.css("color") === "rgb(255, 255, 255)";
			
			let msg = isNoLike ? "게시글에 공감하시겠습니까?" : "게시글 공감을 취소하시겠습니까?";

			if(! confirm(msg)) {
				return false;
			}
			
			let url = "${pageContext.request.contextPath}/mealCmnt/addlikeCmnt";
			let num  = "${dto.num}";
			let query = "num=" + num + "&isNoLike=" + isNoLike;
			
			const fn = function(data) {
				let state = data.state;
				if(state === "true") {
					let color = "rgb(255, 255, 255)";
					if(isNoLike) {
						color = "rgb(255, 0, 0)";
					}
					$i.css("color", color);
					
					let count = data.likeCount;
					$("#cmntLikeCount").text(count); // text 사용..
				}
			};
			ajaxFun(url, "post", query, "json", fn);
		});
	});
	
	
	
	</script>
</body>

</html>