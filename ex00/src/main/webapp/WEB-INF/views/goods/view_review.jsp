<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<!DOCTYPE html>
<html lang="ko">
<div id="review-tab">
<c:forEach var="review" items="${reviewList}">
    <div>
        <h4>${review.status}</h4>
        <h4>${review.title}</h4>
        <p>${review.content}</p>
        <p>작성자: ${review.id}</p>
        <p>작성일: <fmt:formatDate value="${review.writeDate}" pattern="yyyy-MM-dd" /></p>
        <button type="button" class="likeBtn" data-rno="${review.rno}">좋아요 <span>${review.likeCount}</span></button>
    </div>
</c:forEach>
    <div class="container">
        <!-- 간단한 리뷰 카드들 -->
        <section class="reviews-container1">
            <div class="review-card">
            <!-- rno, title, writeDate, likeCount, -->
            vo.goods_no = ${vo.goods_no}
            vo.id = ${login.id }
            vo.content = ${vo.content }
                <c:if test="${empty list }">
               <h4>데이터가 존재하지 않습니다.</h4>
            </c:if>
            <c:if test="${!empty list }">
                 <div class="dataRow row">
                  <c:forEach var="review" items="${reviewList}">
                  </c:forEach>
                 </div>
              </c:if>
            </div>
        <!-- 리뷰 작성 폼 -->
        
        <!-- 제출 버튼 -->
         <a href="/review/writeForm.do?goods_no=${vo.goods_no}" class="btn btn-primary">리뷰 등록</a>
      </section>
    </div>
    </div>
<script type="text/javascript">

$(document).ready(function() {
    $(".likeBtn").click(function() {
        const rno = $(this).data("rno");
        const $likeCountSpan = $(this).find("span");

        // 이미 좋아요를 누른 경우
        if ($(this).hasClass("liked")) {
            alert("이미 좋아요를 누르셨습니다.");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/review/like.do",
            type: "POST",
            data: { rno: rno },
            success: function(response) {
                let currentLikeCount = parseInt($likeCountSpan.text(), 10);
                if (isNaN(currentLikeCount)) currentLikeCount = 0;
                $likeCountSpan.text(currentLikeCount + 1);
                $(".likeBtn[data-rno='" + rno + "']").addClass("liked").prop("disabled", true);
            },
            error: function(response) {
                if (response.status === 401) {  // 로그인 필요 응답
                    alert("로그인이 필요합니다. 로그인 후 다시 시도해주세요.");
                } else {
                    alert("이미 좋아요를 누르셨습니다.");// "이미 좋아요를 누르셨습니다." 등의 다른 오류 메시지
                }
            }
        });
    });
});
</script>

<script>
    window.addEventListener('load', function() {
        // URL에 #review-tab이 포함된 경우 리뷰 탭을 활성화
        if (window.location.hash === '#review-tab') {
            // 예: Bootstrap 탭 구조라면 다음과 같이 리뷰 탭을 활성화
            document.querySelector('#review-tab-button').click();
        }
    });
</script>
</html>
