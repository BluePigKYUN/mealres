<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri = "jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri = "jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
    	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"></jsp:include>
    	
<style type="text/css">
    .body-container {
    		max-width: 1000px;
    		margin: 0 auto;
    	}
    .table-article img { max-width: 65%; }
    
</style>
    </head>
    
    <header>
    	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    </header>
    
<body>
 	
 	<div class="container-fluid page-header-mealColumn py-5">
            <h1 class="text-center text-white display-6">Mealers가 알려주는 건강 정보</h1>
     </div>
     
	<div class="container">
		<div class="container-fluid fruite py-5">	
			<div class="body-main">
			   <div class="table-responsive">
					<table class="table table-article border border-1">
					    <thead class="align-middle text-center bg-light">
					        <tr>
					            <td colspan="2" class="bg-primary align-middle text-center">
					                <h3 class="text-white m-3 text-center">${dto.subject}</h3>
					            </td>
							</tr>
						</thead>
						
						<tbody>
							<tr class="m-3">
								<td class="p-3" align="left" style="text-align: left;">
									이름 : 밀티쥬
								</td>
								<td class="p-3 text-end">
									 ${dto.reg_date}| 조회 ${dto.hitCount}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" valign="top" height="200" style="border-bottom: none;">
									${dto.content}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" class="text-center p-3" style="border-bottom: none;">
									<button type="button" class="btn btn-outline-primary btnSendMealColLike" title="좋아요"><i class="bi bi-hand-thumbs-up-fill" style="color: ${isUserLike?'#20C997':'black'}"></i>&nbsp;&nbsp;<span id="mealColLikeCount">${dto.likeCount}</span></button>
								</td>
							</tr>
							
							<tr>
								<td colspan="2">
									<c:if test="${not empty dto.saveFilename}">
										<p class="border text-secondary mb-1 p-2">
											<i class="bi bi-folder2-open"></i>
											<a href="${pageContext.request.contextPath}/mealColumn/download?num=${dto.num}">${dto.originalFilename}</a>
										</p>
									</c:if>
								</td>
							</tr>
	
						</tbody>
					</table>
				</div>
				<table class="table table-borderless">
					<tr>
						<td class="text-start">
								<c:choose>
									<c:when test="${sessionScope.member.userNum=='1'}">
										<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/mealColumn/update?num=${dto.num}&page=${page}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn border-primary m-2 py-2 rounded-pill text-primary" disabled>수정</button>
									</c:otherwise>
								</c:choose>
						    	
								<c:choose>
						    		<c:when test="${sessionScope.member.userNum=='1'}">
						    			<button type="button" class="btn border-primary m-2 py-2 rounded-pill text-primary" onclick="deleteMealColumn();">삭제</button>
						    		</c:when>
						    		<c:otherwise>
						    			<button type="button" class="btn border-primary m-2 py-2 rounded-pill text-primary" disabled>삭제</button>
						    		</c:otherwise>
						    	</c:choose>
						</td>
						<td class="text-end">
							<button type="button" class="btn btn-primary m-2 py-2 rounded-pill text-white" onclick="location.href='${pageContext.request.contextPath}/mealColumn/list?${query}';">리스트</button>
						</td>
					</tr>
				</table>
				
				<div class="reply">
					<form name="replyForm" method="post">
						<div class='px-3 pb-2 form-header'>
							<span class="text-secondary bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
						</div>
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<textarea class='form-control' name="content"></textarea>
								</td>
							</tr>
							<tr>
							   <td align='right'>
							        <button type='button' class='btn btn-primary m-2 py-2 px-4 rounded-pill text-white btnSendReply'>댓글 등록</button>
							    </td>
							 </tr>
						</table>
					</form>
					
					<div id="listReply"></div>
				</div>
				
			</div>
		</div>
	</div>
	
        <!-- Footer Start -->
        <footer>
        	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
			<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"></jsp:include>
        </footer>
        <!-- Footer End -->

		<script type="text/javascript">
		function deleteMealColumn() {
			if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
				   let query = "num=${dto.num}&page=${page}";
				   let url = "${pageContext.request.contextPath}/mealColumn/delete?" + query;
				 location.href = url;
			
			}
		}
		
		function login() {
			location.href="${pageContext.request.contextPath}/member/login";
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

		// 게시물 공감 여부
		$(function(){
			$(".btnSendMealColLike").click(function(){
				const $i = $(this).find("i");
				let isNoLike = $i.css("color") == "rgb(0, 0, 0)";
				let msg = isNoLike ? "게시글에 공감하십니까 ? " : "게시글 공감을 취소하시겠습니까 ? ";
				
				if(! confirm( msg )) {
					return false;
				}
				
				let url = "${pageContext.request.contextPath}/mealColumn/insertMealColLike";
				let num = "${dto.num}";
				let query = "num=" + num + "&isNoLike=" + isNoLike;;
		
				const fn = function(data) {
					let state = data.state;
					
					if(state === "true") {
						let color = "black";
						if( isNoLike ) {
							color = "#20C997";
						}
						$i.css("color", color);
						
						let count = data.likeCount;
						
						$("#mealColLikeCount").text(count);
					} else if(state === "liked") {
						alert("좋아요는 한번만 가능합니다. !!!");
					}
				};
				
				ajaxFun(url, "post", query, "json", fn);
			});
		});
		
		</script>
    </body>
</html>