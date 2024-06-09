<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일정관리</title>
<style type="text/css">
.nav-item {
    list-style-type: none;
}

.deco {
  width: 50px;
  height: 50px;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background-color: transparent;
  border: none;
}
.deco::-webkit-color-swatch {
  border-radius: 30px;
  border: none;
}

.eventTitle, .daySubject{
	cursor: pointer;
}


</style>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

	<div class="container-fluid py-3">
		<div class="container py-2 my-3">
			<div class="row">
			
				<div class="col-md-7">

					<h2>일정관리</h2>
					<div class="calendar bg-white rounded shadow-sm px-5 py-3">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<div class="tab-content" id="nav-tabContent">
								<div class="tab-pane fade show active" id="nav-1"
									role="tabpanel" aria-labelledby="nav-tab-1"></div>
								<div class="tab-pane fade" id="nav-2" role="tabpanel"
									aria-labelledby="nav-tab-2"></div>
								<div class="tab-pane fade" id="nav-3" role="tabpanel"
									aria-labelledby="nav-tab-2"></div>
							</div>
						</div>
					</div>

				</div>
				<!--    -->
				<div class="col-md-4">
					<h3>오늘일정</h3>
					<span>${totoday}</span><br><br>
					<div id="todaysEvent">
					
					</div>

					<div class="list-group my-3">
						<ul class="list-group d-flex flex-row" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="mx-3 active btn btn-success" id="tab-1"
									data-bs-toggle="tab" data-bs-target="#nav-1" type="button"
									role="tab" aria-controls="1" aria-selected="true">월별일정</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="btn btn-success" id="tab-2" data-bs-toggle="tab"
									data-bs-target="#nav-2" type="button" role="tab"
									aria-controls="2" aria-selected="true">상세일정</button>
							</li>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
	</div>

<!-- Event Modal Start -->
<div class="modal fade container-fluid" id="eventModal"
		data-bs-backdrop="static" data-bs-keyboard="false" 
		tabindex="-1" aria-labelledby="ieventModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content col-4">
			<div class="modal-header">
				<h5 class="modal-title" id="eventModalLabel">일정 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-0 pb-0">
				<small class="form-control-plaintext help-block" style="align-content: center;">
					모든 요소들은 필수입니다.
				</small>
        		<form name="scheduleForm">
        			<table class="table">
						<tr>
							<td class="col-2">일정제목</td>
							<td>
								<input type="text" name="subject" id="form-subject" class="form-control">
							</td>
						</tr>
						
						<tr>
							<td class="col-2">배경색</td>
							<td>
								<input type="color" name="bgColor" id="form-color" class="form-control deco">
							</td>
						</tr>
						
						<tr>
							<td class="col-2">종일일정</td>
							<td>
	                            <div class="form-check form-control-plaintext d-flex">
	                                <input class="form-check-input" type="checkbox" name="allDay" id="form-allDay" value="1">
	                                <label class="form-check-label px-3" for="form-allDay">하루종일</label>
	                            </div>
							</td>
						</tr>

						<tr>
							<td class="col-2">일정등록</td>
							<td>
								<div class="row">
									<div class="col col-sm-4 pe-1">
										<input type="date" name="sday" id="form-sday" class="form-control" style="min-width: 150px;">
										<small class="form-control-plaintext help-block text-start">
											* 날짜는 필수입니다.
										</small>
									</div>
									<div class="row">
										<div class="col col-sm-3">
											<input type="time" name="stime" id="form-stime" class="form-control" style="display: none; min-width: 150px;">
											<small class="form-control-plaintext help-block text-start" id="stime_Son">
												시작 시간을 기재해주세요.
											</small>
										</div>
									</div>
									<div class="row">
										<div class="col col-sm-3">
											<input type="time" name="etime" id="form-etime" class="form-control" style="display: none; min-width: 150px;">
											<small class="form-control-plaintext help-block text-start" id="etime_Son">
												종료 시간을 기재해주세요.
											</small>
										</div>
									</div>
								</div>
							</td>
						</tr>

						<tr>
							<td class="col-2">메 모</td>
							<td>
								<textarea name="memo" id="form-memo" class="form-control" style="height: 70px; resize: none;"></textarea>
							</td>
						</tr>
						
						<tr>
							<td colspan="3" class="text-center" style="border-bottom: none;">
								<input type="hidden" name="num"id="form-num"  value="0">
								<button type="button" class="btn btn-dark" id="btnEventSendOk"> 등록 완료 </button>
								<button type="button" class="btn btn-light" id="btnEventSendCancel"> 등록 취소 </button>
							</td>
						</tr>
						
        			</table>
        		</form>
			</div>
		</div>
	</div>
