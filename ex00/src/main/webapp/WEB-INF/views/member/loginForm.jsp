<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
  <!--   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

    <link rel="stylesheet" href="/resources/css/member/loginForm.css">


</head>
<body>

    <div class="container loginAll">
        <h3 class="loginText">로그인</h3>
        <form action="login.do" method="post" class="loginInput">
            <div class="form-group">
                <input type="text" class="form-control id" name="id" id="id" placeholder="아이디" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control pw" name="pw" id="pw" placeholder="비밀번호" required>
            </div>
            <button class="btn btn-primary mt-2 loginBtn">로그인</button>
        </form>
        <div class="signup-link">
            아직 회원이 아니신가요? <a href="writeForm.do">회원가입</a> 해주세요.
        </div>
    </div>
</body> 
</html>

