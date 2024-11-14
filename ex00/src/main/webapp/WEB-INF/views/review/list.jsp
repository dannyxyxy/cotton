<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${login.gradeNo == 9 ? "사용자 리뷰 관리" : "내 리뷰보기"}</title>
    
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
    
    <link rel="stylesheet" href="/resources/css/review/list.css">
    
<script type="text/javascript">
$(document).ready(function() {
    $(".likeBtn").click(function() {
        const rno = $(this).data("rno");
        const $likeCountSpan = $(this).find("span");

        $.ajax({
            url: "${pageContext.request.contextPath}/review/like.do",
            type: "POST",
            data: { rno: rno },
            success: function(response) {
                const currentLikeCount = parseInt($likeCountSpan.text(), 10);
                $likeCountSpan.text(currentLikeCount + 1);
            },
            error: function() {
                alert("이미 좋아요를 누르셨습니다.");
            }
        });
    });
});
</script>
<script type="text/javascript">
    $(function(){
        $(".updateBtn").click(function() {
            let rno = $(this).data("rno");
            location.href = "updateForm.do?rno=" + rno;
        });

        $("#perPageNum").change(function(){
            $("#searchForm").submit();
        });

        $("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
        $("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
        
        const cardsPerPage = 6;
        let currentPage = 1;
        const totalCards = $("div.review").length;
        const totalPages = Math.ceil(totalCards / cardsPerPage);
        
        function showPage(page) {
            $("div.review").hide();
            $("div.review").slice((page - 1) * cardsPerPage, page * cardsPerPage).show();
            $("#pageInfo").text(`${page} / ${totalPages}`);
            $("#prevPage").prop("disabled", page === 1);
            $("#nextPage").prop("disabled", page === totalPages);
        }
        showPage(currentPage);
        
        $("#prevPage").click(function(e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        });
        
        $("#nextPage").click(function(e) {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        });
    });
</script>

</head>
<body>
    <!-- JSTL 변수를 사용하여 내 리뷰 개수 초기화 -->
    <c:set var="myReviewCount" value="0" scope="page" />

    <!-- 로그인한 사용자의 등급이 관리자(gradeNo 9)인지 확인 -->
    <c:choose>
        <c:when test="${login.gradeNo == 9}">
            <h1>사용자 리뷰 관리</h1>
        </c:when>
        <c:otherwise>
            <!-- 내 리뷰 보기 설정 -->
            <h1>내 리뷰보기</h1>
            <c:forEach var="vo" items="${list}">
                <c:if test="${vo.id == login.id}">
                    <c:set var="myReviewCount" value="${myReviewCount + 1}" scope="page" />
                </c:if>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <div class="container">
        <div style="display: flex;">
            <h5>${login.gradeNo == 9 ? "모든 사용자 리뷰를 관리할 수 있습니다." : "내가 쓴 리뷰를 한눈에 확인하세요!"} &nbsp;</h5>
            <c:if test="${login.gradeNo != 9}">
                <h5>총 리뷰수 : ${myReviewCount}</h5>
            </c:if>
        </div>

        <c:if test="${empty list}">
            <h4>작성된 리뷰가 없습니다.</h4>
        </c:if>

        <c:if test="${!empty list}">
            <div class="dataRow row" style="margin: 40px 0 0 0;">
                <c:forEach var="vo" items="${list}">
                    <c:if test="${login.gradeNo == 9 || vo.id == login.id}">
                        <div class="col-md-4 promotion-card" data-goods_no="${vo.goods_no}">
                            <div class="review">
                                <div class="card-body">
                                    vo.goods_no = ${vo.goods_no}
                                    <p class="review-title">${vo.title}</p>
                                    <p class="review-title">${vo.status}</p>
                                    <p class="card-text">${vo.content}</p>
                                    <p>${vo.id}</p>
                                    <span>작성일 : <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/></span>
                                    <c:if test="${login.gradeNo==1 }">
                                    	<button type="button" class="likeBtn" data-rno="${vo.rno}">좋아요 <span>${vo.likeCount}</span></button>
                                    </c:if>
                                    <c:if test="${login.gradeNo==1 }">
                                    	<a href="updateForm.do?perPageNum=${pageObject.perPageNum}&rno=${vo.rno}" class="updateBtn" data-rno="${vo.rno}">수정</a>
                                    </c:if>
                                    <form action="${pageContext.request.contextPath}/review/delete.do" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?')">
                                        <input type="hidden" name="rno" value="${vo.rno}">
                                        <button type="submit" class="deleteBtn" data-rno="${vo.rno}">삭제</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <!-- 페이지 내비게이션 -->
            <div class="pageNav" id="pagination">
                <a href="#" class="btn" id="prevPage"><i class="fa fa-angle-left"></i></a>
                <span id="pageInfo"></span>
                <a href="#" class="btn" id="nextPage"><i class="fa fa-angle-right"></i></a>
            </div>
        </c:if>
    </div>
</body>

</html>
