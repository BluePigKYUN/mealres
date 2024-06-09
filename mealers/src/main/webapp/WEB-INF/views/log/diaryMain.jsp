<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일기</title>
<style type="text/css">
	i.bi-x-circle {
    cursor: pointer;
}

#chartContainer {
    width: 100%;
    height: 400px;
    max-width: 100%;
    min-height: 300px;
}
</style>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container-fluid py-2">
	<div class="container py-2 my-3">
       
		<div class="row">
			<div class="col-lg-8">
				<h2 class="mb-4">작은 서랍장(일기)</h2>
				<p id="diaryCount">작성한 일기 ${dataCount}개</p>
				
				<div class="list-group" data-pageNo="${pageNo}" data-totalPage="${total_page}">
				    <div id="printList" class="list-group-item">
				        <c:choose>
				            <c:when test="${empty list}">
				                <div class="list-group-item d-flex align-items-center">
				                    <div class="me-3">
				                        <i class="bi bi-calendar3"></i>
				                    </div>
				                    <div class="flex-grow-1">
				                        <span class="fw-bold d-block">작성한 일기가 없습니다.</span>
				                        <p class="mb-0 d-block">새로운 일기를 작성해보세요!</p>
				                    </div>
				                </div>
				            </c:when>
				            <c:otherwise>
				                <c:forEach var="dto" items="${list}">
				                    <div class="list-group-item d-flex align-items-start ">
				                        <div class="me-3">
				                            <i class="bi bi-calendar3"></i>
				                        </div>
				                        <div class="flex-grow-1">
				                            <span class="fw-bold d-block">${dto.reg_date_diary} </span>
				                            <p class="mb-0 d-block">${dto.subject} </p>
				                        </div>
				                        <i class="bi bi-x-circle btn" onclick="deleteDiary(${dto.diary_Num}, ${pageNo})"></i>
				                        <button type="button" class="btn ms-auto" data-diaryNum="${dto.diary_Num}" onclick="sendDiaryNum(this)">일기 보기</button>
				                    </div>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </div>
				</div>
                
                <div class="d-flex justify-content-between page-navigation">
					<nav aria-label="Page navigation example">
						<ul class="pagination d-flex justify-content-center pt-4">
							<li class="page-item m_prev">
								<a class="page-link" href="${pageContext.request.contextPath}/log/diary?pageNo=${startPage}" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
             					  <li class="page-item ${i == pageNo ? 'active' : ''}">
                   				<a class="page-link" href="${pageContext.request.contextPath}/log/diary?pageNo=${i}">${i}</a>
              					 </li>
          						</c:forEach>
          						<li class="page-item m_next ${pageNo == total_page ? 'disabled' : ''}">
              					 <a class="page-link" href="${pageContext.request.contextPath}/log/diary?pageNo=${pageNo + 1}" aria-label="Next">
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
				<div class="mb-4 my-5">
				    <h3>랜덤 일기 보기</h3>
				    <div class="d-flex list-group-item align-items-center bg-light p-3 rounded">
				    <c:if test="${not empty randomDiary}">
						<button class="btn btn-primary me-3" data-diaryNum="${randomDiary.diary_Num}" onclick="sendDiaryNum(this)">보기</button>
					</c:if>
				        <div>
				            <c:choose>
				                <c:when test="${not empty randomDiary}">
				                    <div class="d-flex align-items-center">
				                        <i class="bi bi-calendar3 me-2"></i>
				                        <span class="fw-bold">${randomDiary.reg_date_diary}</span>
				                    </div>
				                    <p class="mb-0">${randomDiary.subject}</p>
				                </c:when>
				                <c:otherwise>
				                    <div class="d-flex align-items-center">
				                        <i class="bi bi-calendar3 me-2"></i>
				                        <span class="fw-bold">작성한 일기가 없으세요</span>
				                    </div>
				                    <p class="mb-0">일기를 써보시는건 어떨까요?</p>
				                </c:otherwise>
				            </c:choose>
				        </div>
				    </div>
				</div>
				
				<div class="mb-4">
				    <h3>감정들</h3>
				    <ul class="list-group d-flex flex-row list-group-item rounded">
				        <c:choose>
				            <c:when test="${empty emojiList}">
				                <li class="list-group-item d-flex align-items-center">
				                    <i class="bi bi-emoji-neutral me-2"></i>
				                    <span>기록된 감정이 없습니다.</span>
				                </li>
				            </c:when>
				            <c:otherwise>
				                <c:forEach var="entry" items="${emojiList}">
				                    <li class="list-group-item d-flex align-items-center rounded" style="border: 1px dotted black;">
				                        <i class="bi ${entry.key}"></i>
				                    </li>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </ul>
				</div>
				
	             <div id="chartContainer" class="w-100 list-group-item container-fluid rounded" style="height: 36%;" >
	             <!-- 차트영역  -->
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
				<h5 class="modal-title" id="diaryFormLabel">일기작성</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-0 pb-0">
        		<form name="diaryForm" method="post">
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
								<input type="hidden" name="num" id="form-num"  value="0">
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
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</footer>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<script type="text/javascript">
$(function(){
	$("body").on("click", "#writeDiary", function(){
		// 폼 reset
		$("form[name=diaryForm]").each(function(){
			this.reset();
		});
		
		$("#diaryForm").modal("show");
	});
});

