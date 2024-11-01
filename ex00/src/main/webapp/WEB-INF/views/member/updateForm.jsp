<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
   xmlns:f="http://java.sun.com/jsf/core"
   xmlns:h="http://java.sun.com/jsf/html">
<head>
<title>Profile</title>

<style>
.profileImgSpace {
	display: flex; /* Flexbox 사용 */
	flex-direction: column; /* 세로 방향 정렬 */
	justify-content: center; /* 수직 중앙 정렬 */
	align-items: center; /* 수평 중앙 정렬 */
	margin-bottom: 20px; /* 아래쪽 여백 추가 */
}

.profileImgBox {
	padding: 10px;
}

/* .profileImgBtn { */
/* 	background-color: #333; */
/* 	color: white; */
/* 	border: none; /* 버튼 테두리 제거 */
/* 	border-radius: 20px; /* 모서리 둥글게 */
/* 	cursor: pointer; */
/* 	padding: 5px 20px; */
/* } */

.input-file-button {
	background-color: #333;
	color: white;
	border: none; /* 버튼 테두리 제거 */
	border-radius: 20px; /* 모서리 둥글게 */
	cursor: pointer;
	padding: 5px 20px;
}

.memberInfoSpace {
	
}

.misHeader {
	align-items: center; /* 수평 중앙 정렬 */
	height: 100px;
	margin: 0px;
}

.misTopBody {
	height: 150px;
}

.misBottomBody {
	height: 150px;
}

.memberStatusInputBox {
	width: 80%;
	height: 50px;
	padding: 5px;
	border: 1px solid #ddd;
	border-radius: 50px;
	display: flex;
}

.memeberStatusTextInput[type="text"], input[type="tel"], input[type="email"],
	input[type="date"] {
	width: 85%;
	height: 100%;
	padding: 0px;
	border: none;
	box-sizing: border-box;
	margin-left: 5%;
	margin-right: 2%;
}

.memeberStatusSelectInput[type="text"], select {
	width: 90%;
	height: 100%;
	padding: 0px;
	border: none;
	box-sizing: border-box;
	margin-left: 5%;
	margin-right: 2%;
}

.memberStatusInputClearBtn {
	border-radius: 50px;
	border: none;
	background-color: #ffffff;
}

.memberStatusBirthdayInputBtn {
	width: 15%;
	height: 100%;
	padding: 0px;
	border: none;
	border-radius: 50px;
	background-color: #ffffff;
}

.memberStatusAdressInputBtn {
	width: 15%;
	height: 100%;
	padding: 0px;
	border: none;
	border-radius: 50px;
	background-color: #ffffff;
}

.memberStatusLabel {
	font-weight: bold;
	margin-bottom: 5px;
	padding: 0px;
}

.misFooter {
	height: 200px;
}

.misFooterBtnSpace {
	float: right;
}

.updateBtn { /* 세부정보 변경 버튼*/
	background-color: #ccc;
	color: #333;
	border: 1px solid #ddd;
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer;
	padding: 10px 40px;
	margin: 7px;
}

