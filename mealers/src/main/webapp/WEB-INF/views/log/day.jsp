<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="row mt-4">
	<div class="col-10 pe-2">
		<div class="row">
			<div class="col-3 text-start ps-0 pe-0 fw-bold">
				<span class="btn btn-sm" onclick="changeDate('${today}');">오늘</span>
			</div>
				<div class="row">
				<div class="col-6 text-center fw-bold">
					<span class="btn btn-sm ps-0 pe-0" onclick="changeDate('${preMonth}');"><i class="bi bi-chevron-left"></i></span>
					<span class="text-dark align-middle">${year}년 ${month}월</span>
					<span class="btn btn-sm ps-0 pe-0" onclick="changeDate('${nextMonth}');"><i class="bi bi-chevron-right"></i></span>
				</div>
			</div>
			<div class="col-2 text-end ps-0 pe-0">
				&nbsp;
			</div>
		</div>
		
		<div class="row">
			<table id="smallCalendar" class="table table-bordered">
				<tr class="text-center bg-light">
					<td class="xs-1 text-danger">일</td>
					<td class="xs-1">월</td>
					<td class="xs-1">화</td>
					<td class="xs-1">수</td>
					<td class="xs-1">목</td>
					<td class="xs-1">금</td>
					<td class="xs-1 text-primary">토</td>
				</tr>
						   		
				<c:forEach var="row" items="${days}" >
					<tr>
						<c:forEach var="d" items="${row}">
							<td class="text-center} ">
								${d}
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>			       
		</div>
		
	</div>
	
	<div class="row pe-2">
		<div class="row" style="width: ">
			<div class="col fw-bold form-control-plaintext">
				<span><i class="bi bi-calendar2-date"></i> ${year}년 ${month}월 ${day}일의 일정</span>
			</div>
		</div>
		
		<div class="row">
			<c:if test="${empty dto}">
				<p class="form-control-plaintext text-center">등록된 일정이 없습니다.</p>
			</c:if>
			
			<c:if test="${not empty dto}">
				<table class="table table-border date-schedule">
					<tr style="border-top: 2px solid #212529;">
						<td class="col-2 table-light">제목</td>
						<td>${dto.title}</td>
					</tr>
					<tr>
						<td class="col-2 table-light">날짜</td>
						<td>
			        		<fmt:parseDate value="${dto.reg_date_event}" var="parsedRegDate" pattern="yyyy-MM-dd HH:mm:ss" />
        					<fmt:formatDate value="${parsedRegDate}" pattern="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
					    <td class="col-2 table-light">일정</td>
					    <td>
					        <c:choose>
					            <c:when test="${empty dto.event_start_time}">
					                하루종일
					            </c:when>
					            <c:otherwise>
					                (${dto.event_start_time} - ${dto.event_end_time})
					            </c:otherwise>
					        </c:choose>
					    </td>
					</tr>
					<tr>
						<td class="col-2 table-light">등록일시</td>
						<td>${dto.reg_date_event}</td>
					</tr>
					<tr>
						<td class="col-2 table-light">메모</td>
						<td>
							<span style="white-space: pre;">${dto.memo}</span>
						</td>
					</tr>
					<tr>
						<td class="text-end" colspan="2" style="border-bottom: none;">
							<button type="button" id="btnUpdate" class="btn btn-light" data-date="${date}" data-num="${dto.event_num}">수정</button>
							<button type="button" id="btnDelete" class="btn btn-light" data-date="${date}" data-num="${dto.event_num}">삭제</button>
							
							<input type="hidden" name="title" value="${dto.title}">
							<input type="hidden" name="color" value="${dto.color}">
							<input type="hidden" name="allDay" value="${empty dto.event_start_time ? '1' : '0'}">
							<input type="hidden" name="event_date" value="${dto.event_date}">
							<input type="hidden" name="event_start_time" value="${dto.event_start_time}">
							<input type="hidden" name="event_end_time" value="${dto.event_end_time}">
							<input type="hidden" name="memo" value="${dto.memo}">
						</td>
					</tr>
				</table>
			</c:if>
			
			<c:if test="${list.size() > 1}">
				<div class="row mb-1">
					<div class="col fw-bold form-control-plaintext">
						<span><i class="bi bi-calendar2-date"></i> 다른 일정</span>
					</div>
				</div>
				
				<table class="table table-border">
					<thead>
						<tr class="text-center table-light"> 
							<th class="col-2">분류</th>
							<th>제목</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="vo" items="${list}">
			<c:if test="${dto.event_num != vo.event_num}">
			    <tr>
			        <td class="text-center">
			            ${empty vo.event_start_time ? "종일일정" : "시간일정"}
			        </td>
			        <td>
			            <div class="daySubject" data-date="${date}" data-num="${vo.event_num}">
			                ${vo.title}
			            </div>
			        </td>
			    </tr>
			</c:if>
						</c:forEach>
					</tbody>
				</table>
			
			</c:if>
		</div>		
		
	</div>
</div>