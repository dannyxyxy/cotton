<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>
        COTTON: <decorator:title />
    </title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Roboto:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <link rel="stylesheet" href="/resources/css/decorator/default_decorator.css">
    
    <script>
    // 페이지 이동을 위한 JavaScript 함수
    function goToCategory(cateCode) {
        window.location.href = "/goods/list.do?cate_code1=" + cateCode;
    }
    
        document.addEventListener("DOMContentLoaded", function() {
            const profileIcon = document.querySelector(".nav-icons .profile-icon"); // 네비 바에 있는 프로필 아이콘
            const rightSidebar = document.getElementById("rightSidebar");
            const closeSidebarButtons = document.querySelectorAll(".close-sidebar");
            const body = document.body;

            // 사이드바 상태 토글 함수
            function toggleSidebar() {
                if (rightSidebar.classList.contains("open")) {
                    closeSidebar();
                } else {
                    openSidebar();
                }
            }

            // 사이드바 열기 함수
            function openSidebar() {
                rightSidebar.classList.add("open");
                body.classList.add("no-scroll");
            }

            // 사이드바 닫기 함수
            function closeSidebar() {
                rightSidebar.classList.remove("open");
                body.classList.remove("no-scroll");
            }

            // 프로필 아이콘 클릭 시 사이드바 열기/닫기
            if (profileIcon) {
                profileIcon.addEventListener("click", function(event) {
                    event.preventDefault(); // 기본 동작 방지
                    toggleSidebar();
                });
            }

            // 사이드바 닫기 버튼 클릭 시 사이드바 닫기
            closeSidebarButtons.forEach(button => {
                button.addEventListener("click", function(event) {
                    event.preventDefault(); // 기본 동작 방지
                    closeSidebar();
                });
            });

           /*  // 바깥 클릭 시 사이드바 닫기
            document.addEventListener("click", function(event) {
                if (!rightSidebar.contains(event.target) && !profileIcon.contains(event.target) && rightSidebar.classList.contains("open")) {
                    closeSidebar();
                }
            }); */

            // 창 크기 조정 시 사이드바 닫기
            window.addEventListener("resize", function() {
                if (window.innerWidth > 768) {
                    closeSidebar();
                }
            });
        });
    </script>
    
    

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
                <span class="search-icon"><button type="button" class="searchBtn"><i class="fa fa-search icon"></i></button></span>
                <span class="cancel-icon"><button type="button" class="resetBtn" onclick= "reset()"><i class="fa fa-times times"></i></button></span>
                <input class="form-control search-bar" type="text" placeholder="검색어 입력">
            </div>
        </div>
        
        <div class="nav-icons">
            <a href="/board/list.do">이벤트 및 프로모션</a>
            <a href="/member/inquiry.do">고객문의</a>
            <c:if test="${ empty login }">
                <a href="/member/loginForm.do"><i class="fa fa-user"></i></a>
            </c:if>      
            <c:if test="${ !empty login }">
                <a class="nav-link logoutBtn" href="/member/logout.do">로그아웃</a>              
                <span class="nav-link">
                    <c:if test="${ empty login.photo }">
                        <a href="#" class="profile-icon"><i class="fa fa-user-circle-o"></i></a>
                    </c:if>
                    <c:if test="${ !empty login.photo }">
                        <img src="${login.photo }" class="profile-icon" alt="Profile" style="width:30px; height:30px; border-radius:30px;">
                    </c:if>
                </span>          
           </c:if>
            <a href="#" onclick="<c:choose>
                <c:when test='${empty login}'>window.location.href='/member/loginForm.do';</c:when>
                <c:otherwise>window.location.href='/member/wishlist.do';</c:otherwise>
            </c:choose>">
                <i class="fa fa-heart"></i>
            </a>
            <a href="#" onclick="<c:choose>
                <c:when test='${empty login}'>window.location.href='/member/loginForm.do';</c:when>
                <c:otherwise>window.location.href='/member/cart.do';</c:otherwise>
            </c:choose>">
                <i class="fa fa-shopping-cart"></i>
            </a>
        </div>
    </div>
    
    <div class="right-sidebar" id="rightSidebar">
        <button class="close-sidebar float-right" aria-label="Close Sidebar"><i class="fa fa-close closeBtn"></i></button>
        <c:if test="${!empty login.photo}">
            <img src="${login.photo}" alt="Profile Picture" class="profile-pic">
        </c:if>
        <c:if test="${empty login.photo}">
            <div class="default-icon" aria-label="Default Profile Icon">&#128100;</div>
        </c:if>
        
        <div class="username">
            <c:if test="${!empty login.id}">
                ${userId}
            </c:if>
            <c:if test="${empty login.id}">
                Guest
            </c:if>
        </div>
        <hr>
        
        <a href="/cartList">쇼핑카트</a>
        <a href="/wishlist">위시리스트</a>
        <a href="/butList">구매내역</a>
        <a href="/settings">내가 쓴 리뷰</a>
        <a href="/logout">로그아웃</a>
        <hr>
        <a href="/member/updateForm.do">회원정보</a>
    </div>
   
    <div class="category-bar">
    <!-- 각 카테고리 항목에서 <a> 태그 제거하고 onclick 이벤트 추가 -->
    <div class="category-item" onclick="goToCategory(1)">
        <img src="/upload/goods/chair.png" alt="Chair">
        <p>의자</p>
    </div>
    <div class="category-item" onclick="goToCategory(2)">
        <img src="/upload/goods/etc.png" alt="Accessories">
        <p>소품</p>
    </div>
    <div class="category-item" onclick="goToCategory(3)">
        <img src="/upload/goods/bed.png" alt="Bed">
        <p>침구</p>
    </div>
    <div class="category-item" onclick="goToCategory(4)">
        <img src="/upload/goods/table.png" alt="Table">
        <p>테이블</p>
    </div>
    <div class="category-item" onclick="goToCategory(5)">
        <img src="/upload/goods/storage.png" alt="Storage">
        <p>수납</p>
    </div>
    <div class="category-item" onclick="goToCategory(6)">
        <img src="/upload/goods/curtain.png" alt="Curtain">
        <p>커튼</p>
    </div>
    <div class="category-item" onclick="goToCategory(7)">
        <img src="/upload/goods/rug.png" alt="Rug">
        <p>러그</p>
    </div>
    <div class="category-item" onclick="goToCategory(8)">
        <img src="/upload/goods/light.png" alt="Light">
        <p>조명</p>
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
