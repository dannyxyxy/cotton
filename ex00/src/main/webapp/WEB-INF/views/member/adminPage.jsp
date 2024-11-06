<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>adminPage</title>
<link rel="stylesheet" href="/resources/css/member/adminPage.css">
<script>
	// 현재 활성화된 폼을 추적하기 위한 변수
	let activeForm = null;
	
	// 폼을 클릭했을 때 활성화 설정
    function setActiveForm(form) {
        // 이전 활성화된 폼이 있다면 비활성화
        if (activeForm) {
            activeForm.classList.remove("active");
        }
        // 새 폼을 활성화 상태로 설정
        activeForm = form;
        activeForm.classList.add("active");
        console.log("활성화된 폼:", activeForm); // 디버깅용 콘솔 로그
    }

    // "변경" 버튼 클릭 시 활성화된 폼만 제출
    function submitActiveForm(event) {
        if (activeForm) {
            activeForm.submit();
        } else {
            alert("수정할 회원을 선택해주세요.");
        }
    }
</script>
</head>
<body>
<div class="container" style="padding: 0px;">
   <div class="misHeader">
      <h2>회원 리스트 관리</h2>
      <h2 style="font-size: 24px;">관리자용 회원관리 리스트</h2>
   </div>

   <div class="misTitleBody">
      <div><!-- <h2>공백</h2> --></div>
      <div class="profileSpace"><h2 style="font-size: 23px;">프로필</h2></div>
      <div class="idSpace"><h2 style="font-size: 23px;">아이디</h2></div>
      <div class="nameSpace"><h2 style="font-size: 23px;">이름</h2></div>
      <div class="birthSpace"><h2 style="font-size: 23px;">생년월일</h2></div>
      <div class="telSpace"><h2 style="font-size: 23px;">연락처</h2></div>
      <div class="gradeSpace"><h2 style="font-size: 23px;" align="center">등급</h2></div>
      <div class="statusSpace"><h2 style="font-size: 23px;" align="center">상태</h2></div>
      <div><!-- <h2>공백</h2> --></div>
   </div>

      <c:forEach items="${list}" var="vo">
         <div class="member-row">
            <form action="/member/updateStatus" method="post"
               class="styled-form" onclick="setActiveForm(this)">
               <div class="misBody">
                  <input type="hidden" name="id" value="${vo.id}" />
                  <div><!-- <h2>공백</h2> --></div>
                  <div class="profileSpace">
                     <c:if test="${!empty vo.photo}">
                        <img src="${vo.photo}" class="rounded-circle" alt="프로필 이미지"
                           width="60" height="60" />
                     </c:if>
                     <c:if test="${empty vo.photo}">
                        <i class="fa fa-user-circle-o" style="font-size: 30px"></i>
                     </c:if>
                  </div>
                  <div class="idSpace">
                     <h2 style="font-size: 20px;">${vo.id}</h2>
                  </div>
                  <div class="nameSpace">
                     <h2 style="font-size: 20px;">${vo.name}</h2>
                  </div>
                  <div class="birthSpace">
                     <h2 style="font-size: 20px;">
                        <fmt:formatDate value="${vo.birth}" pattern="yyyy-MM-dd" />
                     </h2>
                  </div>
                  <div class="telSpace">
                     <h2 style="font-size: 20px;">${vo.tel}</h2>
                  </div>
                  <div class="gradeSpace">
                     <select name="gradeNo">
                        <option value="1" ${vo.gradeNo == 1 ? "selected" : ""}>일반회원</option>
                        <option value="9" ${vo.gradeNo == 9 ? "selected" : ""}>관리자</option>
                     </select>
                  </div>
                  <div class="statusSpace">
                     <select name="status">
                        <option ${vo.status == "정상" ? "selected" : ""}>정상</option>
                        <option ${vo.status == "탈퇴" ? "selected" : ""}>탈퇴</option>
                        <option ${vo.status == "휴면" ? "selected" : ""}>휴면</option>
                        <option ${vo.status == "강퇴" ? "selected" : ""}>강퇴</option>
                     </select>
                  </div>
                  <div><!-- <h2>공백</h2> --></div>
                  
               </div>
            </form>
         </div>
      </c:forEach>

      <div class="misFooter">
            <div class="misFooterBtnSpace">
              <button type="submit" class="updateBtn" onclick="submitActiveForm()">변경</button>
              <button type="button" class="cancleBtn" onclick="history.back()">취소</button>
            </div>
         </div>

<!--    <div class="paginationBox"> -->
<%--        <pageNav:adminPageNav listURI="adminPage.do" pageObject="${pageObject}"></pageNav:adminPageNav> --%>
<!--    </div> -->
</div>


</body>
</html>