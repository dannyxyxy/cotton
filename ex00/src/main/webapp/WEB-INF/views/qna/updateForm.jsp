<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 수정</title>

<link rel="stylesheet" href="/resources/css/qna/view.css">
</head>
<body>

	<div class="container">
		<h2>문의 글 수정</h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }" />
			<input type="hidden" name="no" value="${param.no }" /> 
			<label for="title" style="color: #ccc;">문의사항을 남겨주세요! 순차적으로 확인 도와드리겠습니다.</label>

			<div class="form-group">
				<input type="text" class="form-control box" id="title"
					pattern="^[^ .].{2,99}$" required value="${vo.title }" name="title"
					style="float: left;" title="제목을 입력하세요. 최소 3자 이상이어야 합니다."> 
				<input type="text" class="form-control box" id="goods_code"
					pattern="^[^ .].{2,99}$" required value="${vo.goods_code }"
					name="goods_code" style="float: right;"
					title="상품 코드를 입력하세요. 최소 3자 이상이어야 합니다.">
			</div>

			<div class="form-group" style="margin-top: 20px;">
				<textarea class="form-control box content" rows="7" id="content"
					name="content" title="내용을 입력해주세요." required>${vo.content } </textarea>
			</div>

			<div style="margin-top: 10px;">
				<b style="font-size: 14px;">문의 관련 이미지 첨부하기</b> 
				<input type="file" class="form-control" name="imageFile"
					style="height: 100%; margin: 5px 0 20px 0;" onchange="displayFileName(this)">
			</div>

			<div class="form-group btnBox">
				<button type="submit" class="registerBtn">수정하기</button>
				<button type="button" class="cancelBtn" onclick="history.back()" id="cancelBtn">돌아가기</button>
			</div>
		</form>
	</div>
</body>
</html>