</div>
<!-- Event Modal End -->


<footer>
   	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>

<script type="text/javascript">
function schedule(url, query, selector) {
	const fn = function(data){
		$(selector).html(data);
		today();
	};
	
	ajaxFun(url, "get", query, "text", fn);	
}

$(function(){
    let url = "${pageContext.request.contextPath}/log/month";
    let query = "";
    
    schedule(url, query, "#nav-1");
});

$(function(){
    // 탭을 클릭할 때 마다
    $("button[role='tab']").on("click", function(e){
		let tab = $(this).attr("aria-controls");
        let selector = "#nav-"+tab;
        
        let url;
        if(tab === "1") {
            url = "${pageContext.request.contextPath}/log/month";
        } else if(tab === "2") {
            url = "${pageContext.request.contextPath}/log/day";
        }

        let query = "";
        schedule(url, query, selector);
    });
    
    // 탭이 변경 될때 마다
    $("button[role='tab']").on("shown.bs.tab", function(e){
		// let tab = $(this).attr("aria-controls");
        // let selector = "#nav-"+tab;
		//today();
    });
    
});

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

function today() {
	let date = "${today}";
	$(".textDate").each(function (i) {
        let s = $(this).attr("data-date");
        if(s === date) {
        	$(this).parent().css("background", "#EEF9E8");
        }
    });
}

// 월별 - 월을 변경하는 경우
function changeMonth(year, month) {
	let url = "${pageContext.request.contextPath}/log/month";
	let query = "year="+year+"&month="+month;
	
	schedule(url, query, "#nav-1");
}

// 상세 - 날짜를 변경하는 경우
function changeDate(date) {
	let url = "${pageContext.request.contextPath}/log/day";
	let query = "date="+date;
	
	schedule(url, query, "#nav-2");
}

// 월별 - 일정 제목을 클릭한 경우
$(function(){
	$("body").on("click", ".scheduleSubject", function(){
		let date = $(this).attr("data-date");
		let num = $(this).attr("data-num");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "date="+date+"&num="+num;
		
		const tabEl = document.querySelector('#myTab #tab-2');
		const tab = new bootstrap.Tab(tabEl);
		tab.show();
		
		schedule(url, query, "#nav-2");
	});
});

// 월별 - more(더보기) 를 클릭 한 경우
$(function(){
	$("body").on("click", ".scheduleMore", function(){
		let date = $(this).attr("data-date");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "date="+date;
		
		const tabEl = document.querySelector('#myTab #tab-2');
		const tab = new bootstrap.Tab(tabEl);
		tab.show();

		schedule(url, query, "#nav-2");
	});
});

