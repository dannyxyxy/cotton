<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="decorator"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>
        COTTON:<decorator:title />
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 

    <style>
        /* 전체 레이아웃 설정 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
 
        }

        /* 상단 바 설정 */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 20px;
            background-color: white;
            border-bottom: 1px solid #ddd;
        }

        .header img {
            width: 30px;
            height: 30px;
        }

        .header input[type="text"] {
            padding: 8px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        /* 카테고리 아이템 */
        .category-bar {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
            padding: 0 20px;
        }

        .category-item {
            text-align: center;
            font-size: 14px;
            color: #333;
        }

        .category-item img {
            width: 80px;
            height: 80px;
            display: block;
            margin: 0 auto 8px;
        }

        /* 전체 레이아웃 설정 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh; /* 전체 높이로 설정하여 footer가 화면 아래로 가도록 */
        }

        /* body 부분의 높이 조정 */
        article {
            padding: 300px; /* 원하는 여백으로 조정 */
            flex-grow: 1; /* 여유 공간을 사용하도록 설정 */
            max-width: 100%; /* 전체 너비에 맞게 조정 */
        }

        /* 하단 바 설정 */
        .footer {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #f2f2f2;
            color: #666;
            font-size: 12px;
            margin-top: 40px;
        }

        .footer-column {
            display: flex;
            flex-direction: column;
        }

        .footer-column h4 {
            margin-bottom: 10px;
            font-size: 14px;
        }

        .footer-column a {
            text-decoration: none;
            color: #666;
            margin-bottom: 5px;
        }

        .searchBtn {
            border: none;
            background-color: transparent;        
        } 

        .search-bar {
            border-radius: 15px;
        }
        
        /* 검색창 컨테이너 스타일 */
        .search-container {
            position: relative;
            display: flex; /* flex를 사용하여 나란히 배치 */
            align-items: center; /* 수직 중앙 정렬 */
            width: 100%; /* 전체 너비 */
        }

        /* 검색창 스타일 */
        .form-control.search-bar {
		    width: 100%;
		    padding-left: 40px; /* 아이콘 공간 확보 */
		    border-radius: 15px;
		    outline: none;
		    box-sizing: border-box;
        }

        /* 검색 버튼 스타일 (왼쪽) */
        .searchBtn {
		    position: absolute;
		    left: 10px; /* 검색창 왼쪽 여백 */
		    top: 50%;
		    transform: translateY(-50%); /* 세로 중앙 정렬 */
		    background: none;
		    border: none;
		    color: #aaa;
		    font-size: 18px;
		    cursor: pointer;
        }

        /* 지우기 버튼 스타일 (오른쪽) */
        .clearBtn {
            position: absolute;
            right: 5px;                   /* 오른쪽 끝 여백 */
            top: 50%;
            transform: translateY(-50%);  /* 세로 중앙 정렬 */
            background: none;
            border: none;
            color: #aaa;
            font-size: 16px;
            cursor: pointer;
            padding: 0;
            display: none;                /* 초기 상태는 숨김 */
        }

        /* 검색창에 입력값이 있을 때 지우기 버튼 표시 */
        .form-control.search-bar:not(:placeholder-shown) ~ .clearBtn {
            display: block;
        }

        /* 검색 버튼 호버 효과 */
        .searchBtn:hover {
            color: #333;
        }

        /* 지우기 버튼 호버 효과 */
        .clearBtn:hover {
            color: #333;
        }

        .searchDrop {
            margin-right: 10px;
            border-radius: 15px;    	
        }
    </style>
    <decorator:head/>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-md bg-light navbar-light">
            <a class="navbar-brand" href="/">   <h3>cotton</h3></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="collapsibleNavbar">
                <ul class="navbar-nav mx-auto"> <!-- 검색바를 중앙에 배치 -->
                    <li class="nav-item">
                        <form class="form-inline my-2 my-lg-0">
                            <div class="search-container">
                                <select class="form-control searchDrop">
                                    <option value="category1">카테고리 1</option>
                                    <option value="category2">카테고리 2</option>
                                    <option value="category3">카테고리 3</option>
                                </select>
                                <input class="form-control search-bar" type="search" placeholder="검색" aria-label="Search">
                                <span class="searchBtn"><i class="fa fa-search"></i></span> <!-- 검색 아이콘 추가 -->
                                <button class="clearBtn" type="button"></button>
                            </div>
                        </form>
                    </li>
                </ul>
				<ul class="navbar-nav ml-auto"> <!-- ml-auto 클래스 추가 -->
					<c:if test="${ empty login }">
						<li class="nav-item">
							<a class="nav-link" href="/member/searchID.do">이벤트 및 프로모션</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/member/searchID.do">고객문의</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/member/loginFormTest.do">
							<i class="fa fa-user"></i></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/member/loginFormTest.do">
							<i class="fa fa-heart"></i></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/member/loginFormTest.do">
							<i class="fa fa-cart-plus"></i></a>
						</li>
					</c:if>
					<c:if test="${ !empty login }">
						<li class="nav-item">
							<span class="nav-link">
								<c:if test="${ empty login.photo }">
									<i class="fa fa-user-circle-o"></i>
								</c:if>
								<c:if test="${ !empty login.photo }">
									<img src="${login.photo }" class="round-circle" style="width:30px; height:30px">
								</c:if>
								${login.id } 
							</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/member/logout.do">
							<i class="fa fa-sign-out"></i> Logout</a>
						</li>
						<c:if test="${login.gradeNo == 9 }">
							<li class="nav-item">
								<a class="nav-link" href="/member/list.do">Member Edit</a>
							</li>
						</c:if>
						<li class="nav-item">
							<a class="nav-link" href="/member/view.do">My Page</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/cart/list.do">Cart</a>
						</li>
					</c:if>
				</ul>	
			</div>
		</nav>
		
		    <!-- 카테고리 바 -->
    <div class="category-bar">
        <div class="category-item">
            <img src="/upload/goods/chair.png">
            <p>의자</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/etc.png" >
            <p>소품</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/bed.png" >
            <p>침구</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/desk.png">
            <p>테이블</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/cloth.png" >
            <p>수납</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/certain.png">
            <p>커튼</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/lug.png">
            <p>러그</p>
        </div>
        <div class="category-item">
            <img src="/upload/goods/light.png">
            <p>조명</p>
        </div>
    </div>
		
	</header>
	<article>
		<decorator:body />
	</article>
	    <!-- 하단 바 -->
    <div class="footer">
        <div class="footer-column">
            <h4>Use cases</h4>
            <a href="#">UI design</a>
            <a href="#">UX design</a>
            <a href="#">Wireframing</a>
        </div>
        <div class="footer-column">
            <h4>Explore</h4>
            <a href="#">Design</a>
            <a href="#">Prototyping</a>
            <a href="#">Development features</a>
        </div>
        <div class="footer-column">
            <h4>Resources</h4>
            <a href="#">Blog</a>
            <a href="#">Best practices</a>
            <a href="#">Colors</a>
        </div>
    </div>
	
	<div class="modal fade" id="msgModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">처리 결과 모달 창</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					${msg}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${!empty msg}">
		<script type="text/javascript">
			$(function(){
				$("#msgModal").modal("show");
			});
		</script>
	</c:if>
	

	
	
</body>
</html>