.cancleBtn { /* 세부정보 변경 취소 버튼*/
	background-color: #333;
	color: white;
	border: none; /* 버튼 테두리 제거 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer;
	padding: 10px 40px;
	margin: 7px;
}
</style>

<script>
$(function(){
	
	let now = new Date();
	let startYear = now.getFullYear();
	let yearRange = (startYear - 100) + ":" + (startYear);
	// 날짜 입력 설정
	$(".datepicker").datepicker(
				{
					// 입력란의 데이터 포맷
					dateFormat : "yy-mm-dd",
					// 월 선택 추가
					changeMonth : true,
					// 년 선택 추가
					changeYear : true,
					// 월 선택 입력(기본:영어->한글)
					monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
							"7월", "8월", "9월", "10월", "11월", "12월" ],
					// 달력의 요일 표시 (기본:영어->한글)
					dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
					// 선택할 수 있는 년도의 범위
					yearRange : yearRange//,
					//showOn: "button"
				});

	// 생년월일은 현재날짜 이전만 입력가능
	$("#birthdate").datepicker("option", {
		"maxDate" : new Date()
	});
	
	$(".memberStatusAdressInputBtnClick").click(function(){		  
		alert("주소 입력 버튼.");
 	});
	
});
</script>

</head>
      <body>
      <div class="container">
      	<form action="/member/update.do" method="post" enctype="multipart/form-data">
      		<div class="profileImgSpace">
      			<div class="profileImgBox">
 				<img alt="프로필" src="${login.photo}"
                     class="rounded-circle" alt="프로필 이미지" width="100" height="100" />
                </div>
                <h2 style="margin-top: 10px; margin-bottom: 5px;">${login.id }</h2>                
                <label class="input-file-button" for="input-file">
					사진변경
				</label> 
				<input type="file" id="input-file" name="imageMain" style= "display: none;"/>
				 <!-- 버튼을 눌렀을때 사진을 고르는 모달창 나오게 하기 -->
           	</div>
           		<div class="misHeader">
           			<h2>계정관리</h2>
           			<h2 style= "font-size: 24px;">프로필 세부정보 변경</h2>
           		</div>
           		<div class="misTopBody">
					<div class="row">
						<div class="col">
							<form>
								<div> <label class="memberStatusLabel" for="name">이름</label></div> 
								<div class=memberStatusInputBox>
	                     			<input class="memeberStatusTextInput" type="text" id="name" name="name" value="${login.name}"
	                     				maxlength="20" placeholder="이름" required />
	                     			<button type="button" class="memberStatusInputClearBtn" onclick= "reset()"><i class="fa fa-close"></i></button>
	                     		</div>
							</form>
						</div>
						<div class="col">
							<div> <label class="memberStatusLabel" for="birthdate">생년월일</label> </div>
							<div class=memberStatusInputBox>
								<input class="memeberStatusTextInput datepicker" type="text" id="birthdate" name="birthdate" value="${vo.birth}" 
									placeholder="1997-04-17" required/>
							</div>
						</div>

						<div class="col">
							<div> <label class="memberStatusLabel" for="gender">성별</label> </div>
							<div class=memberStatusInputBox>
								<select class="memeberStatusSelectInput" id="gender" name="gender">
									<option value="">성별선택</option>
									<option value="남자">남자</option>
									<option value="여자">여자</option>
								</select>
							</div> 
						</div>
						
					</div>
           		</div>
           		<div class="misBottomBody">
					<div class="row">
						<div class="col">
							<form>
								<div> <label class="memberStatusLabel" for="email">이메일</label> </div>
	                       		<div class=memberStatusInputBox>	
	                       			<input class="memeberStatusTextInput" type="email" id="email" name="email" value="${vo.email}" 
	                       				maxlength="20" placeholder="이메일" required/>
	                       			<button type="button" class="memberStatusInputClearBtn" onclick= "reset()"><i class="fa fa-close"></i></button>
								</div>
							</form>
						</div>
						
						<div class="col">
							<form>
								<div> <label class="memberStatusLabel" for="phone">휴대폰</label> </div>
	                        	<div class=memberStatusInputBox>
	                        		<input class="memeberStatusTextInput" type="tel" id="tel" name="tel" value="${vo.tel}" 
	                        			maxlength="13" placeholder="휴대폰" required/>
	                        		<button type="button" class="memberStatusInputClearBtn" onclick= "reset()"><i class="fa fa-close"></i></button>
								</div>
							</form>
						</div>
						
						<div class="col">
							<div> <label class="memberStatusLabel" for="adress">주소지</label> </div>
							<div class=memberStatusInputBox>
								<input class="memeberStatusTextInput" type="text" id="adress" name="adress" value="${vo.adress}" />
								<button type="button" class="memberStatusAdressInputBtn memberStatusAdressInputBtnClick">
									<img src="${pageContext.request.contextPath}/upload/icon/right-angle.png"
                     						class="rounded-circle" alt="icon" width="100%" height="100%" />
								</button>
							</div>
						</div>
					</div>
           		</div>
           		<div class="misFooter">
           			<div class="misFooterBtnSpace">
           			<button type="submit" class="updateBtn" onclick="alert('변경버튼 클릭');">변경</button>
           			<button type="button" class="cancleBtn" onclick="history.back();">취소</button>
           		</div>
           	</div>
        </form>
      </div>
         
      </body>
</html>
