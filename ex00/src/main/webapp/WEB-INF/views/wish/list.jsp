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
//장바구니에 상품을 추가하는 함수
function addToCartlist(goods_no) {
    // AJAX 요청 보내기 (userId를 클라이언트에서 보내지 않음)
    var userId = '${login.id}'; // 이 부분이 실제로 정상적으로 로그인된 id를 담고 있는지 확인
		if (!userId) {
		    alert("로그인 후 장바구니에 추가할 수 있습니다.");
		    return;
		}
    $.ajax({
        url: '/cart/add',  // 위시리스트 추가를 처리하는 서버 경로
        type: 'POST',
        data: {
            goods_no: goods_no,  // 상품 번호만 서버로 전송
            userId : userId
        },
        success: function(response) {
           alert("상품이 장바구니에 추가되었습니다!");
           loadCartList(); // 위시리스트 갱신 함수 호출 (다시 로드)   
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}

function removeFromWishlist(wish_no) {
    // AJAX 요청을 통해 wish_no만 전달하여 해당 상품 삭제
    $.ajax({
        url: '/wish/remove', // 상품 삭제를 처리하는 URL
        type: 'POST',
        data: { wish_no: wish_no }, // wish_no만 넘김
        success: function(response) {
            alert("위시리스트에서 상품이 제거되었습니다.");
            location.reload(); // 페이지를 새로 고침하여 위시리스트 갱신
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}

$(function(){
	$(function(){
		$(".btn-search").click(function() {
		    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
		    let goods_no = $(this).closest(".promotion-card").data("goods_no"); 
		    console.log("상품 상세보기로 이동: goods_no =", goods_no);
		    if (goods_no) {
		        // 상품 상세 페이지로 이동 (불필요한 파라미터 제거)
		        location.href = "/goods/view.do?goods_no=" + goods_no; 
		    } else {
		        console.error("goods_no가 정의되지 않았습니다.");
		    }
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
        <div>${login.id }님의 위시리스트로 등록하신 상품들입니다(${total})</div>
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
                    <img src="${wish.image_name}" class="card-img-top">
                    <div class="overlay">
                         <button class="btn btn-remove" onclick="removeFromWishlist(${wish.wish_no})">
                         	<i class="fa fa-trash"></i>
                         </button>
                        <button class="btn btn-addcart" onclick="addToCartlist(${wish.goods_no})">
                        	<i class="fa fa-shopping-cart"></i>
                        </button>
                        <button class="btn btn-search"><i class="fa fa-search"></i></button>
                    </div>
                    <div class="card-body">
                        <div class="card-title">${wish.goods_name}</div>
                        <div class="simple-content">${wish.content }</div>
                        <p class="card-text">
                            <span class="original-price float-left"><fmt:formatNumber value="${wish.price}"/></span>
                            <span class="discount_rate">${wish.discount_rate}%</span>
                            <span class="sale_price float-right"><fmt:formatNumber value="${wish.sale_price}"/></span>
                        </p>
                        <div class="review_count">총 리뷰 수 8개</div>
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
</body>
</html>

