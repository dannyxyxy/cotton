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
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip(); // Bootstrap 툴팁 활성화
        });

        function viewProduct(productId) {
            window.location.href = `/product/${productId}`; // 제품 보기로 이동
        }
    </script>
</head>
<body>
    <div class="container">
        <div id="carouselExample" class="carousel slide" data-ride="carousel">
            <!-- 왼쪽 및 오른쪽 화살표 -->
            <a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExample" class="carousel-control-next" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>

            <div class="carousel-inner">
                <!-- 첫 번째 이미지 -->
                <div class="carousel-item active visualImage">
                    <img src="/upload/goods/room.png" class="d-block">
                    <div class="product-icon" style="top: 30%; left: 40%;"	
                         data-toggle="tooltip" 
                         data-html="true" 
                         data-placement="top" 
                         title="<strong>goodsName</strong><br>content<br>₩goodsPrice" 
                         onclick="viewProduct(1)">
                        <i class="fa fa-plus"></i>
                    </div>
                    <div class="product-icon" style="top: 70%; left: 80%;" 
                         data-toggle="tooltip" 
                         data-html="true" 
                         data-placement="top" 
                         title="<strong>${vo.goodsName2}</strong><br>${vo.content2}<br>₩${vo.goodsPrice2}" 
                         onclick="viewProduct(2)">
                        <i class="fa fa-plus"></i>
                    </div>
                </div>

                <!-- 두 번째 이미지 -->
                <div class="carousel-item visualImage">
                    <img src="/upload/goods/event3.png" class="d-block">
                    <div class="product-icon" style="top: 30%; left: 40%;" 
                         data-toggle="tooltip" 
                         data-html="true" 
                         data-placement="top" 
                         title="<strong>${vo.goodsName3}</strong><br>${vo.content3}<br>₩${vo.goodsPrice3}" 
                         onclick="viewProduct(3)">
                        <i class="fa fa-plus"></i>
                    </div>
                    <div class="product-icon" style="top: 40%; left: 60%;" 
                         data-toggle="tooltip" 
                         data-html="true" 
                         data-placement="top" 
                         title="<strong>${vo.goodsName4}</strong><br>${vo.content4}<br>₩${vo.goodsPrice4}" 
                         onclick="viewProduct(4)">
                        <i class="fa fa-plus"></i>
                    </div>
                </div>

                <!-- 추가 이미지 (필요한 만큼 추가) -->
                <div class="carousel-item visualImage">
                    <img src="/upload/goods/bed03.png" class="d-block">
                    <div class="product-icon" style="top: 30%; left: 40%;" 
                         data-toggle="tooltip" 
                         data-html="true" 
                         data-placement="top" 
                         title="<strong>${vo.goodsName5}</strong><br>${vo.content5}<br>₩${vo.goodsPrice5}" 
                         onclick="viewProduct(5)">
                        <i class="fa fa-plus"></i>
                    </div>
                </div>
            </div>
        </div>
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
    </div>
    <div class="container">
        <div class="row">
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/event1.png" class="card-img-top" alt="${event.title}">
				        <div class="card-body">
				            <h5 class="card-title">Event Title</h5>
				            <p class="card-text">Event Content</p>
				        </div>
				    </div>
				</div>
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/event2.png" class="card-img-top" alt="${event.title}">
				        <div class="card-body">
				            <h5 class="card-title">Event Title</h5>
				            <p class="card-text">Event Content</p>
				        </div>
				    </div>
				</div>
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/event3.png" class="card-img-top" alt="${event.title}">
				        <div class="card-body">
				            <h5 class="card-title">Event Title</h5>
				            <p class="card-text">Event Content</p>
				        </div>
				    </div>
				</div>

        </div>
<!--         <div class="row"> -->
<%--             <c:forEach var="event" items="${eventsList}"> --%>
<!--                 <div class="col-md-4 promotion-card"> -->
<!--                     <div class="card"> -->
<%--                         <img src="${event.imageUrl}" class="card-img-top" alt="${event.title}"> --%>
<!--                         <div class="card-body"> -->
<%--                             <h5 class="card-title">${event.title}</h5> --%>
<%--                             <p class="card-text">${event.description}</p> --%>
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<%--             </c:forEach> --%>
<!--         </div> -->
    </div>
</body>
</html>
