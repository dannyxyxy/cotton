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
	    /* min-height: calc(100vh - 300px); */
	    min-height: 0;
	    padding: 20px;
	    background-color: #fff;
	}

	.container {
	    /* width: 520px; */
	    box-sizing: content-box;
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
	
	/* input[type="text"], input[type="date"], textarea {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 1rem;
	    border: 1px solid #ccc;
	    border-radius: .25rem;
	    font-size: 14px;
	} */
	
	.ipt {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 1rem;
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
	
	/* .ipt {
		width: 100px;
		height: 30px;
		font-size: 14px;
		background: #fff;
		border: 1px solid rgb(77,77,77);
		border-radius: .25rem;
		cursor: pointer;
		margin: 10px 10px 20px 0;
		border: 1px solid #ccc;
		
		
		&:hover {
		  background: rgb(77,77,77);
		  color: #fff;
		}
	} */
	
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
	
	.buttons {
	    display: flex;
	    justify-content: space-between;
	}
	
	.buttons button {
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
	<div class="container" style="margin: 0; pading: 0; margin: auto;">
		<h2>이벤트 및 프로모션 등록하기</h2>
	    <label for="eventName">이벤트 이름</label>
	    <input class="ipt" type="text" id="eventName" placeholder="이벤트 이름">
	    
	    <div class="startBox" style=" width: 49%; float: left;">
		    <label for="eventStartDate">이벤트 시작일</label>
		    <input style="width: 100%;" class="ipt" type="date" id="eventStartDate" placeholder="mm/dd/yyyy">
	    </div>
		<div class="endBox" style=" width: 49%; float: right;">
		    <label for="eventEndDate">이벤트 종료일</label>
		    <input style="width: 100%;" class="ipt" type="date" id="eventEndDate" placeholder="mm/dd/yyyy">
		</div>
		
	    <div style="">
		    <label class="eConTit" for="eventContent" style="width: 100px; margin: 0 0 4.8px 0;">이벤트 내용</label>
		    <textarea class="ipt" id="eventContent" rows="4" placeholder="이벤트 내용을 입력하세요" style="margin: 0;"></textarea>
	    </div>
	    
		<input class="ipt" type="file" id="input-file" style="font-size: 14px;">
		
	    <div class="buttons">
	        <button class="back-button" style="font-size: 14px;">돌아가기</button>
	        <button class="submit-button" style="font-size: 14px;">이벤트 및 프로모션 등록하기</button>
	    </div>
	</div>
</body>
</html>