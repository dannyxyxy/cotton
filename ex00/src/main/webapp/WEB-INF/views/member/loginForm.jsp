<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
  <!--   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <style>
       
        .LoginAll {
            max-width: 400px;
            margin: 0 auto;
            text-align: center;
            margin-top: 100px;
            align-items: center;
           
        }
        .loginInput {
            width: 40%;
            margin: 0 auto;
            align-items: center;
        }
        .loginText {
        	text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 40px;
        }
        .id,
        .pw {
            border-radius: 0;
            height: 50px;
            font-size: 1rem;
        }
        .btn-primary {
            background-color: #C9B89E;
            border: none;
            height: 50px;
            font-size: 1.2rem;
            font-weight: bold;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #B8A88D;
        }
        .signup-link {
        	text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }
        .signup-link a {
            color: #5A8F60;
            font-weight: bold;
        }
    </style>
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