// 월별 - 날짜를 클릭한 경우 : 일정 등록
$(function(){
    // 날짜를 클릭한 경우의 이벤트 핸들러
	$("body").on("click", "#largeCalendar .textDate", function(){
		resetAndShowModal($(this).attr("data-date"));
	});
	
	// 일정 등록 버튼에 기능부여
	$("body").on("click", "#addEventBtn", function(){
		let today = new Date();
		let year = today.getFullYear();
		let month = ("0" + (today.getMonth() + 1)).slice(-2);
		let day = ("0" + today.getDate()).slice(-2);
		let date = year + "" + month + "" + day;
		resetAndShowModal(date);
	});

    // 모달 초기화 및 표시 함수
	function resetAndShowModal(date) {
		// 폼 reset
		$("form[name=scheduleForm]").each(function(){
			this.reset();
		});
		
		disableKeyInput("#form-sday");
		disableKeyInput("#form-stime");
		disableKeyInput("#form-etime");
		
		$("#form-allDay").prop("checked", true);
		$("#form-allDay").removeAttr("disabled");
		$("#form-stime").hide();
		$("#form-etime").hide();
		$("#stime_Son").hide();
		$("#etime_Son").hide();
		$("#form-eday").closest("tr").show();
		
		date = date.substr(0,4) + "-" + date.substr(4,2) + "-" + date.substr(6,2);

		$("form[name=scheduleForm] input[name=sday]").val(date);
		$("form[name=scheduleForm] input[name=eday]").val(date);
		
		$("#eventModalLabel").html("일정 등록");
		$("#btnEventSendOk").attr("data-mode", "insert");
		$("#btnEventSendOk").html(" 등록 완료 ");
		$("#btnEventSendCancel").html(" 등록 취소 ");
		
		$("#eventModal").modal("show");
	}
});

//키 입력 막기
function disableKeyInput(selector) {
    $(selector).on("keydown", function(e) {
        e.preventDefault();
    });
}

// 상세일정 - 날짜 클릭
$(function(){
	$("body").on("click", "#smallCalendar .textDate", function(){
		let date = $(this).attr("data-date");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "date="+date;
		
		schedule(url, query, "#nav-2");
	});
});

// 상세일정 - 다른일정 제목 클릭
$(function(){
	$("body").on("click", ".daySubject", function(){
		let date = $(this).attr("data-date");
		let num = $(this).attr("data-num");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "date="+date+"&num="+num;
		
		schedule(url, query, "#nav-2");
	});
});

//상세일정 - 수정
$(function(){
	$("body").on("click", "#btnUpdate", function(){
		let date = $(this).attr("data-date");
		let num = $(this).attr("data-num");

		let subject = $("input[name=title]").val();
		let color = $("input[name=color]").val();
		let allDay = $("input[name=allDay]").val();
		let eventDateTime = $("input[name=event_date]").val();
		let stime = $("input[name=event_start_time]").val();
		let etime = $("input[name=event_end_time]").val();
		let memo = $("input[name=memo]").val();

		// eday는 시작일과 동일하게 설정
		let sday = eventDateTime.split(' ')[0]; // yyyy-mm-dd
		let eday = sday;
		
		disableKeyInput("#form-sday");
		disableKeyInput("#form-stime");
		disableKeyInput("#form-etime");

		// 폼에 데이터 채우기
		$("#form-num").val(num);
		$("#form-subject").val(subject);
		$("#form-color").val(color);
		if (allDay === "1") {
			$("#form-allDay").prop("checked", true);
		} else {
			$("#form-allDay").prop("checked", false);
		}
		$("#form-sday").val(sday);
		$("#form-stime").val(stime);
		$("#form-eday").val(eday);
		$("#form-etime").val(etime);
		if (stime) {
			$("#form-stime").show();
			$("#form-etime").show();
			$("#stime_Son").show();
			$("#etime_Son").show();
		} else {
			$("#form-stime").hide();
			$("#form-etime").hide();
			$("#stime_Son").hide();
			$("#etime_Son").hide();
		}
		$("#form-memo").val(memo);

		$("#eventModalLabel").html("일정 수정");
		$("#btnEventSendOk").attr("data-mode", "update");
		$("#btnEventSendOk").attr("data-num", num);
		$("#btnEventSendOk").attr("data-date", date);

		$("#btnEventSendOk").html(" 수정 완료 ");
		$("#btnEventSendCancel").html(" 수정 취소 ");

		$("#eventModal").modal("show");
	});
});

