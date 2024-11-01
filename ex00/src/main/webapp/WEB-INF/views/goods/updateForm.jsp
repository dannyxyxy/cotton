<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>



<!-- <script type="text/javascript">
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
</script> -->


<style>
	
	h5 {
		font-size: 18px;
		color: #979797;
	}
	
    .ipt {
    	width: 100%;
    	height: 40px;
    	border-radius: .25rem;
    	border: 1px solid #e8e8e8;
    	color: #black;
    	font-size: 14px;
    	padding-left: 10px;
    	margin-top: 12px;
    }
    
    .form-control {
    	width: 1143px;
    }
    
    .form-group {
    	width: 1143px;
    }
    
    fieldset {
    	width: 1143px;
    	color: black;
    	border-radius: .25rem;
    }
    
    #description {
    	width: 1143px;
    	height: 200px;
    	border: 1px solid #e8e8e8;
    	border-radius: .25rem;
    	padding-left: 10px;
    	margin-top: 12px;
    }
    
    .cancel_btn {
    	width: 140px;
    	height: 40px;
    	background: #f5f5f5;
    	color: black;
    	text-align: center;
    	line-height: 40px;
    	border: none;
    	border-radius: .25rem;
    	cursor: pointer;
    }
    
    .update_btn {
    	width: 140px;
    	height: 40px;
    	margin-right: 16px;
    	background: #2c2c2c;
    	color: white;
    	text-align: center;
    	line-height: 40px;
    	border: none;
    	border-radius: .25rem;
    	cursor: pointer;
    }
    
    .plus-button {
	    width: 24px;
	    height: 24px;
	    background-color: #eee;
	    border: none;
	    border-radius: .25rem;
	    color: #007aff;
 	    font-size: 24px;
	    cursor: pointer;
 	    display: flex;
 	    justify-content: center; 
 	    align-items: center;
 	    transition: background-color 0.3s;
	    font-weight: 400;
	}
    
    .ceo {
    	width: 120px;
    	height: 32px;
    	line-height: 32px;
    	text-align: center;
    	background: #007aff;
    	border-radius: .25rem;
    }
    
</style>

</head>
<body>

<div class="container">
	<h2>제품등록 수정하기</h2>
	<form action="write.do" method="post" enctype="multipart/form-data">
		<div class="form-group">
	         <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" readonly required
			      		title="" placeholder="제품번호" name="name">
	         <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="제품이름" name="name">
	         <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" readonly required
			      		title="" placeholder="모델번호" name="name">
			 <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="제조사" name="name">
		</div>
		
		<fieldset class="border p-4 imageForm">
			<legend class="w-auto px-2">
				<b style="font-size: 14px">대표이미지</b>
				<button class="btn btn-primary btn-sm" id="appendImageBtn" type="button">
					수정
				</button>
			</legend>
			<div class="input-group mb-3">
			  <img alt="" src="https://i.namu.wiki/i/Dh1wj48FlqpDrA7QZMaX7GkbNgmmoctGGyWNl4wucPOdMWvJ8ftgm2fHl1toQYbZl7GhxcagetEyTYyWkEIKXqvbMvfH_S7V91x_R8KfbHvFuW3mCAMP2kS0Z12Sr4GEdzN_QAcBiYW03HRbhWpH8g.webp"
	        		style="width: 15%;">
			</div>
		</fieldset>
		
<!-- 		<div class="form-group"> -->
<!-- 	        <p class="ceo">대표이미지</p> -->
<!-- 	        <div> -->
<!-- 	        	<img alt="" src="https://i.namu.wiki/i/Dh1wj48FlqpDrA7QZMaX7GkbNgmmoctGGyWNl4wucPOdMWvJ8ftgm2fHl1toQYbZl7GhxcagetEyTYyWkEIKXqvbMvfH_S7V91x_R8KfbHvFuW3mCAMP2kS0Z12Sr4GEdzN_QAcBiYW03HRbhWpH8g.webp" -->
<!-- 	        		style="width: 15%; cursor: pointer;"> -->
<!-- 	        </div> -->
<!--         </div> -->
        
        <div class="form-group">
	        <textarea id="description" name="description" rows="5" placeholder="제품설명"></textarea>
	        <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="정가" name="name">
	        <input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="판매가" name="name">
			<input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="배송방법" name="name">
			<input type="text" class="form-control ipt" id="name" pattern="^[^ .].{2.99}$" required
			      		title="필수입력 항목입니다." placeholder="배송비" name="name">
        </div>
        
		<fieldset class="border p-4 imageForm">
			<legend class="w-auto px-2">
				<b style="font-size: 14px">상세이미지</b>
				<button class="btn btn-primary btn-sm" id="appendImageBtn" type="button">
					수정
				</button>
			</legend>
			<div class="input-group mb-3">
			  <input type="file" class="form-control" name="imageFiles">
			</div>
		</fieldset>
		
		<div class="form-group" style="display: flex; justify-content: flex-end; margin-top: 48px;">
		    <button type="submit" class="update_btn">수정</button>
		    <button type="button" class="cancel_btn" onclick="history.back()" id="cancelBtn">취소</button>
	    </div>
    </form>
</div>

</body>
</html>