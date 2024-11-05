<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세페이지</title>
<link rel="stylesheet" href="/resources/css/goods/view.css">
<link rel="stylesheet" href="/resources/css/goods/view_detail.css">
<link rel="stylesheet" href="/resources/css/goods/view_review.css">


<script type="text/javascript">

	$(document).ready(function(){
		// smallImageDiv 내에 있는 img 요소에 클릭 이벤트를 연결
	    $("#smallImageDiv").on("click", "img", function(){
	        alert("이미지 클릭");
	        $("#bigImageDiv img").attr("src", $(this).attr("src"));
	    });

		
		$("#listBtn").click(function () {
			// alert("리스트 버튼");
			location="list.do?page=${param.page}"
				+ "&perPageNum=${param.perPageNum}"
				+ "&${goodsSearchVO.searchQuery}";
		});
		
		function sendData(){
			let firstForm = document.forms[0];
		
			if($("input[name='star']:checked").val() == undefined){
			alert("별점 선택 필수입니다!");
			return;
		}
			
			 function loadContent(tab) {
		            window.location.href = window.location.pathname + "?tab=" + tab; // 현재 페이지에 tab 파라미터 추가
		        }
		
	});
</script>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-6 bigImg">
			    <div id="bigImageDiv" class="img-thumbnail" style="width: 600px; height: 600px;">
			        <img id="bigImage" src="${vo.image_name}" style="width: 100%; height: 100%;">
			    </div>
			    <div id="smallImageDiv" style="display: flex; align-items: center; overflow-x: auto; margin-top: 10px;">
			        <div style="display: flex; gap: 10px;">
			            <c:if test="${!empty imageList}">
			                <c:forEach items="${imageList}" var="imageVO">
			                    <img src="${imageVO.goods_img_name}" class="img-thumbnail smallImage" style="width: 100px; height: 100px; object-fit: cover; cursor: pointer;">
			                </c:forEach>
			            </c:if>
			        </div>
			    </div>
			</div>
			<div class="col-md-6 imgContent" id="goodsDetailDiv">
				<p style="font-size: 12px; color: #999; margin-bottom: -1px;">카테고리 > ${vo.cate_name}</p>
				<div  style="">
					<strong class="tit" style="font-size: 32px;">${vo.goods_name }</strong>
				</div>
				<p style="color: #ccc; width: 100px;">${vo.goods_code }</p>
				<div class="lBox">
					<div class="summary">상품 요약정보</div>
					<div>정가</div>
					<div><span style="font-weight: 900;">판매가</span></div>
					<div>제조사</div>
					<div>배송방법</div>
					<div>배송비</div>
				</div>
				<div class="rBox">
					<div class="summary2" style="margin-top: 0;">${vo.content }</div>
					<div><fmt:formatNumber value="${vo.price}"/></div>
					<div><span style="font-weight: 900;"><fmt:formatNumber value="${vo.sale_price}"/></span></div>
					<div>${vo.company }</div>
					<div>택배배송</div>
					<div>${vo.delivary_charge }</div>
				</div>
				<div class="bBox">
					<img class="bBoxImg" src="${vo.image_name }">
					<div class="bBoxTxt">
						<strong>${vo.goods_name }<span style="font-weight: 100;">&nbsp;<fmt:formatNumber value="${vo.sale_price}"/></span>원</strong>
					</div>
				</div>
				<div class="add">
					<div class="addCart">ADD CART</div>
					<div class="addWish">ADD WISH</div>
					<div class="addBuy">구매하기</div>
				</div>
				<div style="float: right; width: 150px; margin-top: 50px;">
					<c:if test="${login.gradeNo==9 }">
						<a href="updateForm.do?goods_no=${vo.goods_no }" class="btn btn-primary">상품수정</a>
						<form action="${pageContext.request.contextPath}/goods/delete.do" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
						    <input type="hidden" name="goods_no" value="${vo.goods_no}">
						    <button type="submit" class="deleteBtn">제품 삭제</button>
						</form>
					</c:if>
				</div>
			</div>
			</div>
		<ul class="nav nav-tabs" role="tablist">
		    <li class="nav-item">
		      <a class="nav-link active" data-toggle="tab" href="#detail">상세보기</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#review">리뷰보기</a>
		    </li>
		  </ul>
       
	<div class="tab-content">
		  <div class="tab-pane container active" id="detail">
		  	<div class="container">
        		<jsp:include page="view_detail.jsp"></jsp:include>
		  	</div>
		  </div>
		  <div class="tab-pane container fade" id="review">
        	<jsp:include page="view_review.jsp"></jsp:include>
    	</div>		  
	</div>
	</div>
</body>




</html>