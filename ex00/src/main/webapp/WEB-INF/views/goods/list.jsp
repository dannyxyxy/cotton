<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트</title>
<link rel="stylesheet" href="/resources/css/goods/list.css">
<script type="text/javascript">
$(document).ready(function() {
		// 상품 상세보기 이동 (검색 아이콘 클릭)
		$(".btn-search").click(function() {
		    // 클릭한 버튼의 부모 요소인 promotion-card에서 goods_no 추출
		    let goods_no = $(this).closest(".promotion-card").data("goods_no"); 
		    console.log("상품 상세보기로 이동: goods_no =", goods_no);
		    if (goods_no) {
		        // 상품 상세 페이지로 이동
		        location.href = "view.do?goods_no=" + goods_no + "&${pageObject.pageQuery}&${goodsSearchVO.searchQuery}";
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
</script>
</head>
<body>
<div class="container p-3 my-3" >
	<!-- 비주얼 이미지 섹션 -->
    <div class="listHeader">
        <div><h4>카테고리별 제품 보러가기</h4></div>
        <div>카테고리별 제품을 만나보세요!</div>
    </div>
    <div class="visualImage">
    <!-- 상단 이미지와 텍스트 -->
    <c:if test="${param.cate_code1==1 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/chair_visual.png)">
            <h2 class="category-title">의자</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==2 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/etc_visual.png)">
            <h2 class="category-title">소품</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==3 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/bed_visual.png)">
            <h2 class="category-title">침구</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==4 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/table_visual.png)">
            <h2 class="category-title">테이블</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==5 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/storage_visual.png)">
            <h2 class="category-title">수납</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==6 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/curtain_visual.png)">
            <h2 class="category-title">커튼</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==7 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/lug_visual.png)">
            <h2 class="category-title">러그</h2>
        </div>
    </c:if>
    <c:if test="${param.cate_code1==8 }">
        <div class="visualImage-top" style="background-image: url(/upload/goods/light_visual.png)">
            <h2 class="category-title">조명</h2>
        </div>
    </c:if>
    <!-- 하단 서치 폼 -->
    <form action="list.do" id="searchForm" class="visualImage-form">
    <!-- cate_code1 값을 저장할 hidden 필드 추가 -->
    <input type="hidden" name="cate_code1" value="${goodsSearchVO.cate_code1}">

    <div class="input-group mb-3">
        <input type="text" class="form-control" placeholder="상품명검색" id="goods_name"
            name="goods_name" value="${goodsSearchVO.goods_name }">
        <input type="text" class="form-control" placeholder="최저가격입력" id="min_price"
            name="min_price" value="${goodsSearchVO.min_price }">
        <input type="text" class="form-control max-price-input" placeholder="최고가격입력" id="max_price"
            name="max_price" value="${goodsSearchVO.max_price }">
    </div>
    <div class="input-group-prepend">
        <button type="submit" class="btn btn-primary">
            <i class="fa fa-search"></i>
        </button>
    </div>
</form>
</div>

<c:if test="${empty list }">
    <h4 style="text-align:center; height: 200px;">데이터가 존재하지 않습니다.</h4>
</c:if>
<c:if test="${!empty list }">
	<div class="container p-3 my-3">
    <div class="dataRow row" id="cardContainer">
        <c:forEach items="${list}" var="vo" varStatus="vs">
        <c:if test="${vs.index % 3 == 0 && vs.index != 0}">
    </div> <!-- 이전 row 닫기 -->
     <div class="dataRow row"> <!-- 새로운 row 시작 -->
            </c:if>
            <div class="col-md-4 promotion-card" data-goods_no="${vo.goods_no}">
                <div class="card">
                    <img src="${vo.image_name}" class="card-img-top">
                    <div class="overlay">
                        <button class="btn btn-wishlist" onclick="addToWishlist(${vo.goods_no})">
						    <i class="fa fa-heart"></i>
						</button>
                        <button class="btn btn-addcart" onclick="addToCartlist(${vo.goods_no})">
                        	<i class="fa fa-shopping-cart"></i>
                        </button>
                        <button class="btn btn-search"><i class="fa fa-search"></i></button>
                    </div>
                    <div class="card-body">
                        <div class="card-title">${vo.goods_name}</div>
                        <div class="simple-content">${vo.content }</div>
                        <p class="card-text">
                            <span class="original-price float-left"><fmt:formatNumber value="${vo.price}"/></span>
                            <span class="discount_rate">${vo.discount_rate}%</span>
                            <span class="sale_price float-right"><fmt:formatNumber value="${vo.sale_price}"/></span>
                        </p>
                        <div class="review_count">총 리뷰 수 ${vo.reviewCount}개</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div> <!-- 마지막 row 닫기 -->

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
</c:if>

<c:if test="${login.gradeNo==9 }">
	<div class="pageNav">
		<a href="writeForm.do?perPageNum="${pageObject.perPageNum } class="btn btn-primary">상품등록</a>
	</div>
</c:if>
<script type="text/javascript">
function addToWishlist(goods_no) {
    // AJAX 요청 보내기 (userId를 클라이언트에서 보내지 않음)
    var userId = '${login.id}'; // 이 부분이 실제로 정상적으로 로그인된 id를 담고 있는지 확인
		if (!userId) {
		    alert("로그인 후 위시리스트에 추가할 수 있습니다.");
		    return;
		}
    $.ajax({
        url: '/wish/add',  // 위시리스트 추가를 처리하는 서버 경로
        type: 'POST',
        data: {
            goods_no: goods_no,  // 상품 번호만 서버로 전송
            userId : userId
        },
        success: function(response) {
           alert("상품이 위시리스트에 추가되었습니다!");
           loadWishList(); // 위시리스트 갱신 함수 호출 (다시 로드)   
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
            alert("서버와의 연결에 문제가 발생했습니다.");
        }
    });
}
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
</script>


</body>
</html>

