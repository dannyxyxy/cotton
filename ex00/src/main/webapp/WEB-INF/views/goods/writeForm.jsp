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
	h5 {
		font-size: 18px;
		color: #979797;
	}
   	
    .ipt {
    	width: 550px;
    	height: 40px;
    	border-radius: 5px;
    	border: 1px solid #e8e8e8;
    	color: #black;
    	font-size: 14px;
    	padding-left: 10px;
    }
    
    select {
    	color: black;
    }
    
    #description {
    	width: 1104px;
    	height: 200px;
    	border: 1px solid #e8e8e8;
    	border-radius: 5px;
    	margin-top: 12px;
    	padding-left: 10px;
    }
    
    .ipt4 {
    	margin-top: 12px;
    }
    
    .back_btn {
    	width: 140px;
    	height: 40px;
    	background: #f5f5f5;
    	color: black;
    	text-align: center;
    	line-height: 40px;
    	border-radius: 5px;
    	cursor: pointer;
    }
    
    .reg_btn {
    	width: 140px;
    	height: 40px;
    	background: #2c2c2c;
    	color: white;
    	text-align: center;
    	line-height: 40px;
    	border-radius: 5px;
    	cursor: pointer;
    }
    
    .plus-button {
	    width: 24px;
	    height: 24px;
	    background-color: #eee;
	    border: none;
	    border-radius: 2px;
	    color: #007aff;
 	    font-size: 24px;
	    cursor: pointer;
 	    display: flex;
 	    justify-content: center; 
 	    align-items: center;
 	    transition: background-color 0.3s;
	    font-weight: 400;
	}
    
    
</style>

</head>
<body>

<div class="container">
	<h2>제품 등록하기</h2>
	<h5>침구제품 등록하기</h5>
    <form action="/product/register" method="post" enctype="multipart/form-data">
        <input class="ipt" type="text" id="productName" name="productName" placeholder="제품이름" required>
        <input class="ipt" type="text" id="modelNumber" name="modelNumber" placeholder="모델번호" required>
	</form>
	
    <label for="category" style="margin: 14px 0 5px 0; font-size: 14px;">카테고리</label>
	<form>
        <select class="ipt" id="category" name="category"  style="color: black;" required>
            <option value="침구">침구</option>
            <option value="가구">가구</option>
            <option value="의류">의류</option>
        </select>
        <input class="ipt" type="text" id="manufacturer" name="manufacturer" placeholder="제조사">
	</form>

	<form>
        <textarea id="description" name="description" rows="5" placeholder="제품설명"></textarea>
	</form>
	<form>
		<input type="checkbox" checked>
        <label for="productImage"> 제품 대표이미지 첨부하기</label>
	</form>
	<form class="ipt4" action="/product/register" method="post" enctype="multipart/form-data">
        <input class="ipt" type="text" id="productName" name="productName" placeholder="정가" required>
        <input class="ipt" type="text" id="modelNumber" name="modelNumber" placeholder="판매가" required>
	</form>
	<form style="margin-top: 8px;">
        <select class="ipt" id="category" name="category" style="color: black;" required>
            <option value="배송방법">배송방법</option>
            <option value="택배">택배</option>
            <option value="퀵서비스">퀵서비스</option>
            <option value="직접수령">직접수령</option>
        </select>
        <input class="ipt" type="text" id="manufacturer" name="manufacturer" placeholder="제조사">
	</form>
	<fieldset class="border p-4 imageForm">
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

	<form style="margin-top: 60px; float: right;">
        <p class="back_btn" style="float: left; margin-right: 12px;">돌아가기</p>
        <p class="reg_btn" style="float: right;">제품 등록하기</p>
    </form>
</div>
</body>
</html>