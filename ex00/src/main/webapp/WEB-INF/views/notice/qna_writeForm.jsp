<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 쓰기</title>



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
    .box {
    	width: 49%;
    }
    
    .opt1 {
    	float: left;
    	width: 49%;
    	padding-left: 10px;
    	color: black;
    }
    
    .opt2 {
    	float: left;
    	width: 49%;
    	height: 38px;
    	margin-top: 16px;
    	padding-left: 10px;
    	color: black;
    }
    
    .imageForm {
    	width: 100%;
    	border-radius: .25rem;
    }
    
    .content {
    	width: 100%;
    }
    
    .ipt {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 1rem;
	    border: 1px solid #ccc;
	    border-radius: .25rem;
	    font-size: 14px;
	}
	
	#appendImageBtn {
		width: 24px;
		height: 24px;
		padding: 0;
		line-height: 0;
	}
	
	.btnBox {
		margin: 20px 0 0 0;
		height: 100px;
	}
    
    .cancelBtn {
    	width: 150px;
    	height: 40px;
    	float: right;
    	margin-right: 20px;
    	border: none;
    	border-radius: .25rem;
    	font-size: 14px;
    }
    
    .registerBtn {
    	width: 150px;
    	height: 40px;
    	float: right;
    	border: none;
    	border-radius: .25rem;
    	font-size: 14px;
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

	<!-- <div class="container">	
		<h2>제품 등록하기</h2>
		<h5>침구제품 등록하기</h5>
	    <form action="/product/register" method="post" enctype="multipart/form-data">
	        <input class="ipt" type="text" id="productName" name="productName" placeholder="제품이름" required>
	        <input class="ipt" type="text" id="modelNumber" name="modelNumber" placeholder="모델번호" required>
		
	    	<label for="category">카테고리</label>
	        <select class="ipt" id="category" name="category"  style="color: black;" required>
	            <option value="침구">침구</option>
	            <option value="가구">가구</option>
	            <option value="의류">의류</option>
	        </select>
	        <input class="ipt" type="text" id="manufacturer" name="manufacturer" placeholder="제조사">
	
	        <textarea id="description" name="description" rows="5" placeholder="제품설명"></textarea>
			
			<input type="checkbox" checked>
	        <label for="productImage"> 제품 대표이미지 첨부하기</label>
	        <input class="ipt" type="text" id="productName" name="productName" placeholder="정가" required>
	        <input class="ipt" type="text" id="modelNumber" name="modelNumber" placeholder="판매가" required>
	        <select class="ipt" id="category" name="category" style="color: black;" required>
	            <option value="배송방법">배송방법</option>
	            <option value="택배">택배</option>
	            <option value="퀵서비스">퀵서비스</option>
	            <option value="직접수령">직접수령</option>
	        </select>
	        <input class="ipt" type="text" id="manufacturer" name="manufacturer" placeholder="제조사">
	
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
	
	        <button class="back_btn">돌아가기</button>
	        <button class="reg_btn">제품 등록하기</button>
	    </form>
	</div> -->


	<div class="container">
	  <h2>문의 글 쓰기</h2>
	  <form action="write.do" method="post" enctype="multipart/form-data">
		  <input type="hidden" name="perPageNum" value="${param.perPageNum }" />
	      <label for="name" style="color: #ccc;">문의사항을 남겨주세요! 순차적으로 확인 도와드리겠습니다.</label>
		    <div class="form-group">
		      <input type="text" class="form-control box" id="name" pattern="^[^ .].{2.99}$" required
		      		placeholder="글제목" name="name" style="float: left;">
		      <input type="text" class="form-control box" id="name" pattern="^[^ .].{2.99}$" required
		      		placeholder="모델번호" name="name" style="float: right;">
		    </div>
		    
		    <label for="name" style="margin: 16px 0 4px 0;">공개글/비공개글</label>
		    <div class="form-group">
		      <select class="form-control box opt1">
		      	<option value="비공개글">비공개글</option>
		      	<option value="공개글">공개글</option>
		      </select>
		    </div>
		    
		    <div class="form-group" style="margin-top: 60px;">
		      <textarea class="form-control box content" rows="7" id="content" name="content"
		      		placeholder="제품설명" required></textarea>
		    </div>
		    
		    <b style="font-size: 14px;">제품 대표이미지 첨부하기</b>
			<input type="file" class="form-control" name="imageFiles" style="height: 100%; margin: 5px 0 20px 0;">
		    
		    
		    <!-- <fieldset class="border p-4 imageForm">
				<legend class="w-auto px-2">
					<b style="font-size: 14px">상세이미지 첨부하기</b>
					<button class="btn btn-primary" id="appendImageBtn" type="button">
						+
					</button>
				</legend>
				<div class="input-group mb-3">
				  <input type="file" class="form-control" name="imageFiles" style="height: 100%;">
				  <input class="form-control" name="imageFiles" type="file" id="input-file" style="font-size: 14px;">
				</div>
			</fieldset> -->
			
		    <div class="form-group btnBox">
			    <button type="button" class="registerBtn">문의 등록하기</button>
			    <button type="submit" class="cancelBtn" onclick="history.back()" id="cancelBtn">돌아가기</button>
		    </div>
	  </form>
	</div>

</body>
</html>