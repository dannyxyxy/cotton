<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!-- boardReply.jsp -->

<div class="row" style="margin: 40px -10px 0 -10px">
	<div class="col-lg-12">
		<!-- card -->
		<div class="card">
			<!-- 댓글 제목 -->
			<div class="card-header" style="background:#e0e0e0">
				<i class="fa fa-comments fa-fw"></i> Reply
				
				 <!-- Button to Open the Modal -->
				  <button type="button" class="btn btn-primary btn-sm pull-right" data-toggle="modal" data-target="#replyModal" id="newReplyBtn">
				    댓글 쓰기
				  </button>				
				</div>
				<!-- 댓글리스트 데이터 출력 -->
				<div class= card-body>
					<ul class="chat">
						<!-- 데이터 한개당 <li> 태그 하나 -->
						<!-- 하드 코딩 -->
						<li class="left-clearfix" data-rno="1">
							<div class="header">
								<strong class="primary-font">홍길동(test1)</strong>
								<small class= "pull-right text-muted">2024-01-01</small> 
							</div>
							<p><pre>Good Job ! ! </pre></p>
						</li>	
					</ul>
				</div><!-- card Body -->
				
				<div class="card-footer"> <!-- 하드 코딩 된 페이지네이션 -->
					<ul class="pagination pagination-sm">
					    <li class="page-item"><a class="page-link" href="#"><</a></li>
					    <li class="page-item"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item"><a class="page-link" href="#">></a></li>
					  </ul>
					</div>
				</div>
			</div>
		</div>
		
 <!-- The Modal -->
  <div class="modal fade" id="replyModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">댓글 등록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<input type="hidden" id="replyRno"> <!--댓글 수정에 사용하기 위함 -->
          <textarea rows="4" class="form-control" id="replyContent"></textarea>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button class="btn btn-primary" id="replyWriteBtn">등록</button>
          <button class="btn btn-success" id="replyUpdateBtn">수정</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>
	
	
	
	