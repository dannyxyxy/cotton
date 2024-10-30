<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<script type="text/javascript">
$(function(){
	let now = new Date();
	let startYear = now.getFullYear();
	let yearRange = (startYear - 10) + ":" + (startYear + 10);
	
	$(".datepicker").datepicker({
		dateFormat : "yy-mm-dd",
		changeMonth: true,
		changeYear: true,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		dayNamesMin: ["일","월","화","수","목","금","토"],
		yearRange : yearRange
	});
	
	$("#product_date").datepicker("option",{"maxDate" : new Date()});
	$("#sale_start_date, #sale_end_date").datepicker("option",{"minDate" : new Date()});
	$("#sale_start_date").change(function(){
		$("#sale_end_date").datepicker("option","minDate",$(this).val());});
	$("#sale_end_date").change(function(){
		$("#sale_start_date").datepicker("option","maxDate",$(this).val());});
	
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
	
	// image 추가 / 삭제
	let imageTagCnt =1;
	$("#appendImageBtn").click(function(){
		if (imageTagCnt >= 5) return;
		let addImageTag = "";
		
		addImageTag += '<div class="input-group mb-3">';
		addImageTag += '<input type="file" class="form-control" name="imageFiles">';
		addImageTag += '<div class="input-group-append">';
		addImageTag += '<button class="btn btn-danger removeImageBtn" type="button">';
		addImageTag += '<i class="fa fa-close"></i>';
		addImageTag += '</button>';
		addImageTag += '</div>';
		addImageTag += '</div>';
		
		$(".imageForm").append(addImageTag);
		imageTagCnt++;
	});
	
	$(".imageForm").on("click", ".removeImageBtn", function(){
		//alert("remove image button");
		$(this).closest(".input-group").remove();
		imageTagCnt--;
	});

});
</script>
</head>
<body>
<div class="container">
<div class="card">
  <div class="card-header"><h3>상품등록</h3></div>
  <form action="write.do" method="post" enctype="multipart/form-data">
	  <div class="card-body">
	  <div class="form-group">
  		<label for="cate_code1">카테고리</label>
  		<select class="form-control" id="cate_code1" name="cate_code1">
  			<c:forEach items="${listBig }" var="vo">
  				<option value="${vo.cate_code1 }">${vo.cate_name }</option>
  			</c:forEach>
  		</select>
		</div>
		<div class="form-group">
  		<label for="cate_code2">세부 카테고리</label>
  		<select class="form-control" id="cate_code2" name="cate_code2">
  			<c:forEach items="${listMid }" var="vo">
  				<option value="${vo.cate_code2 }">${vo.cate_name }</option>
  			</c:forEach>
  		</select>
		</div>
	  	<div class="form-group">
	  		<label for="goods_name">상품명</label>
	  		<input class="form-control" id="goods_name" name="goods_name" required>
	  	</div>
	  	<div class="form-group">
	  		<label for="imageMain">대표이미지</label>
	  		<input type="file" class="form-control" id="imageMain" name="imageMain" required>
	  	</div>
	  	<div class="form-group">
	  		<label for="content">상품설명</label>
	  		<textarea rows="10" class="form-control" id="content" name="content"></textarea>
	  	</div>
	  	<div class="form-group">
	  		<label for="company">제조사</label>
	  		<input class="form-control" id="company" name="company" required>
	  	</div>
	  	<div class="form-group">
	  		<label for="product_date">제조일</label>
	  		<input class="form-control datepicker" id="product_date" name="product_date" readonly>
	  	</div>
	  	<div class="form-group">
	  		<label for="price">정가</label>
	  		<input class="form-control" id="price" name="price" required>
	  	</div>
	  	<div class="form-group">
	  		<label for="discount_rate">할인율</label>
	  		<input class="form-control" id="discount_rate" name="discount_rate">
	  	</div>
	  	<div class="form-group">
	  		<label for="discount">할인적용액</label>
	  		<input class="form-control" id="discount" name="discount" value="0">
	  	</div>
	  	<div class="form-group">
	  		<label for="saved_rate">적립율</label>
	  		<input class="form-control" id="saved_rate" name="saved_rate" value="0">
	  	</div>
	  	<div class="form-group">
	  		<label for="delivary_charge">배송비</label>
	  		<input class="form-control" id="delivary_charge" name="delivary_charge" value="0">
	  	</div>
	  	<div class="form-group">
	  		<label for="sale_start_date">판매시작일</label>
	  		<input class="form-control datepicker" id="sale_start_date" name="sale_start_date" readonly>
	  	</div>
	  	<div class="form-group">
	  		<label for="sale_end_date">판매종료일</label>
	  		<input class="form-control datepicker" id="sale_end_date" name="sale_end_date" readonly>
	  	</div>
	  	<fieldset class="border p-4 imageForm">
			<legend class="w-auto px-2">
				<b style="font-size: 14px">ADD IMAGE</b>
				<button class="btn btn-primary btn-sm" id="appendImageBtn" type="button">
				<i class="fa fa-plus"></i>
				</button>
			</legend>
			<div class="input-group mb-3">
				<input type="file" class="form-control" name="imageFiles">
			</div>
	</fieldset>
	  </div>
	  <div class="card-footer">
	  	<button class="btn btn-primary">등록</button>
	  	<button class="btn btn-success">수정</button>
	  </div>
  </form>
</div>
</div>
</body>
</html>
