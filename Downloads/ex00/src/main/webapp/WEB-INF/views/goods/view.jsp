<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> 

<style type="text/css">
#smallImageDiv img {
	width: 80px;
	height: 80px;
}
#smallImageDiv img:hover {
	opacity: 70%;
	cursor: pointer;
}
#goodsDetailDiv > div {
	padding: 10px;
}
.review {
    margin: 10px 0;
}
/* 추가된 스타일 */
.gray-text {
    color: gray;
    font-weight: 300; /* 얇은 폰트 */
}
.price {
    font-size: 80%; /* 글씨 크기 80% */
    text-decoration: line-through; /* 가로줄 */
}
.sale-price {
    font-size: 100%; /* 정상 크기로 유지 */
}
</style>
<script type="text/javascript">
$(function() {
	$("#smallImageDiv img").click(function() {
		$("#bigImageDiv img").attr("src", $(this).attr("src"));
	});
	
	$("#listBtn").click(function() {
		location="list.do?page=${param.page}"
			+ "&perPageNum=${param.perPageNum}"
			+ "&${goodsSearchVO.searchQuery}";
	});
	
	$("#updateBtn").click(function() {
		location="updateForm.do?goods_no=${vo.goods_no}&page=${param.page}"
			+ "&perPageNum=${param.perPageNum}"
			+ "&${goodsSearchVO.searchQuery}";
	});
	
	// 탭 클릭 시 활성화 기능 추가
	$('a[data-toggle="tab"]').on('click', function (e) {
        e.preventDefault(); // 기본 동작 방지
        $(this).tab('show'); // 클릭한 탭을 활성화
    });
});
</script>
</head>
<body>
<div class="container">
	<div class="card">
  		<div class="card-header"><h3>상품 정보</h3></div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-6">
					<div id="bigImageDiv" class="img-thumbnail">
						<img src="${vo.image_name}" style="width: 100%;">
					</div>
					<div id="smallImageDiv">
						<img src="${vo.image_name}" class="img-thumbnail">
						<c:if test="${!empty imageList}">
							<c:forEach items="${imageList}" var="imageVO">
								<img src="${imageVO.image_name}" class="img-thumbnail">
							</c:forEach>
						</c:if>
					</div>
					<br>
					<br>
				</div>
				<div class="col-md-6" id="goodsDetailDiv">
					<div> <h3>${vo.goods_name}</h3></div>
					<div class="gray-text"> 카테고리 : ${vo.cate_name}</div>
					<div class="gray-text"> 상품 번호 : ${vo.goods_no}</div>
					<div class="price"> 정가 : ${vo.price}</div>
					<div class="sale-price"> 할인가 : ${vo.sale_price}</div>
					<div> 배송비 : ${vo.delivery_charge}</div>
					<div> 적립율 : ${vo.saved_rate}</div>
					<div class="input-group mb-3">
					    <div class="input-group-prepend">
					    	<span class="input-group-text">사이즈</span>
						   	<select class="form-control" id="size_name">
								<option>=========</option>
								<c:forEach items="${sizeList}" var="sizeVO">
									<option>${sizeVO.size_name}</option>
								</c:forEach>
							</select>
					   	</div>
					</div>
					<div class="input-group mb-3">
					    <div class="input-group-prepend">
					    	<span class="input-group-text">색상</span>
						   	<select class="form-control" id="color_name">
								<option>=========</option>
								<c:forEach items="${colorList}" var="colorVO">
									<option>${colorVO.color_name}</option>
								</c:forEach>
							</select>
					   	</div>
					</div>
				</div>
			</div>

			<div class="text-center">
			    <nav>
			        <ul class="nav nav-pills justify-content-center" id="myTab" role="tablist">
			            <li class="nav-item">
			                <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="details" aria-selected="true">상품 상세보기</a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab" aria-controls="reviews" aria-selected="false">리뷰</a>
			            </li>
			        </ul>
			    </nav>
			</div>
			<div class="tab-content text-center" id="myTabContent">
			    <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">
			    <br>
			    <br>
			    <br>
			        <pre>${vo.content}</pre>
			        <br>
			        <br>
			        <div class="mt-3">
			            <c:forEach items="${imageList}" var="imageVO">
			                <img src="${imageVO.image_name}" class="img-thumbnail" style="margin-right: 10px;">
			            </c:forEach>
			        </div>
			    </div>
			    <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
			        <c:if test="${empty reviews}">
			        	<br>
			        	<br>
			            <div>리뷰가 없습니다.</div>
			        </c:if>
			        <c:forEach items="${reviews}" var="review">
			            <div class="review">
			                <strong>${review.user_name}</strong>: ${review.content}
			            </div>
			        </c:forEach>
			    </div>
			</div>
		</div>
		<div class="card-footer">
			<button class="btn btn-primary" id="listBtn">리스트</button>
			<button class="btn btn-success" id="updateBtn">수정</button>
		</div>
	</div>
</div>
</body>
</html>