// 상세일정 - 삭제 버튼
$(function(){
	$("body").on("click", "#btnDelete", function(){
		if(! confirm("일정을 삭제 하시겠습니까 ? ")) {
			return false;
		}
		
		let date = $(this).attr("data-date");
		let num = $(this).attr("data-num");
		let url = "${pageContext.request.contextPath}/log/delete";
		let query = "num="+num;
		
		const fn = function(data) {
			if(data.state === "true") {
				let url = "${pageContext.request.contextPath}/log/day";
				let query = "date="+date;
				schedule(url, query, "#nav-2");
				loadTodaysEvents();
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//오늘 일정 불러와주는 기능
$(function() {
	loadTodaysEvents();
})

function loadTodaysEvents() {
	let url = "${pageContext.request.contextPath}/log/todaysEvent";
	let selector = "#todaysEvent";
	let query;

	const fn = function(data) {
		$(selector).html(data);
	};

	ajaxFun(url, "get", query, "text", fn);
}

//월별 - 일정 제목을 클릭한 경우
$(function(){
	$("body").on("click", ".eventTitle", function(){
		let num = $(this).attr("data-num");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "num=" + num;
		
		const tabEl = document.querySelector('#myTab #tab-2');
		const tab = new bootstrap.Tab(tabEl);
		tab.show();
		
		schedule(url, query, "#nav-2");
	});
});

// 년도 - 날짜 클릭
$(function(){
	$("body").on("click", "#yearCalendar .textDate", function(){
		let date = $(this).attr("data-date");
		let url = "${pageContext.request.contextPath}/log/day"
		let query = "date="+date;
		
		const tabEl = document.querySelector('#myTab #tab-2');
		const tab = new bootstrap.Tab(tabEl);
		tab.show();
		
		schedule(url, query, "#nav-2");
	});
});

// 등록/수정 대화상자 - 등록완료 버튼
$(function(){
	$("#btnEventSendOk").click(function(){
		if(! check()) {
			return false;
		}
		
		let mode = $("#btnEventSendOk").attr("data-mode");
		let query = $("form[name=scheduleForm]").serialize();
		let url = "${pageContext.request.contextPath}/log/"+mode+"";

		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if(mode === "insert") {
					let dd = $("#form-sday").val().split("-");
					let y = dd[0];
					let m = dd[1];
					if(m.substr(0,1) === "0") m = m.substr(1,1);
				
				    let url = "${pageContext.request.contextPath}/log/month";
				    let query = "year="+y+"&month="+m;
				    schedule(url, query, "#nav-1");
				} else if(mode === "update") {
					let num = $("#btnEventSendOk").attr("data-num");
					let date = $("#btnEventSendOk").attr("data-date");
					
					let url = "${pageContext.request.contextPath}/log/day"
					let query = "date="+date+"&num="+num;
						
					schedule(url, query, "#nav-2");
				}
				
				loadTodaysEvents();
			}
			
			$("#eventModal").modal("hide");
			
		};
		
		ajaxFun(url, "post", query, "json", fn);		
	});
});

// 등록/수정 대화상자 - 취소 버튼
$(function(){
	$("#btnEventSendCancel").click(function(){
		$("#eventModal").modal("hide");
	});
});

$(function(){
	$("body").on("click", "#form-allDay", function(){
		
		if(this.checked) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
			$("#stime_Son").hide();
			$("#etime_Son").hide();
		} else if(this.checked === false){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
			$("#stime_Son").show();
			$("#etime_Son").show();
		}
	});

	$("body").on("change", "#form-sday", function(){
		$("#form-eday").val($("#form-sday").val());
	});

	$("body").on("change", "#form-repeat", function(){
		if($(this).val() === "0") {
			$("#form-repeat_cycle").val("").hide();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").removeAttr("disabled");
			
			$("#form-eday").val($("#form-sday").val());
			$("#form-eday").closest("tr").show();
		} else {
			$("#form-repeat_cycle").show();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").attr("disabled","disabled");

			$("#form-stime").val("").hide();
			$("#form-eday").val("");
			$("#form-etime").val("");
			$("#form-eday").closest("tr").hide();
		}
	});
});

// 등록내용 유효성 검사
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}

	if(! $("#form-sday").val()) {
		$("#form-sday").focus();
		return false;
	}

	if($("#form-etime").val()) {
		let s1 = $("#form-stime").val().replace(":", "");
		let s2 = $("#form-etime").val().replace(":", "");
		if(s1 > s2) {
			$("#form-stime").focus();
			return false;
		}
	}	
	
	
	return true;
}

</script>

</body>
</html>