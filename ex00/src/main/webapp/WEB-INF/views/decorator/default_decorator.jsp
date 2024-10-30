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
        COTTON:<decorator:title />  <!-- 모든 타이틀에 "cotton:" 이 표시 됩니다 -->
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
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
        }

		
        .navbar {  
            background-color: #fff;
            padding: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
        }
		
        .navbar a.logo {
            text-decoration: none;
            font-size: 24px;
            color: black;
            font-weight: bold;
        }
		
		
        .navbar a.logo:hover {
            color: #555;
        }
		
		
        .search-container {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-grow: 1;
            max-width: 600px;
        }
		
		
        .searchDrop {
            padding: 8px;
            border-radius: 15px;
            width: 150px;
        }

        .search-bar-container {
            position: relative;
            width: 100%;
        }

        .form-control.search-bar {
            width: 100%;
            padding-left: 35px;
            border-radius: 15px;
            border: 1px solid #ddd;
            outline: none;
            box-sizing: border-box;
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 16px;
        }
        
        .searchBtn{
            border: none;
            background-color: transparent;            	 
        }

        .nav-icons a {
            margin: 0 15px 0 15px;
            color: black;
            font-size: 14px;
            text-decoration: none;
        }

        .nav-icons a:hover {
            color: #555;
        }

        .category-bar {
            display: flex;
		    flex-wrap: wrap;
		    align-items: center;
		    justify-content: center; 
            padding: 10px;
            background-color: #fff;
           
          
        }

        .category-item {
            text-align: center;
            font-size: 14px;
   
        }
        .category-item a {
        	margin: 0 0 0 0; /* 버튼과 위 요소 사이의 간격을 줄임 */
		    text-decoration: none;
		    color: #000;  /* 링크 텍스트 색상을 검정색으로 변경 */
		}

        .category-item img {
       		margin: 0 0 0 0;
            width: 80px;
            height: 80px;
            display: block;
            
        }

        .main-content {
            min-height: calc(100vh - 300px);
            padding: 20px;
            background-color: #fff;
        }

        .footer {
            padding: 20px;
            background-color: #f2f2f2;
            color: #666;
            font-size: 12px;
            border-top: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
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

        .footer-column a:hover {
            color: #333;
        }   
    </style>
    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
   
    <decorator:head/>
</head>
<body>
    <div class="navbar">
        <a href="/main.do" class="logo">cotton</a>
        <div class="search-container">
            <select class="form-control searchDrop">
                <option value="category1">카테고리 1</option>
                <option value="category2">카테고리 2</option>
                <option value="category3">카테고리 3</option>
            </select>
            <div class="search-bar-container">
                <span class="search-icon"><button class="searchBtn"><i class="fa fa-search"></i></button></span>
                <input class="form-control search-bar" type="text" placeholder="검색어 입력">
            </div>
        </div>
        <div class="nav-icons">
            <a href="/events.do">이벤트 및 프로모션</a>
            <a href="/member/inquiry.do">고객문의</a>
            <a href="/member/loginFormTest.do"><i class="fa fa-user"></i></a>
            <a href="/member/wishlist.do"><i class="fa fa-heart"></i></a>
            <a href="/member/cart.do"><i class="fa fa-shopping-cart"></i></a>
        </div>
    </div>
    
    <div class="category-bar">
        <div class="category-item">
            <a href="/goods/chairList.do">
                <img src="/upload/goods/chair.png">
                <p>의자</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/etcList.do">
                <img src="/upload/goods/etc.png">
                <p>소품</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/bedList.do">
                <img src="/upload/goods/bed.png">
                <p>침구</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/tableList.do">
                <img src="/upload/goods/table.png">
                <p>테이블</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/storageList.do">
                <img src="/upload/goods/storage.png">
                <p>수납</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/curtainList.do">
                <img src="/upload/goods/curtain.png">
                <p>커튼</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/rugList.do">
                <img src="/upload/goods/rug.png">
                <p>러그</p>
            </a>
        </div>
        <div class="category-item">
            <a href="/goods/lightList.do">
                <img src="/upload/goods/light.png">
                <p>조명</p>
            </a>
        </div>
    </div>
    
    <div class="main-content">
        <decorator:body />
        
    </div>
    
    
    
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
</body>
</html>