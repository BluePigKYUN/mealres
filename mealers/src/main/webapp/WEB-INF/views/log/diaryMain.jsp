<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일기</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util-jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/core.js"></script>

<script type="text/javascript">
$(function(){
	$("body").on("click", "#writeDiary", function(){
		// 폼 reset
		$("form[name=diaryForm]").each(function(){
			this.reset();
		});
		
		
		$("#myDialogModalLabel").html("스케쥴 등록");
		$("#btnDiarySendOk").attr("data-mode", "insert");
		$("#btnDiarySendOk").html(" 등록 완료 ");
		$("#btnDiarySendCancel").html(" 등록 취소 ");
		
		$("#diaryForm").modal("show");
	});
});

//등록완료버튼
$(function(){
	$("#btnDiarySendOk").click(function(){
		if(! check()) {
			return false;
		}
		
		let mode = $("#btnDiarySendOk").attr("data-mode");
		let query = $("form[name=diaryForm]").serialize();
		let url = "${pageContext.request.contextPath}/diary/"+ mode +"";

		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if(mode === "insert") {
					let dd = $("#form-sday").val().split("-");
					let y = dd[0];
					let m = dd[1];
					if(m.substr(0,1) === "0") m = m.substr(1,1);
				
				    let url = "${pageContext.request.contextPath}/schedule/month";
				    let query = "year="+y+"&month="+m;
				    schedule(url, query, "#nav-1");
				} else if(mode === "update") {
					let num = $("#btnDiarySendOk").attr("data-num");
					let date = $("#btnDiarySendOk").attr("data-date");
					
					let url = "${pageContext.request.contextPath}/schedule/day"
					let query = "date="+date+"&num="+num;
						
					schedule(url, query, "#nav-2");
				}
			}
			
			$("#diaryForm").modal("hide");
			
		};
		
		ajaxFun(url, "post", query, "json", fn);		
	});
});

//취소버튼
$(function(){
	$("#btnDiarySendCancel").click(function(){
		$("#diaryForm").modal("hide");
	});
});

//등록내용 유효성 검사
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}
	
	if (! $("input[name='emotion']:checked").val()) {
		alert("감정상태를 선택해주세요.");
		return false;
	}
	
	if(! $("#form-diary").val()){
		$("#form-diary").focus();
		return false;
	}
	
	return true;
}

//modal에 날짜를 바로 출력해주는 설정
$(function() {
    $('#diaryForm').on('shown.bs.modal', function () {
        let today = new Date().toISOString().split('T')[0];
        $('#form-today').val(today);
    });
});

$(function() {
    $('#form-diary').keyup(function(e) {
        let content = $(this).val();

        if (content.length == 0 || content == '') {
            $('.count').text('0자');
        } else {
            $('.count').text(content.length + '자');
        }
        
    });
});

$

