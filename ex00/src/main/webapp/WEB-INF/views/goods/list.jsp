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
.goods_no{
	font-weight:bold;
}
.sale_price{
	font-weight:bold;
	color:red;
}
.discount_rate{
	font-weight:bold;
	color:red;
	font-size:small;
}
</style>
<!-- 4. 우리가 만든 라이브러리 등록 -->

<script type="text/javascript">
$(function(){
	let titleHeights = [];
	
	$(".title").each(function(idx, title){
		console.log($(title).height());
		titleHeights.push($(title).height());
	});
	
	let maxTitleHeight = Math.max.apply(null, titleHeights);
	console.log("maxTitleHeight=" + maxTitleHeight);
	
	$(".title").height(maxTitleHeight);

	let imgWidth = $(".imageDiv:first").width();
	let imgHeight = $(".imageDiv:first").height();
	console.log("image width=" + imgWidth + ",height=" + imgHeight);
	let height = imgWidth / 5 * 4;
	console.log("height=",height);
	$(".imageDiv").height(height);
	$(".imageDiv > img").each(function(idx, image) {
		if($(image).height() > height) {
			let image_width = $(image).width();
			let image_height = $(image).height();
			let width = height / image_height * image_width;
			console.log("image_width=" + image_width);
			console.log("image_height=" + image_height);
			console.log("width=" + width);
			console.log("height=" + height);
			$(image).height(height);
			$(image).width(width);
		}
	});
	
	// 페이징처리
	$(".dataRow").click(function() {
		let goods_no = $(this).find(".goods_no").data("goods_no");
		location="view.do?goods_no=" + goods_no + "&${pageObject.pageQuery}"
				+"&${goodsSearchVO.searchQuery}";
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
	
});
</script>

</head>
<body>
<div class="container p-3 my-3">
	<h1><i class="fa fa-align-justify"></i>상품리스트</h1>
	<form action="list.do" id="searchForm">
		<input type="hidden" name="page" value="${pageObject.page }">
		<div class="row">
			<div class="col-md-12">
			<div class="input-group mb-3">
			    <div class="input-group-prepend">	      
			  		<select class="form-control" id="cate_code1" name="cate_code1">
			  		<option value="0">카테고리</option>
			  			<c:forEach items="${listBig }" var="vo">
			  				<option value="${vo.cate_code1 }"
			  					<c:if test="${goodsSearchVO.cate_code1==vo.cate_code1}">selected</c:if>
			  				>${vo.cate_name }</option>
			  			</c:forEach>
			  		</select>
			  		<select class="form-control" id="cate_code2" name="cate_code2">
			  		<option value="0">세부카테고리</option>
			  			<c:forEach items="${listMid }" var="vo">
			  				<option value="${vo.cate_code2 }"
			  					<c:if test="${goodsSearchVO.cate_code2==vo.cate_code2}">selected</c:if>
			  				>${vo.cate_name }</option>
			  			</c:forEach>
			  		</select>
				</div>
				<input type="text" class="form-control" placeholder="상품명검색" id="goods_name"
				name="goods_name" value="${goodsSearchVO.goods_name }">
				<input type="text" class="form-control" placeholder="최저가격입력" id="min_price"
				name="min_price" value="${goodsSearchVO.min_price }">
				<input type="text" class="form-control" placeholder="최고가입력" id="max_price"
				name="max_price" value="${goodsSearchVO.max_price }">
				<div class="input-group-prepend">
						<button type="submit" class="btn btn-primary">
							<i class="fa fa-search"></i></button>
				</div>
			 </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="input-group mt-3 mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">Rows/Page</span>
				  </div>
				  <select id="perPageNum" name="perPageNum"
				   class="form-control">
				   		<option>4</option>
				   		<option>8</option>
				   		<option>12</option>
				   		<option>16</option>
				  </select>
				</div>
			</div> <!-- end of class="col-md-4" -->
		</div><!-- end of class="row" -->
	</form>

	<c:if test="${empty list }">
		<h4>데이터가 존재하지 않습니다.</h4>
	</c:if>
	<c:if test="${!empty list }">
		<div class="row">
			<!-- 이미지 list의 데이터가 있는 만큼 표시하는 처리 시작 -->
			<c:forEach items="${list }" var="vo" varStatus="vs">
				<!-- 줄바꿈처리 - 3개를 표시하면 줄을 바꾼다. -->
				<c:if test="${(vs.index != 0) && (vs.index%4 == 0) }">
					${"</div>"}
					${"<div class='row'>"}
				</c:if>
				<!-- 데이터 표시 시작 -->
				<div class="col-md-3 dataRow">
					<div class="card" style="width:100%">
						<div class="imageDiv align-content-center text-center">
					  	<img class="card-img-top" src="${vo.image_name }" alt="Card image">
					  </div>
					  <div class="card-body title">
					    <p class="card-text">
					    <div class="goods_no" data-goods_no="${vo.goods_no }">${vo.goods_name }</div>
					    <div><fmt:formatNumber value="${vo.price }"/> 원<span class="discount_rate float-right">${vo.discount_rate }%OFF</span></div>
					    <div class="sale_price"><fmt:formatNumber value="${vo.sale_price }"/> 원</div>
					    <div>${vo.saved_rate }% 적립</div>
						</p>
					  </div>
					</div><!-- end of card -->
				</div>
				<!-- 데이터 표시 끝 -->
			</c:forEach>
			<!-- 이미지 데이터 반복 표시 끝 -->
		</div>
		<div>
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
		</div>
	</c:if><!-- 데이터 존재했을때 처리 끝 -->
	
<%-- 	<c:if test="${!empty login }"> --%>
<!-- 		<!-- 로그인이 되어있으면 등록버튼이 보이게 처리 -->
		<div>
			<a href="writeForm.do?perPageNum="${pageObject.perPageNum }"
				class="btn btn-primary">등록</a>
		</div>
<%-- 	</c:if> --%>

</div>
</body>
</html>