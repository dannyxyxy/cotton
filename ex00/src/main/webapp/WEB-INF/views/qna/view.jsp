<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 보기</title>
<link rel="stylesheet" href="/resources/css/qna/view.css">
</head>
<body>
	<div class="container">
		<div class="qnaInfo">
			<p style="margin-right: 10px; font-size: 16px;">글번호 : ${vo.no}</p>
			<p style="margin-right: 10px; font-size: 16px;">상품 코드 :
				${vo.goods_code}</p>
			<p style="margin-right: 10px; font-size: 16px;">작성자 : ${vo.id}</p>
			<p style="margin-left: auto; font-size: 16px;">
				작성일 :
				<fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" />
			</p>
		</div>

		<!-- 제목 영역 -->
		<div class="title-container">
			<h2 style="margin: 0 10px; font-size: 20px;">제목</h2>
			<span class="title-box">${vo.title}</span>
		</div>

		<!-- 본문 내용 -->
		<div class="content-box" style="height: 500px">
			<!-- 본문 첨부 이미지 -->
			<div class="col-4">
				<img src="${vo.qna_image_name}" style="width: 100%"></img>
				<!-- 				<img src="/upload/image/attach.png" style="width: 100%"></img> -->
				<div style="font-size: 25px; margin-top: 20px;">상품명 :
					${vo.goods_name}</div>
			</div>
			<!-- 본문 내용 -->
			<div class="col-8">
				<span style="font-size: 25px;"> ${vo.content} </span>
			</div>
		</div>

		<!-- 문의글 버튼 영역 -->
		<div class="btnBox">
			<!-- 어드민 (gradeNo == 9) -->
			<c:if test="${gradeNo == 9}">
				<button type="button" style="margin-left: auto;" class="cancelBtn"
					onclick="location.href='/qna/list.do'" id="cancelBtn">돌아가기</button>
				<button type="button" class="registerBtn"
					onclick="location.href='updateForm.do?no=${vo.no}'">수정</button>
				<a href="/qna/delete.do?no=${vo.no}" class="deleteBtn"
					onclick="return confirm('정말 이 게시글을 삭제하시겠습니까?')">삭제</a>
			</c:if>

			<!-- 작성자 본인 (일반회원이면서 userId == vo.id) -->
			<c:if test="${gradeNo != 9 && userId == vo.id}">
				<button type="button" style="margin-left: auto;" class="cancelBtn"
					onclick="location.href='/qna/list.do'" id="cancelBtn">돌아가기</button>
				<button type="button" class="registerBtn"
					onclick="location.href='updateForm.do?no=${vo.no}'">수정</button>
				<a href="/qna/delete.do?no=${vo.no}" class="deleteBtn"
					onclick="return confirm('정말 이 게시글을 삭제하시겠습니까?')">삭제</a>
			</c:if>
		</div>
		<c:choose>
			<%-- 일반 회원일 때 답변창 표시 조건 --%>
			<c:when test="${gradeNo == 1 && vo.replyContent != null}">
				<%-- 일반 회원일 때 답변창이 채워져 있으면 표시 --%>
				<!-- 답변 영역 -->
				<div style="margin-top: 50px">
					<div class="title-container">
						<h2 style="margin: 0 10px; font-size: 20px;">답변</h2>
						<p style="margin: 0px; font-size: 16px;">빠르게 확인하여 답변 남겨드리겠습니다.</p>
						<p style="margin-left: auto; font-size: 16px;">
							답변일 :
							<fmt:formatDate value="${vo.replyDate}" pattern="yyyy-MM-dd" />
						</p>
					</div>

					<div class="content-box" style="height: 300px;">
						<span style="font-size: 25px;"> ${vo.replyContent} </span>
					</div>
				</div>
			</c:when>

			<%-- 어드민일 때 답변창 표시 조건 --%>
			<c:when test="${gradeNo == 9}">
				<form action="updateReply.do" method="post">
					<input type="hidden" name="perPageNum" value="${param.perPageNum }" />
					<input type="hidden" name="no" value="${param.no }" />
					<!-- 답변창 표시 및 내용 여부 확인 -->
					<div class="reply-content">
						<!-- 답변 내용이 존재할때  -->
						<c:if test="${vo.replyContent != null}">
							<!-- 답변 영역 -->
							<div style="margin-top: 50px">
								<div class="title-container">
									<h2 style="margin: 0 10px; font-size: 20px;">답변</h2>
									<p style="margin: 0px; font-size: 16px;">빠르게 확인하여 답변
										남겨드리겠습니다.</p>
									<p style="margin-left: auto; font-size: 16px;">
										답변일 :
										<fmt:formatDate value="${vo.replyDate}" pattern="yyyy-MM-dd" />
									</p>
								</div>

								<div class="content-box" style="height: 300px;">
									<textarea class="form-control box content" rows="7"
										id="replyContent" name="replyContent" required>${vo.replyContent } </textarea>
								</div>

								<div class="btnBox">
									<button type="button" style="margin-left: auto;"
										class="cancelBtn" onclick="history.back()" id="cancelBtn">취소</button>
									<button type="submit" class="registerBtn">수정</button>
								</div>
							</div>
						</c:if>
						<!-- 답변 내용이 존재하지 않을때  -->
						<c:if test="${vo.replyContent == null}">
							<!-- 답변 영역 -->
							<div style="margin-top: 50px">
								<div class="title-container">
									<h2 style="margin: 0 10px; font-size: 20px;">답변</h2>
									<p style="margin: 0px; font-size: 16px;">빠르게 확인하여 답변
										남겨드리겠습니다.</p>
									<p style="margin-left: auto; font-size: 16px;">
										답변일 :
										<fmt:formatDate value="${vo.replyDate}" pattern="yyyy-MM-dd" />
									</p>
								</div>

								<div class="content-box" style="height: 300px;">
									<textarea class="form-control box content" rows="7"
										id="replyContent" name="replyContent" required
										placeholder="답변을 입력해주세요.">${vo.replyContent}</textarea>
								</div>

								<div class="btnBox">
									<button type="button" style="margin-left: auto;"
										class="cancelBtn" onclick="history.back()" id="cancelBtn">취소</button>
									<button type="submit" class="registerBtn">등록</button>
								</div>
							</div>
						</c:if>
					</div>
				</form>
			</c:when>
		</c:choose>
	</div>
</body>
</html>