$(function() {
	$('#writeDiary').on('click', function() {
		$('.count').text('0자');
	})
})

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
};
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-fluid py-5">
	<div class="container py-5 my-5">
       
		<div class="row">
			<div class="col-lg-8">
				<h2 class="mb-4">작은 서랍장(일기)</h2>
				<div class="list-group">
					<div class="list-group-item d-flex align-items-start">
						<div class="me-3">
							<i class="bi bi-calendar3"></i>
						</div>
						<div>
							<span class="fw-bold d-block">날짜를 출력할 부분</span>
							<p class="mb-0 d-block">일기 제목을 출력할 부분</p>
						</div>
                        <button type="button" class="btn ms-auto">일기 보기</button>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
					<nav aria-label="Page navigation example">
						<ul class="pagination d-flex justify-content-center pt-4">
							<li class="page-item m_prev">
								<a class="page-link" href="#" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item m_next">
								<a class="page-link" href="#" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</ul>
					</nav>
					<div class="d-flex align-items-center">
						<button type="button" class="btn btn-primary" id="writeDiary">일기 작성</button>
					</div>
				</div>
           	</div>
	        <div class="col-lg-4">
	            <div class="mb-4">
	                <h3>오늘 일기 미리보기<br>(제목과 날짜만 표시)</h3>
	                <div class="d-flex align-items-center bg-light p-3 rounded">
	                    <button class="btn btn-primary me-3">버튼</button>
	                    <div>
	                        <div class="d-flex align-items-center">
	                            <i class="bi bi-calendar3 me-2"></i>
	                            <span class="fw-bold">2024-05-29</span>
	                        </div>
	                        <p class="mb-0">프로젝트 언제 끝날까요?</p>
	                    </div>
	                </div>
	            </div>
	            <div class="mb-4">
	                <h3>선택한 감정들</h3>
	                <ul class="list-group">
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-smile me-2"></i> 80% 기쁨
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-laughing me-2"></i> 10% 신남
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-frown me-2"></i> 5% 슬픔
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-angry me-2"></i> 3% 분노
	                    </li>
	                    <li class="list-group-item d-flex align-items-center">
	                        <i class="bi bi-emoji-neutral me-2"></i> 2% 그냥그럼
	                    </li>
	                </ul>
	            </div>
	            <div>
	                <h3>일주일 전 일기</h3>
	                <ul class="list-group">
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">날짜를 출력할 부분</span>
	                            <p class="mb-0">제목을 출력할 부분</p>
	                        </div>
	                    </li>
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">2024-05-29</span>
	                            <p class="mb-0">최근일기만 출력</p>
	                        </div>
	                    </li>
	                    <li class="list-group-item d-flex align-items-start">
	                        <div class="me-3">
	                            <i class="bi bi-calendar3"></i>
	                        </div>
	                        <div>
	                            <span class="fw-bold">2024-05-29</span>
	                            <p class="mb-0">최대 3개 까지만</p>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<!-- write Diary Modal Start -->
<div class="modal fade" id="diaryForm" data-bs-backdrop="static" data-bs-keyboard="false" 
		tabindex="-1" aria-labelledby="imyDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="diaryFormLabel">일기 작성</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-0 pb-0">
        		<form name="diaryForm">
        			<table class="table">
        			
						<tr>
						    <td class="col-2">작성일자</td>
						    <td>
						        <div class="row">
						            <div class="col col-sm-4 pe-1">
						                <input type="date" name="today" id="form-today" class="form-control" readonly>
						            </div>
						        </div>
						    </td>
						</tr>
        			
						<tr>
							<td class="col-2">제 목</td>
							<td>
								<input type="text" name="subject" id="form-subject" class="form-control" placeholder="일기제목을 작성해주세요.">
							</td>
						</tr>
						
						<tr>
							<td class="col-2">감정선택</td>
							<td>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji1" value="bi-emoji-smile">
								  <label class="form-check-label" for="emoji1"><i class="bi bi-emoji-smile me-2"></i></label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji2" value="bi-emoji-laughing">
								  <label class="form-check-label" for="emoji2"><i class="bi bi-emoji-laughing me-2"></i></label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji3" value="bi-emoji-frown">
								  <label class="form-check-label" for="emoji3"><i class="bi bi-emoji-frown me-2"></i></label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji4" value="bi-emoji-angry">
								  <label class="form-check-label" for="emoji4"><i class="bi bi-emoji-angry me-2"></i></label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji5" value="bi-emoji-neutral">
								  <label class="form-check-label" for="emoji5"><i class="bi bi-emoji-neutral me-2"></i></label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" name = "emotion" type="radio" id="emoji6" value="bi-cloud-drizzle">
								  <label class="form-check-label" for="emoji6"><i class="bi bi-cloud-drizzle me-2"></i></label>
								</div>
							</td>
						</tr>

						<tr>
							<td class="col-2">일기<br>
							<span class="count"></span><br>
							<span class="total">/1000자</span></td>
							<td>
								<textarea name="diary" id="form-diary" class="form-control" style="height: 300px; resize: none;"
									maxlength="1000" placeholder="일기를 써주세요."></textarea>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" class="text-center" style="border-bottom: none;">
								<input type="hidden" name="num"id="form-num"  value="0">
								<button type="button" class="btn btn-dark" id="btnDiarySendOk"> 등록 완료 </button>
								<button type="button" class="btn btn-light" id="btnDiarySendCancel"> 등록 취소 </button>
							</td>
						</tr>
						
        			</table>
        		</form>
			</div>
		</div>
	</div>
</div>
<!-- write Diary Modal End -->

<footer>
   	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>