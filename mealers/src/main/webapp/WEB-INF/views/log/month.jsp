<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style type="text/css">
.calendar-day {
    width: 120px;
    height: 120px;
    text-align: center;
    vertical-align: middle;
    line-height: 120px;
    cursor: pointer;
}
.calendar-day:hover {
    background-color: #f0f0f0;
}
.highlight {
    background-color: #a0e7a0;
}
.textDate {
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease, border-radius 0.3s ease;
}
.textDate:hover {
    background-color: #d4edda;
    color: #155724;
    border-radius: 10px;
}
</style>

<div class="row mt-4 mb-3 container-fluid">
	<div class="col text-start">
		&nbsp;
	</div>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<span class="btn h2" onclick="changeMonth(${year}, ${month-1});"><i class="bi bi-chevron-left"></i></span>
		<span class="text-dark align-middle h3">${year}년 ${month}월</span>
		<span class="btn h2" onclick="changeMonth(${year}, ${month+1});"><i class="bi bi-chevron-right"></i></span>
	</div>
	<div class="col fs-6 text-end d-flex align-items-center">
		<button id="addEventBtn" class="btn me-auto btn-success">일정등록</button>
		<span class="btn btn-success" onclick="changeMonth(${todayYear}, ${todayMonth});">오늘</span>
	</div>
</div>

<table id="largeCalendar" class="table table-bordered">
	<tr class="text-center table table-bordered">
		<td class="text-danger" width="100">일</td>
		<td width="100" scope="col">월</td>
		<td width="100" scope="col">화</td>
		<td width="100" scope="col">수</td>
		<td width="100" scope="col">목</td>
		<td width="100" scope="col">금</td>
		<td class="text-primary" width="100">토</td>
	</tr>
	
	<c:forEach var="row" items="${days}" >
		<tr align="left" height="80" valign="top">
			<c:forEach var="d" items="${row}">
				<td class="p-2">
					${d}
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
