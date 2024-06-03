<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mealers</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.tblack {
	color: black;
}

canvas {
  width: 100% !important;
  height: 100% !important;
}
</style>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>

</head>

<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

	<!-- 음식 사진 배너 -->
	<div class="container-fluid page-header py-5">
	    <h1 class="text-center text-white display-6">식품영양성분</h1>
	</div>
	
	<div class="container-fluid mt-5">
		<div class="container">
			<div class="row mb-5">
	                    <div class="col-lg-8">
	                        <h1 class="fw-bold mb-3">${dto.food_name}</h1>
	                        <h5 class="mb-3">제조사: ${dto.maker}</h5>
	                        <hr>
	                        <div class="row d-flex justify-content-around p-3 my-3 mx-1" style="background: #eee;">
	                        	<h5>총 영양 요약</h5>
	                        	<div class="col-2" style="border: 3px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">칼로리</div>
	                        		<div class="text-center">${dto.kcal}kcal</div>
	                        	</div>
	                        	<div class="col-2" style="border: 3px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">탄수화물</div>
	                        		<div class="text-center">${dto.tansoo}g</div>
	                        	</div>
	                        	<div class="col-2" style="border: 3px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">단백질</div>
	                        		<div class="text-center">${dto.protein}g</div>
	                        	</div>
	                        	<div class="col-2" style="border: 3px solid lightgray; background: white;">
	                        		<div class="text-center fw-bold">지방</div>
	                        		<div class="text-center">${dto.fat}g</div>
	                        	</div>
	                        </div>
	                        <hr>

	                        <div class="d-flex gap-3">
    							<h2>탄단지 비율</h2>
	    						<div id="pieContainer" style="height: 400px; width: 400px;"></div>
							</div>
							<hr>
							
							<div class="mb-5">
								<div class="d-flex justify-content-between">
									<h2>사진</h2>
									<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">등록하기</button>
									<!-- Modal -->
									<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">
												<div class="modal-header">
													<h1 class="modal-title fs-5" id="exampleModalLabel">음식사진 등록하기</h1>
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													<p>※사진 선택시 사진 눌러서 삭제 가능※</p>
													<form name="photoForm" method="post" enctype="multipart/form-data">
														<div class="img-grid">
														</div>
														<input type="file" name="selectFile" accept="image/*" class="form-control">
													</form>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
													<button type="button" class="btn btn-primary">등록</button>
												</div>
											</div>
										</div>
									</div>
								</div>
		                        <div class="row d-flex justify-content-around p-3 my-3 mx-1" style="background: #eee;">
		                        	<div class="col-2 col-sm-1 p-0" style="height: 120px; width: 120px; background: lightgray;">
		                        	</div>
		                        	<div class="col-2 col-sm-1 p-0" style="height: 120px; width: 120px; background: lightgray;">
		                        	</div>
		                        	<div class="col-2 col-sm-1 p-0" style="height: 120px; width: 120px; background: lightgray;">
		                        	</div>
		                        	<div class="col-2 col-sm-1 p-0" style="height: 120px; width: 120px; background: lightgray;">
		                        	</div>
		                        </div>
							</div>
	                        <a href="#" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
	                    </div>
	                    
	                    <div class="col-lg-4">
	                        <form class="position-relative mx-auto" name="searchForm" action="${pageContext.request.contextPath}/search/main" method="post">
	                            <input name="kwd" value="${kwd}" class="form-control border-2 border-secondary py-3 px-4 rounded-pill" type="text" placeholder="음식 이름 검색">
	                            <button type="button" onclick="searchList()" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 0%;">검색하기</button>
	                        </form>
	                        <div  class="p-3 my-4" style="border: solid 5px #eee;">
	                        	<h4>영양 정보</h4>
	                        	<hr class="mt-3">
	                        	<span class="tblack">총 중량</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.weight}</span>
	                        	<br>
	                        	<span class="tblack">영양성분함량단위</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.serving_size}</span>
	                        	<hr style="height: 10px;">
	                        	<span class="float-end tblack">영양성분함량단위 당</span>
	                        	<br>
	                        	<hr class="mt-2" style="height: 4px; background-color: black;">
	                        	<span class="tblack">칼로리</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.kcal}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">탄수화물</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.tansoo}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">단백질</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.protein}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">지방</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.fat}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">당류</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.sugar}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">포화지방</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.pohwa}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">불포화지방</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.bulpohwa}g</span>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<c:choose>
	                        		<c:when test="${dto.salt == null}">
			                        	<span class="tblack">나트륨</span>
			                        	<span class="float-end tblack fw-bold">정보없음</span>
	                        		</c:when>
	                        		<c:otherwise>
			                        	<span class="tblack">나트륨</span>
			                        	<span class="float-end tblack fw-bold">${dto.salt}</span>
	                        		</c:otherwise>
	                        	</c:choose>
	                        	<c:if test="${dto.salt == null}">
	                        	</c:if>
	                        	<hr class="mt-2" style="height: 3px;">
	                        	<span class="tblack">콜레스테롤</span>
	                        	<span class="float-end tblack fw-bold"> ${dto.chole}mg</span>
	                        	<hr class="mt-2" style="height: 4px; background-color: black;">
	                        	
	                        	
	                        	
	                        	<div class="mt-3"></div>
	                        </div>
	                    </div>
			</div>
		</div>
	</div>
