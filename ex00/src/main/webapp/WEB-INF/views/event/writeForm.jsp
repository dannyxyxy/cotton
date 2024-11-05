<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이벤트 및 프로모션 등록하기</title>
	<jsp:include page="../jsp/webLib.jsp"></jsp:include>


<style type="text/css">
	.main-content {
	    min-height: calc(100vh - 300px);
	    min-height: 0;
	    padding: 20px;
	    background-color: #fff;
	}

	.container {
	    box-sizing: content-box;
	    margin: 0;
	    pading: 0;
	    margin: auto;
	}
	
	h2 {
	    font-size: 24px;
	    margin-bottom: 10px;
	    color: #333;
	}
	
	label {
	    font-size: 0.9rem;
	    color: #666;
	    margin-bottom: 0.3rem;
	    display: block;
	}
	
	.startBox {
		width: 49%;
		float: left;
	}
	
	#eventStartDate {
		width: 100%;
	}
	
	.endBox {
		width: 49%;
		float: right;
	}
	
	#eventEndDate {
		width: 100%;
	}
	
	.ipt {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 20px;
	    border: 1px solid #ccc;
	    border-radius: .25rem;
	    font-size: 14px;
	}
	
	.lab {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 1rem;
	    border: 1px solid #ccc;
	    border-radius: .25rem;
	    font-size: 14px;
	}
	
	textarea {
		height: 300px;
	}
	
	.checkbox {
	    display: flex;
	    align-items: center;
	    margin-bottom: 1rem;
	}
	
	.checkbox input {
	    margin-right: 0.5rem;
	}
	
	#input-file {
		font-size: 14px;
	}
	
	
	
	.eConTit {
		width: 100px;
		margin: 0 0 4.8px 0;
	}
	
	#eventContent {
		margin: 0;
	}
	
	.file {
		margin-top: 10px;
	}
	
	.buttons {
	    display: flex;
	    justify-content: space-between;
	    height: 100px;
	}
	
	.buttons button {
		height: 40px;
	    padding: 10px 20px;
	    border: none;
	    border-radius: .25rem;
	    font-size: 14px;
	    cursor: pointer;
	}
	
	.back-button {
		width: 100px;
	    background-color: #f0f0f0;
	    color: #333;
	}
	
	.submit-button {
		width: 220px;
	    background-color: #333;
	    color: white;
	}
	
</style>


<script type="text/javascript">
	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload-name").val(fileName);
	});
</script>


</head>
<body>
	<div class="container">
		<h2>이벤트 및 프로모션 등록하기</h2>
		<form action="write.do" method="post" enctype="multipart/form-data">
		    <label for="eventName">이벤트 이름</label>
		    <input class="ipt" type="text" name="title" placeholder="이벤트 이름" required>
		    
		    <div class="startBox">
			    <label for="eventStartDate">이벤트 시작일</label>
			    <input class="ipt" type="date" name="startDate" id="eventStartDate" placeholder="mm/dd/yyyy">
		    </div>
			<div class="endBox">
			    <label for="eventEndDate">이벤트 종료일</label>
			    <input class="ipt" type="date" name="endDate" id="eventEndDate" placeholder="mm/dd/yyyy">
			</div>
			
		    <div>
			    <label class="eConTit" for="eventContent">이벤트 내용</label>
			    <textarea class="ipt" id="eventContent" name="content" rows="4" placeholder="이벤트 내용을 입력하세요" required></textarea>
		    </div>
		    
			<input class="ipt file" type="file" name="file" id="input-file" multiple>
			
		    <div class="buttons">
		        <button type="button" class="back-button" onclick="history.back()" id="cancelBtn">돌아가기</button>
		        <button type="submit" class="submit-button">이벤트 및 프로모션 등록하기</button>
		    </div>
	    </form>
	</div>
</body>
</html>