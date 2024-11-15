<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니리스트</title>
<link rel="stylesheet" href="/resources/css/cart/list.css">
<script type="text/javascript">
	// 장바구니 총 수량 및 총 가격 계산 함수
	function calculateCartSummary() {
	    let totalQuantity = 0;
	    let totalPrice = 0;
	
	    // 각 항목의 수량과 가격을 합산
	    $('.item-quantity').each(function() {
	        const quantity = parseInt($(this).val()) || 0;
	        const price = parseFloat($(this).data('price')) || 0;
	        const itemTotalPrice = quantity * price;
	
	        totalQuantity += quantity;
	        totalPrice += itemTotalPrice;
	    });
	
	    // 총 수량 및 총 가격 업데이트
	    $('#totalQuantity').text(totalQuantity);
	    $('#totalPrice').text(totalPrice.toLocaleString());
	    $('#totalPriceDuplicate').text(totalPrice.toLocaleString()); // 두 번째 위치
	}
	
	// 페이지 로드 시 총 수량 및 총 가격 초기화
	$(document).ready(function() {
	    calculateCartSummary();
	
	    $('.item-quantity').on('input', function() {
	        calculateCartSummary();
	    });
	
	    const itemsPerPage = 5;  // 한 페이지당 아이템 수
	    let currentPage = 1;     // 현재 페이지 번호
	    const $cartItems = $('.cart-item-card'); // jQuery 객체로 전체 아이템 선택
	
	    // 페이지 전환 함수
	    function showPage(page) {
	        console.log("Requested page:", page);
	
	        // 유효한 페이지 번호인지 확인하고 기본값 설정
	        page = parseInt(page) || 1; // 숫자가 아닌 경우 기본값으로 1 설정
	        if (page < 1) page = 1;
	        const totalPageCount = Math.ceil($cartItems.length / itemsPerPage);
	        if (page > totalPageCount) page = totalPageCount;
	
	        console.log("Valid page:", page);  // 현재 페이지 값 확인
	
	        // 모든 아이템 숨기기
	        console.log("Hiding all items");
	        $cartItems.hide();
	
	        // 현재 페이지에 해당하는 아이템만 표시
	        const start = (page - 1) * itemsPerPage;
	        const end = start + itemsPerPage;
	
	        console.log(`Calculated start index: ${start}, end index: ${end}`); // start와 end 값 확인
	
	        // 범위 내 아이템만 표시
	        $cartItems.slice(start, end).show();
	
	        // 현재 페이지 업데이트
	        currentPage = page;
	    }
	
	    // 이전 페이지 버튼 기능
	    $('#prevPage').on('click', function() {
	        if (currentPage > 1) {
	            showPage(currentPage - 1);
	        }
	    });
	
	    // 다음 페이지 버튼 기능
	    $('#nextPage').on('click', function() {
	        const totalPageCount = Math.ceil($cartItems.length / itemsPerPage);
	        if (currentPage < totalPageCount) {
	            showPage(currentPage + 1);
	        }
	    });
	
	    // 초기 페이지 설정
	    showPage(currentPage);
	});
	
	
	
	function removeFromCartlist(cart_no) {
	    // AJAX 요청을 통해 wish_no만 전달하여 해당 상품 삭제
	    $.ajax({
	        url: '/cart/remove', // 상품 삭제를 처리하는 URL
	        type: 'POST',
	        data: { cart_no: cart_no }, // wish_no만 넘김
	        success: function(response) {
	            alert("장바구니에서 상품이 제거되었습니다.");
	            location.reload(); // 페이지를 새로 고침하여 위시리스트 갱신
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 실패:", error);
	            alert("서버와의 연결에 문제가 발생했습니다.");
	        }
	    });
	}
	$(function(){		
			$(".btn-search").click(function() {
			    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
			    let goods_no = $(this).closest(".cart-item-card").data("goods_no"); 
			    console.log("상품 상세보기로 이동: goods_no =", goods_no);
			    if (goods_no) {
			        // 상품 상세 페이지로 이동 (불필요한 파라미터 제거)
			        location.href = "/goods/view.do?goods_no=" + goods_no; 
			    } else {
			        console.error("goods_no가 정의되지 않았습니다.");
			    }
			});
	});
</script>
</head>
<body>
<div class="container p-3 my-3">
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>장바구니</h4></div>
        <div style="margin-bottom:50px;">${login.id }님의 장바구니에 등록하신 상품들입니다(${total})</div>
    </div>
    <div id="cartlist-container">
            <c:if test="${empty cartList}">
                <p>장바구니에 추가된 상품이 없습니다.</p>
            </c:if>
	 <!-- 위시리스트 아이템 리스트 -->
    <div class="row">
        <c:forEach items="${cartList}" var="cart">
        <div class="col-12 mb-4">
		    <div class="card cart-item-card flex-row" data-goods_no="${cart.goods_no}">
		        <!-- Left section: Product Image -->
		        <div class="cart-image-wrapper">
		            <img src="${cart.image_name}" class="img-fluid cart-image">
		        </div>
		        <!-- Right section: Product Details -->
		        <div class="card-body d-flex flex-column justify-content-between">
		            <div>
		                <!-- Product Title -->
		                <h5 class="card-title">${cart.goods_name}</h5>
		                <!-- Product Content Description -->
		                <p class="simple-content">${cart.content}</p>
		                <!-- Price and Discount -->
		                <div class="price-section">
		                    <span class="original-price"><fmt:formatNumber value="${cart.price}"/></span>
		                    <span class="discount-rate">${cart.discount_rate}%</span>
		                    <span class="sale-price"><fmt:formatNumber value="${cart.sale_price}"/></span>
			                <span class="total-adjust float-right">
							    <input type="number" class="total-input item-quantity"
							     value="1" min="1" data-price="${cart.sale_price}">
							</span>
		                </div>
		            </div>
		            <!-- Action Buttons -->
		            <div class="overlay">
		                <button class="btn btn-remove" onclick="removeFromCartlist(${cart.cart_no})"> 
		                   <i class="fa fa-trash"></i> 
		                </button>
		                <button class="btn btn-search"><i class="fa fa-search"></i></button> 
		            </div> 
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
    
    <!-- 장바구니 총합 -->
	<h4 style="margin-top:50px;">결제내역</h4>
	<div class="cart-summary card mt-4 p-4 shadow-sm" style="border-radius: 10px; border: none;">
	<table class="table table-borderless">
    <thead>
      <tr>
        <th>선택된 수량</th>
        <th>선택된 금액</th>       
        <th></th>
        <th>배송비</th>        
        <th>총 결제금액</th>
        <th></th>     
      </tr>
    </thead>
    <tbody>
      <tr>
        <td id="totalQuantity">${totalQuantity}</td>
        <td id="totalPrice">${totalPrice}</td>
        <td><i class="fa fa-plus"></i></td>       
        <td id="delivary_charge">무료배송(설치비용별도)</td>      
        <td id="totalPriceDuplicate">${totalPrice}</td>
        <td><button class="buy-btn">결제하기</button></td>
      </tr>
    </tbody>
  </table>
  </div> 
</div>
</div>
</body>
</html>

