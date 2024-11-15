<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>



<!-- 데이터는 DispatcherServlet에 담겨있다(request) -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품리스트</title>


<style type="text/css">
	.listHeader{
		margin-bottom:15px;
	}
		.visualImage {
		    position: relative;
		    width: 100%;
		    height: 300px; /* 전체 높이 설정 */
		    display: flex;
		    flex-direction: column;
		    border-radius: 15px;
		    overflow: hidden;
		}
		
		/* 상단 비주얼 이미지와 텍스트 부분 */
		.visualImage-top {
		    height: 220px; /* 상단 이미지 부분 높이 */
		    background-image: url('/upload/goods/bed03.png');
		    background-size: cover;
		    background-position: center;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: white;
		}
		
		.category-title {
		    font-size: 24px;
		    font-weight: bold;
		    text-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5); /* 텍스트 그림자 */
		}
		
		.visualImage-form {
		    display: flex;
    		align-items: center; /* 가로 중앙 정렬 */
   			 justify-content: center; /* 세로 중앙 정렬 */
		    height:70px;
		    
		}
		
		/* 서치 아이콘 버튼 스타일 */
		.input-group-prepend button.btn-primary {
		    border: none;
		    background-color: transparent; /* 배경 제거 */
		    display: flex;
		    align-items: center; /* 상하 가운데 정렬 */
		    justify-content: center;
		    height: 0px; /* 입력 필드 높이에 맞춤 */
		    margin-bottom:20px;
		}
		
		.btn-primary i {
		    font-size: 1.2em; /* 아이콘 크기 조정 */
		    background-color: transparent; /* 배경 제거 */
		    color: #555555; /* 원하는 색상 */
		}
 		
        .sale_price {
            font-weight: bold;
        }
        .discount_rate {
            font-weight: bold;
            color: red;
            font-size: small;
            margin-left:20px;
        }
        .card {
		    position: relative;
		    overflow: hidden;
		    transition: transform 0.3s ease, background-color 0.3s ease;
		    margin-top: 15px;
		    margin-bottom: 15px;
		    border:none;
		    height:450px;
		}
		
		.imageDiv {
		    position: relative;
		    overflow: hidden;
		}
		
		.card-img-top {
		    width: 100%;
		    height: 300px;
		    object-fit: cover;
		}
		
		.overlay {
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.1); /* 어두운 배경 */
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    opacity: 0; /* 기본 상태에서는 숨김 */
		    transition: opacity 0.3s ease;
		}
		
		.card:hover .overlay {
		    opacity: 1; /* 호버 시 어두운 배경 나타남 */
		}
		
		.btn {
		    color: white;
		    background: transparent; /* 버튼 배경 투명 */
		    border: none;
		    margin: 5px;
		    padding: 10px;
		    cursor: pointer;
		}

		.original-price {
    	color: #888; /* 색상 낮추기 (회색 등으로) */
   		text-decoration: line-through; /* 줄긋기 */
    	font-size: nomal;
		}
		.sale_price, .card-title{
			font-size:20px;
			font-weight:bold;
		}
		.review_count{
			color:#888;
			font-size:9px;
			text-align:right;
		}
		.simple-content{
			font-size: small; /* 폰트 크기 조정 */
    		color: #666; /* 연한 색상 */
    		 white-space: nowrap; /* 텍스트를 한 줄로 설정 */
    		overflow: hidden; /* 넘치는 텍스트 숨김 */
    		text-overflow: ellipsis; /* 생략 표시 (...) 추가 */
    		display: block; /* 한 줄로 표시되도록 블록 요소로 설정 */
		}
		.pageNav {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-top: 20px;
		}
		
		.pageNav .btn {
		    background-color: #f8f9fa; /* 버튼 기본 배경색 */
		    border: 1px solid #ddd;
		    color: #333; /* 기본 아이콘 색상 */
		    padding: 10px 15px;
		    border-radius: 4px;
		    margin: 0 5px;
		    cursor: pointer;
		    transition: all 0.3s ease;
		    font-size: 18px; /* 아이콘 크기 */
		    font-weight: bold; /* 아이콘을 두껍게 */
		    display: flex;
		    align-items: center;
		}
		
		.pageNav .btn:hover {
		    background-color: #333; /* 호버 시 버튼 배경을 어두운 색으로 */
		    color: #fff; /* 호버 시 아이콘을 흰색으로 */
		}
		
		#pageInfo {
		    font-weight: bold;
		    color: #333;
}

</style>
<!-- 4. 우리가 만든 라이브러리 등록 -->

<script type="text/javascript">
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
	  //페이징처리버튼 JS -end
	});
</script>

</head>
<body>
	<div class="container p-3 my-3">
		<!-- 비주얼 이미지 섹션 -->
	    <div class="listHeader">
	        <div><h4>카테고리별 제품 보러가기</h4></div>
	        <div>카테고리별 제품을 만나보세요!</div>
	    </div>
	    <div class="visualImage">
	    <!-- 상단 이미지와 텍스트 -->
	    <div class="visualImage-top">
	        <h2 class="category-title">침구</h2>
	    </div>
	    <!-- 하단 서치 폼 -->
	    <form action="list.do" id="searchForm" class="visualImage-form">
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
	    <h4 style="text-align:center;">데이터가 존재하지 않습니다.</h4>
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
	                        <a class="btn btn-wishlist"><i class="fa fa-heart"></i></a>
	                        <button class="btn btn-addcart"><i class="fa fa-shopping-cart"></i></button>
	                        <button class="btn btn-addcart"><i class="fa fa-search"></i></button>
	                    </div>
	                    <div class="card-body">
	                        <div class="card-title">${vo.goods_name}</div>
	                        <div class="simple-content">test</div>
	                        <p class="card-text">
	                            <span class="original-price float-left"><fmt:formatNumber value="${vo.price}"/></span>
	                            <span class="discount_rate">${vo.discount_rate}%</span>
	                            <span class="sale_price float-right"><fmt:formatNumber value="${vo.sale_price}"/></span>
	                        </p>
	                        <div class="review_count">총 리뷰 수 8개</div>
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

</body>
</html>