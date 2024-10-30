<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.loginAll{
		text-align: center;		
	}
	.form-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    }
    input[type="text"],
	input[type="password"] {
    width: 50%; 
    padding: 25px;
    margin: 5px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

</style>

<script type="text/javascript">

$(function(){
	$(".writeBtn").click(function(){
		//alert("회원가입 틀릭");
		
		location="writeFormTest.do";
		
	});
	
});

</script>

</head>
<body>
<div class="container mt-5 loginAll">
        <h3>로그인</h3>
        <form action="login.do" method="post">
            <div class="form-group">
                <label for="id"></label>
                <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required>

                <label for="password"></label>
                <input type="password" class="form-control" name="pw" id="pw" placeholder="비밀번호" required>
            </div>           
            <button class="btn btn-primary mt-2 float-right">로그인</button><button class="btn btn-success mt-2 writeBtn float-right">회원가입</button> 
        </form>
    </div>
</body>
</html>