</body>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
	
	<script type="text/javascript">
		
		$(function(){
			var sel_files = [];
			
			
			$("body").on("click", ".modal-body .form-control", function(event){
				$("form[name=photoForm] input[name=selectFile]").trigger("click"); 
			});
			
			$("form[name=photoForm] input[name=selectFile]").change(function(){
				if(! this.files) {
					let dt = new DataTransfer();
					for(let file of sel_files) {
						dt.items.add(file);
					}
					document.photoForm.selectFile.files = dt.files;
					
			    	return false;
			    }
				
		        for(let file of this.files) {
		        	sel_files.push(file);
		        	
		            const reader = new FileReader();
					const $img = $("<img>", {class:"item img-item"});
					$img.attr("data-filename", file.name);
		            reader.onload = e => {
		            	$img.attr("src", e.target.result);
		            	$img.attr("style", "width:450px;");
		            	$img.attr("class", "mb-4");
		            	$img.attr("id", "img");
		            };
					reader.readAsDataURL(file);
		            
		            $(".img-grid").append($img);
		        }
				
				let dt = new DataTransfer();
				for(let file of sel_files) {
					dt.items.add(file);
				}
				document.photoForm.selectFile.files = dt.files;		
			    
			});
			
			$("body").on("click", "#img", function(event) {
				if(! confirm("선택한 파일을 삭제 하시겠습니까 ?")) {
					return false;
				}
				
				let filename = $(this).attr("data-filename");
				
			    for(let i = 0; i < sel_files.length; i++) {
			    	if(filename === sel_files[i].name){
			    		sel_files.splice(i, 1);
			    		break;
					}
			    }
			
				let dt = new DataTransfer();
				for(let file of sel_files) {
					dt.items.add(file);
				}
				document.photoForm.selectFile.files = dt.files;
				
				$(this).remove();
			});
		});
		
		$(function() {
			var chartDom = document.getElementById('pieContainer');
			var myChart = echarts.init(chartDom);
			var option;
	
			option = {
			  tooltip: {
			    trigger: 'item'
			  },
			  legend: {
			  },
			  dataset: [
			    {
			      source: [
			        { value: ${dto.tansoo}, name: '탄수화물' },
			        { value: ${dto.protein}, name: '단백질' },
			        { value: ${dto.fat}, name: '지방' },
			      ]
			    }
			  ],
			  series: [
			    {
			      type: 'pie',
			      radius: '50%'
			    },
			    {
			      name: ' ',
			      type: 'pie',
			      label: {
			        position: 'inside',
			        formatter: '{d}%',
			        color: 'black',
			        fontSize: 18
			      },
			      percentPrecision: 0,
			      emphasis: {
			        label: { show: true },
			        itemStyle: {
			          shadowBlur: 10,
			          shadowOffsetX: 0,
			          shadowColor: 'rgba(0, 0, 0, 0.5)'
			        }
			      }
			    }
			  ]
			};

			option && myChart.setOption(option);
		});
		
	</script>
</footer>
</html>