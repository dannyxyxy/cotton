<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>

    <link rel="stylesheet" href="/resources/css/member/updateForm.css">


    <script>
    $(function(){
        let now = new Date();
        let startYear = now.getFullYear();
        let yearRange = (startYear - 100) + ":" + (startYear);
        // 날짜 입력 설정
        $(".datepicker").datepicker({
            dateFormat : "yy-mm-dd",
            changeMonth : true,
            changeYear : true,
            monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
            dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
            yearRange : yearRange
        });

        // 생년월일은 현재날짜 이전만 입력 가능
        $("#birthdate").datepicker("option", { "maxDate" : new Date() });

        // 파일 선택 시 파일 이름을 버튼에 표시
        document.getElementById('input-file').addEventListener('change', function() {
            const fileName = this.files[0]?.name || "사진변경";
            document.querySelector('label[for="input-file"]').textContent = fileName;
        });
    });

    function validateForm() {
        const name = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const tel = document.getElementById('tel').value.trim();
        
        if (name === '' || email === '' || tel === '') {
            alert('모든 필수 항목을 입력해주세요.');
            return false;
        }
        return true;
    }

    
    </script>
</head>
<body>

  <div class="container">
    <form action="/member/update.do" method="post" enctype="multipart/form-data" onsubmit="return handleImageChange()">
        <!-- 프로필 사진 부분 -->
        <div class="profileImgSpace">
            <div class="profileImgBox">
                <img id="profile-preview" 
                     src="${login.photo}"
                     class="rounded-circle" alt="프로필 이미지" width="100" height="100" />
            </div>
            <h2 style="margin-top: 10px; margin-bottom: 5px;">${login.id }</h2>                
            <label class="input-file-button" for="input-file">
                사진변경
            </label> 
            <input type="file" id="input-file" name="profileImage" style="display: none;" onchange="previewImage(event)" />
            <input type="hidden" name="existingPhoto" value="${login.photo}" />
        </div>

        <!-- 회원 정보 입력 부분 -->
        <div class="misHeader">
            <h2>계정관리</h2>
            <h2 style= "font-size: 24px;">프로필 세부정보 변경</h2>
        </div>
        <div class="misTopBody">
            <div class="row">
                <div class="col">
                    <div> <label class="memberStatusLabel" for="name">이름</label></div> 
                    <div class="memberStatusInputBox">
                        <input class="memberStatusTextInput" type="text" id="name" name="name" value="${memberVO.name}"
                            maxlength="20" placeholder="이름" required />
                    </div>
                </div>
                <div class="col">
                    <div> <label class="memberStatusLabel" for="birthdate">생년월일</label> </div>
                    <div class="memberStatusInputBox">
                        <input class="memberStatusTextInput datepicker" type="text" id="birthdate" name="birth"
                         value='<fmt:formatDate value="${memberVO.birth }" pattern="yyyy-MM-dd"/>' 
                            required/>
                    </div>
                </div>
                <div class="col">
                    <div> <label class="memberStatusLabel" for="gender">성별</label> </div>
                    <div class="memberStatusInputBox">
                        <select class="memberStatusSelectInput" id="gender" name="gender">
                            <option value="">성별선택</option>
                            <option value="남자" ${memberVO.gender == '남자' ? 'selected' : ''}>남자</option>
                            <option value="여자" ${memberVO.gender == '여자' ? 'selected' : ''}>여자</option>
                        </select>
                    </div> 
                </div>
            </div>
        </div>

        <div class="misBottomBody">
            <div class="row">
                <div class="col">
                    <div> <label class="memberStatusLabel" for="email">이메일</label> </div>
                    <div class="memberStatusInputBox">
                        <input class="memberStatusTextInput" type="email" id="email" name="email" value="${memberVO.email}"
                            maxlength="20" placeholder="이메일" required/>
                    </div>
                </div>

                <div class="col">
                    <div> <label class="memberStatusLabel" for="tel">휴대폰</label> </div>
                    <div class="memberStatusInputBox">
                        <input class="memberStatusTextInput" type="tel" id="tel" name="tel" value="${memberVO.tel}"
                            maxlength="13" placeholder="휴대폰" required/>
                    </div>
                </div>

                <div class="col">
                    <div> <label class="memberStatusLabel" for="address">주소지</label> </div>
                    <div class="memberStatusInputBox">
                        <input class="memberStatusTextInput" type="text" id="address" name="address" value="${memberVO.address}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="misFooter">
            <div class="misFooterBtnSpace">
                <button type="submit" class="updateBtn">변경</button>
                <button type="button" class="cancleBtn" onclick="history.back();">취소</button>
            </div>
        </div>
    </form>
</div>

<script>
    // 이미지 미리보기
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function () {
            const output = document.getElementById('profile-preview');
            output.src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    // 폼 제출 시 기존 사진 처리
    function handleImageChange() {
        const inputFile = document.getElementById('input-file');
        if (!inputFile.value) {
            // 파일이 선택되지 않은 경우 기존 사진 유지
            document.querySelector('input[name="existingPhoto"]').disabled = false;
        }
        return true;
    }
</script>

</body>
</html>
