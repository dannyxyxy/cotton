<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .writeAll{
        	width: 60%
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"],
        select,
        button {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }

        .alert {
            margin-top: 5px;
            font-size: 0.9em;
        }

        .alert-success {
            color: green;
        }

        .alert-danger {
            color: red;
        }

        .btn-secondary {
            background-color: #e0e0e0;
            color: #333;
            margin-right: 10px;
        }

        .btn-secondary:hover {
            background-color: #ccc;
        }

        .flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .half-width {
            width: 48%;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker({
                dateFormat: "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                yearRange: "1900:c",
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"]
            });
        });
    </script>
</head>
<body>
<decorator:body> <!--  -->
   <div class="container writeAll">
        <h2>회원가입</h2>
        <form action="/member/write.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" maxlength="20" placeholder="아이디 4~20자 입력해주세요." required>
                <div id="checkIdDiv" class="alert alert-danger">중복 확인 후 아이디 사용가능 불가능 표시</div>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" maxlength="20" placeholder=" 비밀번호 6~20자 입력해주세요." required>
            </div>
            <div class="form-group">
                <label for="pw2">비밀번호 확인</label>
                <input type="password" id="pw2" name="pw2" maxlength="20" placeholder="비밀번호 확인 6~20자 입력해주세요." required>
                <div id="pw2Div" class="alert alert-danger">비밀번호 확인 후 일치 불일치 표시</div>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" maxlength="10" placeholder="이름" required>
            </div>
            <div class="form-group">
                <label for="tel">전화번호</label>
                <input type="text" id="tel" name="tel" placeholder="전화번호" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="이메일" required>
            </div>
            <div class="form-group flex">
                <div class="half-width">
                    <label for="birth">생년월일</label>
                    <input type="text" id="birth" name="birth" class="datepicker" placeholder="YYYY-MM-DD" required>
                </div>
                <div class="half-width">
                    <label for="gender">성별</label>
                    <select id="gender" name="gender">
                        <option value="">성별</option>
                        <option value="남자">남자</option>
                        <option value="여자">여자</option>
                    </select>
                </div>
            </div>
            <div class="form-group flex">
            	<br>
            	<br>
                <button type="button" class="btn-secondary" onclick="history.back()">취소</button>
                <button type="submit">회원 가입</button>
            </div>
        </form>
  </div>
</decorator:body>
</body>
</html>