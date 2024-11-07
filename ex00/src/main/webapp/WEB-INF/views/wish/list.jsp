<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위시리스트</title>
<link rel="stylesheet" href="/resources/css/wish/list.css">
<script type="text/javascript">
function removeFromWishlist(goods_no) {
    // LoginVO에서 id를 가져옵니다.
    var userId = '${loginVO.id}'; // AOP에서 설정된 LoginVO의 id 필드를 사용
    
    // AJAX 요청 보내기
    $.ajax({
        url: '/wish/remove', // 위시리스트에서 상품 제거 경로
        type: 'POST',
        data: {
            goods_no: goods_no,
            userId: userId
        },
        success: function(response) {
            if (response.success) {
                alert("위시리스트에서 상품이 제거되었습니다.");
                location.reload(); // 페이지를 새로 고침하여 위시리스트 갱신
            } else {
                alert("위시리스트에서 상품을 제거하는 데 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}

$(function(){
	$(function(){
		$(".promotion-card").click(function() {
		    let goods_no = $(this).data("goods_no");
		    console.log("goods_no =", goods_no);
		    if (goods_no) {
		        location = "view.do?goods_no=" + goods_no + "&${pageObject.pageQuery}&${goodsSearchVO.searchQuery}";
		    } else {
		        console.error("goods_no가 정의되지 않았습니다.");
		    }
		});
		
		function appendCateCode() {
		    // cate_code1 값을 가져와서 URL에 추가
		    var cateCode1 = document.querySelector('input[name="cate_code1"]').value;
		    // 폼의 액션 URL을 수정
		    var form = document.getElementById('searchForm');
		    form.action = 'list.do?cate_code1=' + cateCode1;
		    return true; // 폼 제출을 계속 진행
		}

	    
		$("#perPageNum").change(function(){
			console.log("goodsSearchVO.goods_no : "+goodsSearchVO.goods_no);
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
	  //페이징처리버튼 JS -end
	});
});
</script>
</head>
<body>

<div class="container p-3 my-3">
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>위시리스트</h4></div>
        <div>${login.id }님의 위시리스트로 등록하신 상품들입니다(${total != null ? total : 0})</div>
    </div>
    <div id="wishlist-container">
            <c:if test="${empty wishList}">
                <p>위시리스트에 추가된 상품이 없습니다.</p>
            </c:if>
	 <!-- 위시리스트 아이템 리스트 -->
    <div class="row">
        <c:forEach items="${wishList}" var="wish">
            <div class="col-md-4 promotion-card" data-goods_no="${wish.goods_no}">
                <div class="card">
                    <img src="${wish.image_name}" class="card-img-top" />
                    <div class="card-body">
                        <h5 class="card-title">${wish.goods_name}</h5>
                        <p class="card-text">${wish.content}</p>
                        <!-- 위시리스트에서 제거하기 버튼 -->
                        <button class="btn btn-remove" onclick="removeFromWishlist(${wish.goods_no})">
                            <i class="fa fa-trash"></i> 위시리스트에서 제거
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 페이지 내비게이션 -->
    <div class="pageNav" id="pagination">
        <a href="#" class="btn" id="prevPage"><i class="fa fa-angle-left"></i></a>
        <span id="pageInfo"></span>
        <a href="#" class="btn" id="nextPage"><i class="fa fa-angle-right"></i></a>
    </div>
</div>


<!--     <div> -->
<%--         <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav> --%>
<!--     </div> -->

<c:if test="${login.gradeNo==9 }">
	<div class="pageNav">
		<a href="writeForm.do?perPageNum="${pageObject.perPageNum } class="btn btn-primary">상품등록</a>
	</div>
</c:if>



</body>
</html>

