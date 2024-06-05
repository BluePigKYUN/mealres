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
</style>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

	<div class="container-fluid py-3">
		<div class="container py-5 my-5">
			<div class="row">
				<div class="col-md-8">

					<h2>일정관리</h2>
					<div class="calendar bg-white rounded shadow-sm">
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

				<div class="col-md-4">
					<h3>오늘일정</h3>
					<ul class="list-group">
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							새벽 <span class="badge bg-primary rounded-pill">5:00-6:00</span>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							아침 <span class="badge bg-primary rounded-pill">8:00-9:00</span>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							점심 <span class="badge bg-primary rounded-pill">12:00-13:00</span>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							물품구매 <span class="badge bg-primary rounded-pill">15:00-16:00</span>
						</li>
						<li
							class="list-group-item d-flex justify-content-between align-items-center">
							퇴근시간 <span class="badge bg-primary rounded-pill">17:00-18:00</span>
						</li>
					</ul>


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

	<!-- Modal -->
    <div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정 등록</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="event/insert" method="post">
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="memo">메모</label>
                            <textarea class="form-control" id="memo" name="memo"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="color">색상</label>
                            <input type="color" class="form-control" id="color" name="color" required>
                        </div>
                        <div class="form-group">
                            <label for="regDateEvent">등록일</label>
                            <input type="date" class="form-control" id="regDateEvent" name="regDateEvent" required>
                        </div>
                        <div class="form-group">
                            <label for="eventDate">이벤트 날짜</label>
                            <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                        </div>
                        <div class="form-group">
                            <label for="eventStartTime">시작 시간</label>
                            <input type="time" class="form-control" id="eventStartTime" name="eventStartTime">
                        </div>
                        <div class="form-group">
                            <label for="eventEndTime">종료 시간</label>
                            <input type="time" class="form-control" id="eventEndTime" name="eventEndTime">
                        </div>
                        <div class="form-group">
                            <label for="userNum">사용자 번호</label>
                            <input type="number" class="form-control" id="userNum" name="userNum" required>
                        </div>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


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
        } else if(tab === "3") {
            url = "${pageContext.request.contextPath}/log/year";
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

// 년도 - 년도를 변경하는 경우
function changeYear(year) {
	let url = "${pageContext.request.contextPath}/log/year";
	let query = "year="+year;
	
	schedule(url, query, "#nav-3");
}

// 월별 - 스케쥴 제목을 클릭한 경우
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
	$("body").on("click", "#largeCalendar .textDate", function(){
		// 폼 reset
		$("form[name=scheduleForm]").each(function(){
			this.reset();
		});
		
		$("#form-repeat_cycle").hide();
		$("#form-allDay").prop("checked", true);
		$("#form-allDay").removeAttr("disabled");
		$("#form-stime").hide();
		$("#form-etime").hide();
		$("#form-eday").closest("tr").show();
		
		let date = $(this).attr("data-date");
		date = date.substr(0,4) + "-" + date.substr(4,2) + "-" + date.substr(6,2);

		$("form[name=scheduleForm] input[name=sday]").val(date);
		$("form[name=scheduleForm] input[name=eday]").val(date);
		
		$("#eventModalLabel").html("스케쥴 등록");
		$("#btnScheduleSendOk").attr("data-mode", "insert");
		$("#btnScheduleSendOk").html(" 등록 완료 ");
		$("#btnScheduleSendCancel").html(" 등록 취소 ");
		
		$("#eventModal").modal("show");
	});
});

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

