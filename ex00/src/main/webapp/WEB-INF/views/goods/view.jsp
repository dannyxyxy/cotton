<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기</title>
<style>
    #smallImageDiv img {
        width: 100px;
        height: 100px;
    }
    #smallImageDiv img:hover {
        opacity:70%;
        cursor:pointer;
    }
    #bigImageDiv img{
    	width:500px;
    	height:500px;
    }
    .arrow {
        cursor: pointer;
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        font-size: 24px;
        color: black;
        background-color: rgba(255, 255, 255, 0.7);
        padding: 5px;
        border-radius: 5px;
    }
    .left-arrow {
        margin-left:0;
    }
    .right-arrow {
        right: 10px;
    }
    #bigImageDiv {
        position: relative;
    }
    .cate_name{
    	color:gray;
    	margin-left:0;
    }
    .goods_name{
    	font-size:25px;
    	font-weight:bold;
    }
    .sale_price{
	font-weight:bold;
	color:red;
	font-size:25px;
	}
	.discount_rate{
		font-weight:bold;
		color:red;
		font-size:small;
		margin-left:10px;
	}
	span{
		margin-left:30px;
	}
	.delivary_charge, .saved_rate, .company, .product_date{
		color:black;
	}
	.content{
		margin-top:50px;
		background-color:#eeeeee;
		height:100px;
		border-radius:15px;
		padding:10px;
		text-align:center;
	}
	.contentImage{
		width:500px;
		height:500px;
		text-align:center;
	}
</style>
<script type="text/javascript">
    var currentIndex = 0; // 현재 이미지 인덱스
    var imageList = []; // 이미지 리스트

    window.onload = function() {
        // JSP에서 이미지 리스트를 가져옵니다.
        <c:forEach items="${imageList}" var="imageVO">
            imageList.push("${imageVO.goods_img_name}");
        </c:forEach>

        // 화살표 클릭 이벤트 등록
        document.getElementById("leftArrow").addEventListener("click", showPreviousImage);
        document.getElementById("rightArrow").addEventListener("click", showNextImage);
    };

    function changeBigImage(imageSrc) {
        var bigImageElement = document.getElementById("bigImage");
        if (bigImageElement) {
            bigImageElement.src = imageSrc;
        } else {
            console.error("bigImage element not found.");
        }
    }

    function showPreviousImage() {
        if (currentIndex > 0) {
            currentIndex--;
            changeBigImage(imageList[currentIndex]);
        }
    }

    function showNextImage() {
        if (currentIndex < imageList.length - 1) {
            currentIndex++;
            changeBigImage(imageList[currentIndex]);
        }
    }
$(function(){
	$("#listBtn").click(function(){
		location="list.do?page=${param.page}"+"&perPageNum=${param.perPageNum}"
		+"&${goodsSearchVO.searchQuery}";
	})
	
	$("#updateBtn").click(function(){
		location="updateForm.do?goods_no=${vo.goods_no}&page=${param.page}"
		+"&perPageNum=${param.perPageNum}"
		+"&${goodsSearchVO.searchQuery}";
	})
});
</script>
</head>
<body>
<div class="container">
<div class="card">
  <div class="card-body">
    <div class="row">
        <div class="col-md-6">
            <div id="bigImageDiv" class="img-thumbnail">
                <span id="leftArrow" class="arrow left-arrow">&lt;</span>
                <img id="bigImage" src="${vo.image_name}">
                <span id="rightArrow" class="arrow right-arrow">&gt;</span>
            </div>
            <div id="smallImageDiv">
                <c:if test="${!empty imageList}">
                    <c:forEach items="${imageList}" var="imageVO">
                        <img src="${imageVO.goods_img_name}" class="img-thumbnail"
                        onclick="changeBigImage('${imageVO.goods_img_name}'); currentIndex = ${imageList.indexOf(imageVO)};">
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <div class="col-md-6">
        	<div class="mb-3">카테고리 > <span class="cate_name">${vo.cate_name }</span></div>
        	<div class="mb-3" data-goods_no="${vo.goods_no }"></div>
        	<div class="mb-3 goods_name">${vo.goods_name }</div>
        	<div class="mb-3" style="color:gray;">${vo.price }원<span class="mb-3 discount_rate">${vo.discount_rate }%OFF</span></div>
        	<div class="mb-3" style="color:gray;">세일가<span class="mb-3 sale_price">${vo.sale_price }원</span></div>
        	<div class="mb-3" style="color:gray;">배송비<span class="mb-3 delivary_charge">${vo.delivary_charge }원</span></div>
        	<div class="mb-3" style="color:gray;">적립율<span class="mb-3 saved_rate">${vo.saved_rate }%</span></div>
        	<div class="mb-3" style="color:gray;">제조사<span class="mb-3 company">${vo.company }</span></div>
        	<div class="mb-3" style="color:gray;">제조일<span class="mb-3 product_date">
        		<fmt:formatDate value="${vo.product_date}" pattern="yyyy년 MM월 dd일" /></span>
        	</div>
        	<div class="mb-3" class="form-group">
			  <label for="sel1">Select list:</label>
			  <select class="form-control" id="sel1">
			    <option>1</option>
			    <option>2</option>
			    <option>3</option>
			    <option>4</option>
			  </select>
			</div>
			<div class="float-right">
				<button class="btn btn-primary" id="cartBtn">장바구니</button>
	  			<button class="btn btn-primary" id="likeBtn">관심목록</button>
	  			<button class="btn btn-primary" id="buyBtn">구매하기</button>
			</div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
        	<pre class="content">${vo.content }</pre>
        	<c:if test="${!empty imageList}">
                    <c:forEach items="${imageList}" var="imageVO">
                        <img src="${imageVO.goods_img_name}" class="contentImage">
                    </c:forEach>
            </c:if>
        </div>
    </div>
  </div>
  <div class="card-footer">
  	<button class="btn btn-primary" id="listBtn">리스트</button>
  	<button class="btn btn-primary" id="updateBtn">수정</button>
  	
  </div>
</div>
</div>
</body>
</html>
