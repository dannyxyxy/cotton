<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<!-- 데이터는 DispatcherServlet에 담겨있다(request) -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 리스트</title>
	
	<link rel="stylesheet" href="/resources/css/event/list.css">


<script type="text/javascript">
	$(function(){
		$(".promotion-card").click(function() {
		    let eno = $(this).data("eno");
		    console.log("eno =", eno);
		    if (eno) {
		        location = "view.do?eno=" + eno + "&${pageObject.pageQuery}&${goodsSearchVO.searchQuery}";
		    } else {
		        console.error("eno가 정의되지 않았습니다.");
		    }
		});
		
// 		$(".dataRow").click(function() {
// 			// tag에 적힌 data-eno="${vo.eno}"
// 			let eno = $(this).data("eno");
// 			//alert(eno);
// 			location = "view.do?eno=" + eno + "&inc=1"
// 				+ "&${pageObject.pageQuery}";
// 				// pageObject의 getPageQuery()를 가져와서
// 				// page, perPageNum, key, word를 붙인다.
// 		});
	
	    
		$("#perPageNum").change(function(){
			$("#searchForm").submit();
		});
		// 검색데이터 세팅
		$("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
		$("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
	
		
		$("#cate_code1").change(function(){
		    let cate_code1 = $(this).val();
		    $.ajax({
		        type: "get",
		        url: "/goods/getCategory.do?cate_code1=" + cate_code1,
		        dataType: "json", // JSON 형식의 데이터를 기대
		        success: function(result){
		            console.log(result);
		            let subCategorySelect = $("#cate_code2");
		            subCategorySelect.empty(); // 기존 옵션 제거
		            $.each(result, function(index, category){
		                subCategorySelect.append(
		                    $("<option></option>").attr("value", category.cate_code2).text(category.cate_name)
		                );
		            });
		        },
		        error: function(xhr, status, err){
		            console.log("중분류 가져오기 오류");
		            console.log("xhr : " + xhr);
		            console.log("status : " + status);
		            console.log("err : " + err);
		        }
		    });
		});
		
		
		//페이징처리버튼 JS
		const cardsPerPage = 6; // 페이지당 카드 수
	    let currentPage = 1; // 현재 페이지
	    const totalCards = $("div.promotion-card").length; // 전체 카드 수
	    const totalPages = Math.ceil(totalCards / cardsPerPage); // 전체 페이지 수
	    function showPage(page) {
	        // 모든 카드를 숨김
	        $("div.promotion-card").hide();
	        
	        // 현재 페이지 카드만 표시
	        $("div.promotion-card").slice((page - 1) * cardsPerPage, page * cardsPerPage).show();
	        
	        // 페이지 정보 업데이트
	        $("#pageInfo").text(`${page} / ${totalPages}`);
	        
	        // 이전 및 다음 버튼 상태 설정
	        $("#prevPage").prop("disabled", page === 1);
	        $("#nextPage").prop("disabled", page === totalPages);
	    }
	    // 페이지 로드 시 첫 페이지 표시
	    showPage(currentPage);
	    // 이전 페이지 버튼 클릭 시
	    $("#prevPage").click(function(e) {
	        e.preventDefault();
	        if (currentPage > 1) {
	            currentPage--;
	            showPage(currentPage);
	        }
	    });
	    // 다음 페이지 버튼 클릭 시
	    $("#nextPage").click(function(e) {
	        e.preventDefault();
	        if (currentPage < totalPages) {
	            currentPage++;
	            showPage(currentPage);
	        }
	    });
	  // end of 페이징처리버튼
	});	
</script>

</head>
<body>
	<div class="container p-3 my-3">
		<h2>진행중인 이벤트 및 프로모션</h2>
		<h5>현재 진행중인 이벤트 및 프로모션을 확인해보세요!</h5>
		<c:if test="${empty list }">
			<h4>데이터가 존재하지 않습니다.</h4>
		</c:if>
		<c:if test="${!empty list }">
	        <div class="dataRow row">
	            <c:forEach var="vo" items="${list}">
	                <div class="col-md-4 promotion-card" data-eno="${vo.eno }">
	                    <div class="card">
	                        <img src="${vo.imageName}" class="card-img-top" alt="${vo.imageName}">
	                        <div class="card-body">
	                            <h5 class="card-title">${vo.title}</h5>
	                            <p class="card-text">${vo.content}</p>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	        </div>
				<!-- 이미지 데이터 반복 표시 끝 -->
			<!-- 페이지 내비게이션 -->
		    <div class="pageNav" id="pagination">
		        <a href="#" class="btn" id="prevPage"><i class="fa fa-angle-left"></i></a>
		        <span id="pageInfo"></span>
		        <a href="#" class="btn" id="nextPage"><i class="fa fa-angle-right"></i></a>
		    </div>
		</c:if>
		<!-- 데이터 존재했을때 처리 끝 -->

		<!-- 로그인이 되어있으면 등록버튼이 보이게 처리 -->
		<div style="text-align: center; margin-top: 20px;">
			<c:if test="${login.gradeNo==9 }">
				<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">등록</a>
			</c:if>
		</div>
	</div>
</body>

</html>