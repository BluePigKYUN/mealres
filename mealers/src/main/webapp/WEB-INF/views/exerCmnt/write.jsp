<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<script src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>

<style type="text/css">
.contentForm .viewer {
	cursor: pointer;
	width: 600px;
	height: 350px;
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;

}

.viewer{
	display: flex;
	justify-content: center;
	align-items: center;
}

</style>   
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>
    
	<div class="container-fluid page-header-cmnt py-5 ">
		<h1 class="text-center text-white display-6">커뮤니티</h1>
	</div>

    <div class="container-fluid my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card bg-gradient-primary border border-secondary shadow rounded-lg">
                    <div class="card-body">
                        <h3 class="card-title py-3 ps-4"> 운동 커뮤니티 </h3>
                       
                        <form name="CmntForm" method="post" enctype="multipart/form-data">
                        	<div class="contentForm">
	                        	<div class="form-group mt-3 mb-5 d-flex justify-content-center">
	                        		<div class="viewer rounded form-control" style="text-decoration: underline">사진 추가</div>
	                                <input type="file" name="photoSelect" id="photoSelect" accept="image/*" class="form-control" style="display: none;">    		
	                            </div>

		                        <div class="form-group mb-3 mx-5" >
		                            <label for="subject" class="form-label">제목</label>
		                            <input type="text" name="subject" id="subject" class="form-control" value="${dto.subject}" required>
		                        </div>
		                        
		                        <div class="form-group mb-3 mx-5">
		                            <label for="content" class="form-label">내용</label>		                            
		                            <textarea name="content" id="content" class="form-control" rows="8" required>${dto.content}</textarea>
		                        </div>
 
		                        <div class="mt-4 mb-3 me-5" style="text-align: right">
		                            <button type="button" class="btn btn-light bg-secondary text-white " onclick="submitContents();">
		                                ${mode=='update'?'완료':'등록'}
		                            </button>
		                            <button type="button" class="btn border border-secondary ms-2" onclick="location.href='${pageContext.request.contextPath}/exerCmnt/list';">
		                                취소
		                            </button>
		                            
		                            <c:if test="${mode=='update'}">
		                                <input type="hidden" name="num" value="${dto.num}">
		                                <input type="hidden" name="page" value="${page}">
		                                <input type="hidden" name="exerSort" value="${exerSort}">
		                                <input type="hidden" name="fileName" value="${dto.fileName}">
		                            </c:if>
		                        </div>
                            </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fas fa-arrow-up"></i></a>
   
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	    <jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
    </footer>
    <script type="text/javascript">
		$(function() {
			let file = "${dto.fileName}";
			
			if(file) {
				file = "${pageContext.request.contextPath}/uploads/exerCmnt/" + file;
				$(".contentForm .viewer").empty();
				$(".contentForm .viewer").css("background-image","url("+file+")");
			}
			
			$(".contentForm .viewer").click(function() {
				$("form[name=CmntForm] input[name=photoSelect]").trigger("click");
			});
			
			$("form[name=CmntForm] input[name=photoSelect]").change(function() {
				let image = this.files[0];
				
				if(! image) {
					$(".contentForm .viewer").empty();
					if(file) {
				        file = "${pageContext.request.contextPath}/uploads/exerCmnt/" + file;
				        $(".contentForm .viewer").css("background-image", "url(" + file + ")");
				    } 
					return false;
				}
				
				let reader = new FileReader();
				reader.onload = function(e) {
					$(".contentForm .viewer").empty();
					$(".contentForm .viewer").css("background-image", "url("+e.target.result+")");
				}
				reader.readAsDataURL(image);
			});
		});
		
		function submitContents() {
			const form = document.CmntForm;
			let con;
			
			cont = form.subject.value.trim();
			if(! cont) {
				form.subject.focus();
				return;
			}
			
			cont = form.content.value.trim();
			if(! cont) {
				form.content.focus();
				return;
			}
			
			form.action = "${pageContext.request.contextPath}/exerCmnt/${mode}";
			form.submit();
			
		}
	</script>
</body>
</html>