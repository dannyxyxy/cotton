<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
	<body>
		<h2>파일 업로드 </h2>
			<form action="exUploadPost" Method="Post" enctype="Multipart/Form-data">
			<!-- name 이 같으면 하나의 리스트에 담을 수 있다. -->
				첨부파일1: <input type="file" name="files"><br>
				첨부파일2: <input type="file" name="files"><br>
				첨부파일3: <input type="file" name="files"><br>
				첨부파일4: <input type="file" name="files"><br>
				첨부파일5: <input type="file" name="files"><br>
				<!-- form 태그 안에 있는 버튼은 submit이 defaults 타입이다 -->
				<button>전송</button>
			</form>
	</body>
</html>