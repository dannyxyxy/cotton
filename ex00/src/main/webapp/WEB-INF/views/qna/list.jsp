<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>문의글 리스트</title>
<link rel="stylesheet" href="/resources/css/qna/list.css">
</head>
<body>
	<div class="container">
		<h2>고객문의</h2>
		<p>문의사항을 작성해주세요</p>
		<c:forEach items="${list}" var="vo">
			<a href="view.do?no=${vo.no}" class="card">
				<div class="card-body" style="padding: 0px">
					<div class="row">
						<div class="col-2">
							<img src="${vo.image_name}" style="height: 170px"></img>
						</div>
						<div class="col-8" style="padding: 20px;">
							<h4 class="card-title">${vo.title}</h4>
							<p class="card-text">${vo.content}</p>
						</div>
						<div class="col-2" style="padding: 20px;">
							<p style="margin-left: auto;">
								<fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" />
							</p>
							<p>작성자 : ${vo.id}</p>
							<p>상품 코드 : ${vo.goods_code}</p>
						</div>
					</div>
				</div>
			</a>
		</c:forEach>
		<span class="paginationBox"> 
			<pageNav:adminPageNav listURI="list.do" pageObject="${pageObject}"></pageNav:adminPageNav>
		</span>
		<div class="btnBox">
			<a href="writeForm.do" class="writeBtn" style="margin-left: auto;">글쓰기</a>
		</div>
	</div>
</body>
</html>
