<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style type="text/css">
    	.container{
    		margin-top:20px;
    		margin-bottom:20px;
    	}
        .visualImage {
            width: 100%;
            max-width: 1536px;
            height: 500px;
            overflow: hidden;
            position: relative;
        }

        .visualImage img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        .product-icon {
            position: absolute;
            cursor: pointer;
            padding: 5px;
            text-align: center;
            color: white;
    		text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 텍스트 그림자 추가 */
        }
       
       .promotion-card {
   		 	margin-bottom: 20px;
		}
		
		.promotion-card .card {
		    width: 100%;
		    height: 350px; /* 고정 높이 */
		    overflow: hidden;
		    border: none;
		    transition: transform 0.3s ease;
		}
		
		.promotion-card .card:hover {
		    transform: scale(1.05); /* 마우스 오버 시 확대 효과 */
		}
		
		.promotion-card .card-img-top {
		    width: 100%;
		    height: 75%; /* 이미지 높이를 카드의 75%로 설정 */
		    object-fit: cover; /* 이미지 전체 채우기 */
		}
		
		.promotion-card .card-body {
		    height: 25%; /* 본문을 카드의 하단 25%에 배치 */
		    background-color: #fff; /* 배경색 */
		    display: flex;
		    flex-direction: column;
		    justify-content: right;
		    text-align: right;
		    padding: 10px;
		}
		
		.promotion-card .card-title,
		.promotion-card .card-text {
		    margin: 0;
		    color: #333; /* 본문 텍스트 색상 */
		}

       

        .visualImageText{
        	text-align:right;
        }
    </style>
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
                    <img src="/upload/goods/3.png" class="d-block">
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
	    	<div>우리의 쇼핑몰이 디자인한 공간에서<br>맘에드는 제품을 편리하게 살펴보세요!</div>
    	</div>
    	<div>
	    	<div><h4>진행중인 이벤트 및 프로모션</h4></div>
	    	<div>우리의 쇼핑몰이 자신있게 제시하는<br>이벤트와 프로모션을 살펴보세요!</div>
    	</div>
    </div>
    <div class="container">
        <div class="row">
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/2.png" class="card-img-top" alt="${event.title}">
				        <div class="card-body">
				            <h5 class="card-title">Event Title</h5>
				            <p class="card-text">Event Content</p>
				        </div>
				    </div>
				</div>
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/3.png" class="card-img-top" alt="${event.title}">
				        <div class="card-body">
				            <h5 class="card-title">Event Title</h5>
				            <p class="card-text">Event Content</p>
				        </div>
				    </div>
				</div>
                <div class="col-md-4 promotion-card">
				    <div class="card">
				        <img src="/upload/goods/1.png" class="card-img-top" alt="${event.title}">
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
