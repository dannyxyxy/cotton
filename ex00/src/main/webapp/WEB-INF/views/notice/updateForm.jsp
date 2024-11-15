<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>리뷰 수정하기</title>
	
	<jsp:include page="../jsp/webLib.jsp"></jsp:include>


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

.container {
	width: 600px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.title {
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 10px;
}

.review-box {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.review-image {
	width: 100px;
	height: 100px;
	border-radius: 8px;
	margin-right: 15px;
}

.review-content {
	flex-grow: 1;
}

.star-rating {
	color: #f1c40f;
	font-size: 1.2em;
	margin-bottom: 5px;
}

.review-text {
	font-size: 1em;
	color: #333;
}

.review-date {
	color: #aaa;
	font-size: 0.8em;
	margin-top: 5px;
	display: flex;
	align-items: center;
}

.review-date img {
	border-radius: 50%;
	width: 30px;
	height: 30px;
	margin-right: 8px;
}

.edit-section {
	border-top: 1px solid #ddd;
	padding-top: 15px;
}

.star-input {
	font-size: 1.2em;
	color: #ddd;
	margin-bottom: 10px;
}

.review-input {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	font-size: 1em;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.button-group {
	display: flex;
	justify-content: flex-end;
}

.button-group button {
	padding: 10px 20px;
	margin-left: 10px;
	border: none;
	border-radius: 4px;
	font-size: 1em;
	cursor: pointer;
}

.button-group .back-button {
	background-color: #ddd;
}

.button-group .submit-button {
	background-color: #333;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container">
		<div class="title">내 리뷰 수정하기</div>
		<p>내가 쓴 리뷰를 수정해보세요!</p>

		<div class="review-box">
			<img src="https://via.placeholder.com/100" alt="상품 이미지"
				class="review-image">
			<div class="review-content">
				<div class="star-rating">★★★★★</div>
				<div class="review-text">
					사진이 실물 보다 훨 나아요.<br>100% 만족합니다.
				</div>
				<div class="review-date">
					<img src="https://via.placeholder.com/30" alt="유저 프로필 사진"> <span>admin
						&nbsp;|&nbsp; 2024.10.26</span>
				</div>
			</div>
		</div>

		<div class="edit-section">
			<div class="star-input">☆☆☆☆☆ 0.0</div>
			<input type="text" placeholder="리뷰 제목" class="review-input">
			<textarea placeholder="상품 구매 후기를 입력해 주세요." rows="4"
				class="review-input"></textarea>

			<div class="button-group">
				<button class="back-button">돌아가기</button>
				<button class="submit-button">수정</button>
			</div>
		</div>
	</div>

</body>
</html>