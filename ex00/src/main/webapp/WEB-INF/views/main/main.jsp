<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main</title>
    <link rel="stylesheet" href="/resources/css/main/main.css">
    <script type="text/javascript">    
    document.addEventListener('DOMContentLoaded', function() {
        fetch('/event/main')  // GET 요청을 통해 이벤트 리스트를 가져옴
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();  // 응답을 텍스트로 변환
            })
            .then(data => {
                // 이벤트 리스트만을 eventListContainer에 삽입
                const eventListContainer = document.getElementById('eventListContainer');
                eventListContainer.innerHTML = data;

                // 삽입된 카드에 클릭 이벤트 추가
                const cards = eventListContainer.querySelectorAll('.promotion-card');
                cards.forEach(card => {
                    card.addEventListener('click', function() {
                        const eno = card.getAttribute('data-eno');  // data-eno 값을 추출
                        if (eno) {
                            window.location.href = "/event/view.do?eno=" + eno;  // 해당 eno로 이동
                        }
                    });
                });
            })
            .catch(error => console.error('Error:', error));
    });

    </script>
</head>
<body>
    <!-- iframe으로 캐러셀 삽입 -->
	<div class="container">
	    <iframe src="/main/carouselPage" width="100%" height="500" style="border: none; overflow: hidden;"></iframe>
	</div>
    <div class="container">
    	<div class="visualImageText">
	    	<div><h4>공간별 쇼핑하기</h4></div>
	    	<div><b>cotton</b>이 디자인한 공간에서<br>맘에드는 제품을 편리하게 살펴보세요!</div>
    	</div>
    	<div>
	    	<div><h4>진행중인 이벤트 및 프로모션</h4></div>
	    	<div><b>cotton</b>이 자신있게 제시하는<br>이벤트와 프로모션을 살펴보세요!</div>
    	</div>
    <div id="eventListContainer" style="height:370px;overflow:hidden;"></div>	
    </div>
</body>
</html>