//등록완료버튼
$(function(){
	$("#btnDiarySendOk").click(function(){
		
		const f = document.querySelector('form[name=diaryForm]');
		
		if(! check()) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/log/diaryInsert";
		let query = $("form[name=diaryForm]").serialize();

		const fn = function(data){
            if (data.state === "false" && data.error) {
                alert(data.error);
                return;
            }
			let state = data.state;
			$("#diaryForm").modal("hide");
			location.href = "${pageContext.request.contextPath}/log/diary";
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

//모달창에 입력한 글자수를 실시간으로 출력
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

//새로이 모달창을 눌렀을 때 0자로 초기화
$(function() {
	$('#writeDiary').on('click', function() {
		$('.count').text('0자');
	})
})
//'data-thing' 을 보다 편하게 전달해주기 위한 방법(폼을 그때그때 생성해줌)
function sendDiaryNum(button) {
    const diaryNum = button.getAttribute('data-diaryNum');
    const f = document.createElement('form');
    f.method = 'post';
    
    
    const diaryNumInput = document.createElement('input');
    diaryNumInput.type = 'hidden';
    diaryNumInput.name = 'diaryNum';
    diaryNumInput.value = diaryNum;
    f.appendChild(diaryNumInput);
    
    const pageNumInput = document.createElement('input');
    pageNumInput.type = 'hidden';
    pageNumInput.name = 'pageNo';
    pageNumInput.value = '${pageNo}';
    f.appendChild(pageNumInput);
    
    document.body.appendChild(f);
    f.action = '${pageContext.request.contextPath}/log/viewDiary';
    f.submit();
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

   function deleteDiary(diaryNum, pageNo) {
	if(confirm("일기를 정말로 삭제하시겠어요?")){
		let url = "${pageContext.request.contextPath}/log/deleteDiary?diaryNum=" + diaryNum + "&pageNo=" + pageNo;
		location.href = url;	
	}
}
   
$(function() {
	let url = "${pageContext.request.contextPath}/log/diaryBar";

	$.getJSON(url, function(data) {
		
		if(! data.emojiValue){
			return;
		}
		
		var chartDom = document.getElementById('chartContainer');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  title: {
		    text: '감정그래프'
		  },
		  color: {
		    0: '#eee',
		    1: '#91cc75',
		    2: '#73c0de',
		    3: '#fac858',
		    4: '#ea7ccc',
		    5: '9a60b4',
		    6: '3ba272'
		  },
		  textStyle: {
		    fontSize: 16,
		    fontWeight: 'bold'
		  },
		  tooltip: {
			    trigger: 'axis'
		  },
		  xAxis: {
		    type: 'category',
		    data: data.emojiKey
		  },
		  yAxis: {
		    type: 'value'
		  },
		  series: [
			    {
			      data: data.emojiValue,
			      type: 'bar'
			    }
			  ]
		};

		option && myChart.setOption(option);
	
	});
	
});

</script>



</body>
</html>