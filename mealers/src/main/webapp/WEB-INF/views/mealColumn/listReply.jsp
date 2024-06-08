<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>
    .deleteReply {
        cursor: pointer;
    }
    
    .deleteReply:hover {
        text-decoration: underline;
        color: red;
    }
    
    .pagination {
    display: flex;
    justify-content: center;
    list-style: none;
    padding: 0;
	}

	.pagination .page-item {
	    margin: 0 5px;
	}
	
	.pagination .page-link {
	    color: var(--bs-dark);
	    text-decoration: none;
	    padding: 10px 16px;
	    transition: 0.5s;
	}
	
	.pagination .page-item.active .page-link {
	border-radius: 50%;
	    color: var(--bs-white);
	}
	
	.pagination .page-item.disabled .page-link {
	 border-radius: 50%;
	    /* color: var(--bs-secondary); */
	    cursor: not-allowed;
	}
	    
    
    
</style>

<div class='my-3 py-3 border-bottom reply-info'>
	<span class='text-primary reply-count'>댓글 ${replyCount}개&nbsp</span>
	<span>[ 목록 | ${pageNo}/${total_page} 페이지 ]</span>
</div>

<table class='table table-borderless reply-list'>
	<c:forEach var="dto" items="${listReply}">
		<tr class='border list-header' style="background: #F9F9F9">
			<td class="p-2 text-start" width='50%'>
				<span class='px-2 bold font-weight-bold'>
					<strong>
							<c:choose>
								<c:when test="${dto.userNum == 1}">
									${dto.mem_Nick} 👑
								</c:when>
								<c:otherwise>
									${dto.mem_Nick}
								</c:otherwise>
							</c:choose>
					</strong>
				</span>
			</td>
			<td class="px-2 p-2 text-end" width='50%' align='right'>
				<span>${dto.reg_date}</span> |
				
				<c:choose>
					<c:when test="${sessionScope.member.userNum==dto.userNum || sessionScope.member.userNum == '1'}">
						<span class='deleteReply' data-replyNum='${dto.replyNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class='notifyReply'>신고</span>
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr>
			<td class="px-3 py-3 pb-5 text-start" colspan='2' valign='top'>${dto.content}</td>
		</tr>

	</c:forEach>
</table>

<div class="page-navigation">
	${paging}
</div>	
						
