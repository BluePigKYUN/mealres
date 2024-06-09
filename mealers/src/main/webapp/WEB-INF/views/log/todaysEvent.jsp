<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<ul class="list-group">
	<c:if test="${empty list}">
		<li	class="list-group-item d-flex justify-content-between align-items-center">
		등록된 일정이 없습니다.
	</c:if>
	<c:forEach var="dto" items="${list}">
	<li	class="eventTitle list-group-item d-flex justify-content-between align-items-center" data-num=${dto.event_num}>
		${dto.title} 
		<c:if test="${not empty dto.event_start_time }">
		<span class="badge bg-primary rounded-pill">
			${dto.event_start_time}-${dto.event_end_time}
		</span>
		</c:if>
		<c:if test="${empty dto.event_start_time}">
		<span class="badge bg-primary rounded-pill">
			하루일정
		</span>
		</c:if>
	</li>
	</c:forEach>
</ul>