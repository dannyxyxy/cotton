<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글보기</title>
	<jsp:include page="../jsp/webLib.jsp"></jsp:include>
	
		<style type="text/css">
		.dataRow>.card-header{
			background: #e0e0e0;
		}22

	</style>
	
	<!-- 1. 필요한 전역변수 선언: 직접 코딩 방식 -->
	<script type="text/javascript">
	//보고있는 글 번호
	let id = "test1";
	let no = ${vo.no};
	let replyPage = 1;
	console.log("전역변수 no: " + no);
	</script>
	
	
	<!-- 2. 날짜 처리 람수 선언 -->
	<script type="text/javascript" src="/js/dateTime.js"></script>
	
	
	<!--  댓글 페이지네이션 함수 선언 -->
	<script type="text/javascript" src="/js/util.js"></script>
	
	
	<!--3. 댓글 객체 (replyService) 선언 : Ajax 처리부분 포함
		댓글 처리하는 모든곳에 사용하는 부분 코딩 -->
	<script type="text/javascript" src="/js/reply.js"></script>

	<script type="text/javascript">
	//	replyService.list(1); // 글 번호는 전역변수로 처리
	</script>
	
	<!-- 댓글 객체 reply.js 에서 선언한 replyService를 호출하여 처리 + 이벤트 처리  
		일반 게시판 댓글에 사용되는 부분 코딩-->
	<script type="text/javascript" src="/js/replyProcess.js"></script>
	
	

	<script type="text/javascript">
	$(function(){
		//수정 버튼 동작
		$("#updateBtn").click(function(){
			location = "updateForm.do?no=${vo.no}"; 
		});
 		//삭제 버튼 동작
		$("#deleteBtn").click(function(){
			//취소 버튼 눌렀을 때 모달창에 입력 한 비밀번호 지우기 
			$("#pw").val(""); 
		});
 		
 		//리스트 버튼 동작
 		$("#listBtn").click(function(){
 			//alert("리스트 버튼 클릭");
 			location = "list.do?page=${param.page}" 
 					 + "&perPageNum=${param.perPageNum}" 
 					 + "&key=${param.key}" 
 					 + "&word=${param.word}";
 		});
 		
	});
	</script>
	
	
</head>

	<body>
		<div class="container">
		  <div class="card">
		
		  <!-- header 정보 표시 -->
		    <div class="card-header"><h3>일반 게시판 글보기</h3></div>
		  
		  <!-- 불러온 글정보 클래스 -->
		    <div class="card-body">
		      <div class="card datarow" data-no="${vo.no }">
			    <div class="card-header">
			    	<span class="float-right"> 조회수: ${vo.hit }</span>
			    	${vo.no }. ${vo.title } 
					 </div>   
					   <div class="card-body">   	
					    <pre>${vo.content }</pre>
					    </div> 
				        <div class="card-footer">
				        <span class="float-right">
				        <fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
				        </span>
				        ${vo.writer }
				        </div>
				      </div>
				    </div> 
		    
		    <!-- 버튼 클래스 -->
		    <div class="card-footer">
		    	<button class="btn btn-success" id="updateBtn">수정</button>
		    	<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
		    	<button class="btn btn-primary" id="listBtn">리스트</button>
		    </div>
		    
		  </div><!-- 글보기 카드 끝 -->
		  
		  <div>
			<jsp:include page="boardreply.jsp"></jsp:include>		  
		  </div>
		  
		  
		  <!-- The Modal (delet를 위한 모달) -->
  <div class="modal fade" id="deleteModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호를 입력하세요.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <form action="delete.do" method="Post">
        	<!-- 글 번호를 자동으로 넘어오게 할거임 hidden/ 비밀번호는 사용자가 입력하도록 세팅 -->
        	<input type="hidden" name="no" value="${vo.no }">
	        <div class="modal-body">
	         	<div class="form-group">
	         		<input class="form-contorl" type="password" name="pw" id="pw">
	         	</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button class="btn btn-danger">삭제</button>
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        </div>
        </form>
      </div>
    </div>
  </div>
  
		  
		</div>
	</body>
	
</html>