// 상세일정 - 수정 버튼
$(function(){
	$("body").on("click", "#btnUpdate", function(){
		let date = $(this).attr("data-date");
		let num = $(this).attr("data-num");

		let subject = $(".date-schedule input[name=subject]").val();
		let color = $(".date-schedule input[name=color]").val();
		let allDay = $(".date-schedule input[name=allDay]").val();
		let sday = $(".date-schedule input[name=sday]").val();
		let stime = $(".date-schedule input[name=stime]").val();
		let eday = $(".date-schedule input[name=eday]").val();
		if(! eday ) eday = sday;
		let etime = $(".date-schedule input[name=etime]").val();
		let repeat = $(".date-schedule input[name=repeat]").val();
		let repeat_cycle = $(".date-schedule input[name=repeat_cycle]").val();
		let memo = $(".date-schedule input[name=memo]").val();
		
		$("#form-num").val(num);
		$("#form-subject").val(subject);
		$("#form-color").val(color);
		if(allDay === "1") {
			$("#form-allDay").prop("checked", true);
		} else {
			$("#form-allDay").prop("checked", false);
		}
		$("#form-sday").val(sday);
		$("#form-stime").val(stime);
		$("#form-eday").val(eday);
		$("#form-etime").val(etime);
		if(stime) {
			$("#form-stime").show();
			$("#form-etime").show()
		} else {
			$("#form-stime").hide();
			$("#form-etime").hide()
		}		
		$("#form-repeat").val(repeat);
		$("#form-repeat_cycle").val(repeat_cycle);
		if(repeat === "1") {
			$("#form-repeat_cycle").show();
			$("#form-eday").closest("tr").hide();
		} else {
			$("#form-repeat_cycle").val("");
			$("#form-repeat_cycle").hide();
			$("#form-eday").closest("tr").show();
		}		
		$("#form-memo").val(memo);
		
		$("#eventModalLabel").html("스케쥴 수정");
		$("#btnScheduleSendOk").attr("data-mode", "update");
		$("#btnScheduleSendOk").attr("data-num", num);
		$("#btnScheduleSendOk").attr("data-date", date);
		
		$("#btnScheduleSendOk").html(" 수정 완료 ");
		$("#btnScheduleSendCancel").html(" 수정 취소 ");
		
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
		let url = "${pageContext.request.contextPath}/schedule/delete";
		let query = "num="+num;
		
		const fn = function(data) {
			if(data.state === "true") {
				let url = "${pageContext.request.contextPath}/log/day";
				let query = "date="+date;
				schedule(url, query, "#nav-2");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
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
	$("#btnScheduleSendOk").click(function(){
		if(! check()) {
			return false;
		}
		
		let mode = $("#btnScheduleSendOk").attr("data-mode");
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
					let num = $("#btnScheduleSendOk").attr("data-num");
					let date = $("#btnScheduleSendOk").attr("data-date");
					
					let url = "${pageContext.request.contextPath}/log/day"
					let query = "date="+date+"&num="+num;
						
					schedule(url, query, "#nav-2");
				}
			}
			
			$("#eventModal").modal("hide");
			
		};
		
		ajaxFun(url, "post", query, "json", fn);		
	});
});

// 등록/수정 대화상자 - 취소 버튼
$(function(){
	$("#btnScheduleSendCancel").click(function(){
		$("#eventModal").modal("hide");
	});
});

$(function(){
	$("body").on("click", "#form-allDay", function(){
		
		if(this.checked) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
		} else if(this.checked === false && $("#form-repeat").val() === "0"){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
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

	if($("#form-eday").val()) {
		let s1 = $("#form-sday").val().replace("-", "");
		let s2 = $("#form-eday").val().replace("-", "");
		if(s1 > s2) {
			$("#form-sday").focus();
			return false;
		}
	}
	
	if($("#form-etime").val()) {
		let s1 = $("#form-stime").val().replace(":", "");
		let s2 = $("#form-etime").val().replace(":", "");
		if(s1 > s2) {
			$("#form-stime").focus();
			return false;
		}
	}	
	
	if($("#form-repeat").val() != "0" && ! /^(\d){1,2}$/g.test($("#form-repeat_cycle").val())) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	if($("#form-repeat").val() != "0" && $("#form-repeat_cycle").val()<1) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	return true;
}




</script>

</body>
</html>