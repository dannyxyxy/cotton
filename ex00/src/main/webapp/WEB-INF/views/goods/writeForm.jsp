<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script type="text/javascript">
	$(function(){
		// 이벤트 처리
		let now = new Date();
		let startYear = now.getFullYear();
		let yearRange = (startYear - 10) + ":" + (startYear + 10);
		
		// 날짜 입력 설정
		$(".datepicker").datepicker({
			// 입력란의 데이터 포맷
			dateFormat : "yy-mm-dd",
			// 월 선택 추가
			changeMonth: true,
			// 년 선택 추가
			changeYear: true,
			// 월 선택 입력(기본:영어->한글)
			monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			// 달력의 요일 표시 (기본:영어->한글)
			dayNamesMin: ["일","월","화","수","목","금","토"],
			// 선택할 수 있는 년도의 범위
			yearRange : yearRange
		});
		
		// 생산일은 현재날짜 이전에만 입력가능
		$("#product_date").datepicker("option", {"maxDate" : new Date()});
		// 판매시작일과 종료일은 현재날짜 이후만 입력가능
		$("#sale_start_date, #sale_end_date").datepicker("option", {"minDate" : new Date()});
		// 판매시작일이 판매종료일보다 앞에 있도록 합니다.
		$("#sale_start_date").change(function () {
			$("#sale_end_date").datepicker("option", "minDate", $(this).val());
		});
		$("#sale_end_date").change(function () {
			$("sale_start_date").datepicker("option", "maxDate", $(this).val());
		});
		
		
		// 대분류 리스트 변경
		$("#cate_code1").change(function () {
			// alert("대분류 리스트 변경");
			let cate_code1 = $(this).val();
			// alert("cate_code1 = " + cate_code1);
			
			$.ajax({
				type: "get",
				url: "/goods/getCategory.do?cate_code1=" + cate_code1,
				dataType: "json",
				success: function(result, status, xhr) {
					// alert("중분류 가져오기 성공함수");
					console.log(result);
					
					let str = "";
					result.forEach(function(item) {
						console.log(item.cate_name);
						str += '<option value="' + item.cate_code2 + '">';
						str += item.cate_name + '</option>\n';
					});
					
					console.log(str);
					
					$("#cate_code2").html(str);
				},
				error: function (xhr, status, err) {
					console.log("중분류 가져오기 오류 ***********************");
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("err : " + err);
				}
			});
		});
		// 대분류 리스트 끝변경 
		
		
		// color 추가 / 삭제
		let colorTagCnt = 1;
		
		$("#appendColorBtn").click(function () {
			// alert("add Color Button");""
			
			if (colorTagCnt >= 5) return;
			
			let addColorTag = "";
			
			addColorTag += '<div class="input-group mb-3">';
			addColorTag += '<input type="text" class="form-control" name="color_names">';
			addColorTag += '<div class="input-group-append">';
			addColorTag += '<button class="btn btn-danger removeColorBtn" type="button">';
			addColorTag += '<i class="fa fa-close"></i>';
			addColorTag += '</button>';
			addColorTag += '</div>';
			addColorTag += '</div>';
			
			$(".colorForm").append(addColorTag);
			colorTagCnt++;
		});
		
		$(".colorForm").on("click", ".removeColorBtn", function () {
			// alert("remove Color Button");
			$(this).closest(".input-group").remove();
			colorTagCnt--;
		});
		
		
		// size 추가 / 삭제
		let sizeTagCnt = 1;
		
		$("#appendSizeBtn").click(function () {
			// alert("add Size Button");""
			
			if (sizeTagCnt >= 5) return;
			
			let addSizeTag = "";
			
			addSizeTag += '<div class="input-group mb-3">';
			addSizeTag += '<input type="text" class="form-control" name="size_names">';
			addSizeTag += '<div class="input-group-append">';
			addSizeTag += '<button class="btn btn-danger removeSizeBtn" type="button">';
			addSizeTag += '<i class="fa fa-close"></i>';
			addSizeTag += '</button>';
			addSizeTag += '</div>';
			addSizeTag += '</div>';
			
			$(".sizeForm").append(addSizeTag);
			sizeTagCnt++;
		});
		
		$(".sizeForm").on("click", ".removeSizeBtn", function () {
			// alert("remove Size Button");
			$(this).closest(".input-group").remove();
			sizeTagCnt--;
		});
		
		
		// image 추가 / 삭제
		let imageTagCnt = 1;
		
		$("#appendImageBtn").click(function () {
			// alert("add Image Button");""
			
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
		
		$(".imageForm").on("click", ".removeImageBtn", function () {
			// alert("remove Image Button");
			$(this).closest(".input-group").remove();
			imageTagCnt--;
		});
		
		
		
		
	});
</script>


<style>
    
    form {
    	width: 1143px;
    }
    
    .form-control {
    	width: 560px;
    }
    
    #content {
    	width: 100%;
    	margin-top: 16px;
    }
    
    .btn1 {
    	float: right;
    	width: 150px;
    	height: 40px;
    	border: none;
    	border-radius: .25rem;
    	font-size: 16px;
    }
    
    .btn2 {
    	float: left;
    	margin-right: 16px;
    	width: 150px;
    	height: 40px;
    	border: none;
    	border-radius: .25rem;
    	font-size: 16px;
    	background: black;
    	color: white;
    }
    
    select {
    	height: 38px;
    	border: 1px solid #ccc;
    	border-radius: .25rem;
    }
    
</style>

</head>
<body>
	<div class="container">
	  <h2>제품 등록하기</h2>
	  <form action="write.do" method="post" enctype="multipart/form-data">
		  <input type="hidden" name="perPageNum" value="${param.perPageNum }" />
	      <label for="name" style="color: #ccc;">침구제품 등록하기</label>
		    <div class="form-group">
		      <input type="text" class="form-control" id="name" pattern="^[^ .].{2.99}$" required
		      		title="맨앞에 공백문자 불가, 3~100자 입력" placeholder="제품이름" name="goods_name" style="float: left;">
		      <input type="text" class="form-control" id="name" pattern="^[^ .].{2.99}$" required
		      		title="맨앞에 공백문자 불가, 3~100자 입력" placeholder="모델번호" name="model_no" style="float: right;">
		    </div>
		      <label for="name" style="margin: 16px 0 -4px 0;">카테고리</label>
		    <div class="form-group">
		      <select class="form-control" name="category_no" style="float: left; width: 560px; height: 38px; padding-left: 10px; color: black;">
		      	<option value="침구">침구</option>
		      	<option value="침구">테이블</option>
		      	<option value="침구">의자</option>
		      	<option value="침구">소품</option>
		      	<option value="침구">수납</option>
		      	<option value="침구">러그</option>
		      	<option value="침구">커튼</option>
		      	<option value="침구">조명</option>
		      </select>
		      <input type="text" class="form-control" id="name" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
		      	placeholder=제조사 name="company" style="float: right;">
		    </div>
		    <div class="form-group" style="margin-top: 60px;">
		      <textarea class="form-control" rows="7" id="content" name="content" placeholder="제품설명" required></textarea>
		    </div>
		    <div class="form-group">
				<!-- 파일로 넘어가는 데이터는 GoodsVO 객체의 이름과 다른이름을 사용해야 합니다. -->
				<label for="imageMain">대표이미지</label>
				<input type="file" class="form-control" id="imageMain" name="imageMain" required>	
			</div>
		    <div class="form-group">
		      <input type="text" class="form-control" id="goodsPrice" pattern="^[A-Z0-9].{3.20}$" required
		      		title="대문자와 숫자만 입력 3~20자 입력" placeholder="정가" name="goodsPrice" style="float: left;">
		      <input type="text" class="form-control" id="goodsPrice2" pattern="^[A-Z0-9].{3.20}$" required
		      		title="대문자와 숫자만 입력 3~20자 입력" placeholder="판매가" name="sale_price" style="float: right;">
		    </div>
		    <div class="form-group">
		    <input type="text" class="form-control" id="name" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
		      	placeholder="배송비" name="delivary_charge" style="float: right; margin-top: 16px;">
		     <input type="text" class="form-control" id="discount_rate" pattern="^[^ .].{2.99}$" required title="맨앞에 공백문자 불가, 3~100자 입력"
			    placeholder="할인율" name="discount_rate" style="float:left; margin-top: 16px;">
		      
		    </div>
		    <fieldset class="border p-4 imageForm" style="width: 100%; border-radius: .25rem;">
				<legend class="w-auto px-2">
					<button class="btn btn-primary btn-sm" id="appendImageBtn" type="button">
						+
					</button>
					<b style="font-size: 14px">상세이미지 첨부하기</b>
				</legend>
				<div class="input-group mb-3">
				  <input type="file" class="form-control" name="imageFiles">
				</div>
			</fieldset>
		    
		  <div class="form-group" style="float: right; margin-top: 48px;">
				    <button type="submit" class="btn2">등록</button>
				    <button type="button" class="btn1" onclick="history.back()" id="cancelBtn">취소</button>
		</div>
	  </form>
	</div>

</body>
</html>