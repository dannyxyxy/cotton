<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 리스트</title>

	<jsp:include page="../jsp/webLib.jsp"></jsp:include>
	
	<style type="text/css">
		.dataRow>.card-header{
			background: #e0e0e0;
		}
		.dataRow:hover {
			border-color: orange;
			cursor: pointer
		}	
	</style>
	
	<script type="text/javascript">
		$(function(){
			//jquery 이벤트, 코드는 이 안에 적습니다.
			$(".dataRow").click(function(){
				//tag 적힌 data-no 
				let no = $(this).data("no");
				
				//pageObject에 pageQuery
				//page, perPageNum, ,key , word를 
				location="view.do?no="+ no + "&inc=1" + "&${pageObject.pageQuery}";
			});
			//perPageNum 값이 변경되었을 때이벤트 처리
			$("#perPageNum").change(function(){
				//alert("chage perPageNum");
				$("#searchForm").submit();
				
			});
			// 검색 데이터 세팅
			$("#key").val('${(empty pageObject.key)?"t":pageObject.key}'); 
			//perPageNum 세팅
			$("#perPageNum").val('${(empty pageObject.perPageNum)?"10":pageObject.perPageNum}'); 

			
		});
	</script>
	
</head>

	<body>
		<div class="container">
		  <div class="card">
			<div class="card-header"><h3>일반 게시판 리스트</h3></div>
			
			
			<!-- 검색창 핓 perPsgeNum 설정창 -->
			
	<form action="list.do" id="searchForm">
		<input type="hidden" name="page" value="1"> <!-- 초기값 세팅 -->
				
	         	<div class="row">
		    	  <div class="col-md-8">
	  			   <div class="input-group mt-3 mb-3">
					<div class="input-group-prepend">
						<select class="form-control" id="key" name="key">
							<option value="t">제목</option>
					        <option value="c">내용</option>
					        <option value="w">작성자</option>
					        <option value="tc">제목/내용</option>
					        <option value="tw">제목/작성자</option>
					        <option value="cw">내용/작성자</option>
					        <option value="tcw">모두</option>
						</select>
					</div>
		      		<input type="text" class="form-control" placeholder="검색어입력"
	      				id="word" name="word" value="${pageObject.word }">
					<div class="input-group-prepend">
						<button type="submit" class="btn btn-primary">
							<i class="fa fa-search"></i></button>
					</div>
			    </div>
			</div> <!-- end of class="col-md-8" -->
			<div class="col-md-4">
				<div class="input-group mt-3 mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">Rows/Page</span>
				  </div>
				  <select id="perPageNum" name="perPageNum" class="form-control">
				   		<option>5</option>
				   		<option>10</option>
				   		<option>15</option>
				   		<option>20</option>
				   		<option>25</option>
				  </select>
				</div>
			</div> <!-- end of class="col-md-4" -->
		</div><!-- end of class="row" -->
	</form>
			
			<!-- 일반게시팬 리스트 데이터 -->
		   <c:forEach items="${list }" var="vo">
		  
		  <!-- 불러온 글정보 클래스 -->
		    <div class="card-body">
		    	
		      <div class="card dataRow" data-no="${vo.no }">
			    <div class="card-header">
			    	<span class="float-right"> 조회수: ${vo.hit }</span>
			    		글번호: ${vo.no }
					 </div>   
					   <div class="card-body">   	
					    <pre>${vo.title }</pre>
					    </div> 
				        <div class="card-footer">
				        <span class="float-right">
				        <fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
				        </span>
				        작성자: ${vo.writer }
				        </div>
				      </div>
				    </div> 
		   </c:forEach>
		    
		    <!-- 버튼 클래스 -->
		    <div class="card-footer">
		    	<a href="writeForm.do" class="btn btn-primary">글등록</a>
		    </div>
		    	<div>
		    		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		    	</div>
		  </div>
		</div>
	</body>
	
</html>