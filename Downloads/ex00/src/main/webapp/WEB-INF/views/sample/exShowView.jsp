<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            background-color: #333;
            color: white;
            padding: 10px 20px;
        }

        nav {
            display: flex;
            justify-content: space-between;
        }

        .menu {
            display: flex;
            gap: 20px;
        }

        .menu a {
            color: white;
            text-decoration: none;
            padding: 10px;
        }

        .category-menu {
            display: flex;
            justify-content: center;
            padding: 10px 0;
            background-color: #f4f4f4;
        }

        .category-item {
            margin: 0 10px;
            text-align: center;
        }

        .category-item img {
            width: 50px;
            height: 50px;
            display: block;
            margin: 0 auto;
        }

        .product-detail {
            display: flex;
            padding: 20px;
            background-color: white;
            border: 1px solid #ddd;
            margin: 20px;
        }

        .product-image {
            flex: 1;
            margin-right: 20px;
        }

        .product-image img {
            width: 100%;
            height: auto;
        }

        .product-info {
            flex: 2;
        }

        .product-info h1 {
            font-size: 24px;
            margin: 0;
        }

        .product-price {
            font-size: 20px;
            color: #b12704;
        }

        .shipping-info {
            color: #555;
        }

        .description, .reviews, .related-products {
            padding: 20px;
            background-color: #f9f9f9;
            margin: 20px 0;
            border: 1px solid #ddd;
        }

        .review {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .review:last-child {
            border-bottom: none;
        }

        .add-to-cart {
            margin-top: 20px;
        }

        .add-to-cart button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .add-to-cart button:hover {
            background-color: #218838;
        }

        .options {
            margin: 20px 0;
        }

        .option-label {
            font-weight: bold;
        }

        .option-select {
            margin: 5px 0;
        }

        .additional-images {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .additional-images img {
            width: 80px;
            height: 80px;
            cursor: pointer;
            border: 1px solid #ddd;
        }

        .additional-images img:hover {
            border-color: #aaa;
        }

        .review-form {
            margin-top: 20px;
        }

        .review-form textarea {
            width: 100%;
            height: 60px;
            margin: 10px 0;
        }

        .submit-review {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .submit-review:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<header>
    <nav>
        <div class="menu">
            <a href="#">홈</a>
            <a href="#">상품</a>
            <a href="#">장바구니</a>
            <a href="#">주문조회</a>
            <a href="#">고객센터</a>
        </div>
    </nav>
</header>

<div class="category-menu">
    <div class="category-item">
        <img src="category1.jpg" alt="카테고리 1">
        <p>카테고리 1</p>
    </div>
    <div class="category-item">
        <img src="category2.jpg" alt="카테고리 2">
        <p>카테고리 2</p>
    </div>
    <div class="category-item">
        <img src="category3.jpg" alt="카테고리 3">
        <p>카테고리 3</p>
    </div>
    <div class="category-item">
        <img src="category4.jpg" alt="카테고리 4">
        <p>카테고리 4</p>
    </div>
    <div class="category-item">
        <img src="category5.jpg" alt="카테고리 5">
        <p>카테고리 5</p>
    </div>
    <div class="category-item">
        <img src="category6.jpg" alt="카테고리 6">
        <p>카테고리 6</p>
    </div>
    <div class="category-item">
        <img src="category7.jpg" alt="카테고리 7">
        <p>카테고리 7</p>
    </div>
    <div class="category-item">
        <img src="category8.jpg" alt="카테고리 8">
        <p>카테고리 8</p>
    </div>
</div>

<div class="product-detail">
    <div class="product-image">
        <img src="product.jpg" alt="상품 이미지">
        <div class="additional-images">
            <img src="additional1.jpg" alt="추가 이미지 1">
            <img src="additional2.jpg" alt="추가 이미지 2">
            <img src="additional3.jpg" alt="추가 이미지 3">
        </div>
    </div>
    <div class="product-info">
        <h1>상품 이름</h1>
        <p class="product-price">가격: 100,000원</p>
        <p class="shipping-info">배송 정보: 무료배송</p>
        
        <div class="options">
            <div class="option-label">옵션 선택:</div>
            <select class="option-select">
                <option value="color1">색상 1</option>
                <option value="color2">색상 2</option>
                <option value="color3">색상 3</option>
            </select>
            <select class="option-select">
                <option value="size1">사이즈 S</option>
                <option value="size2">사이즈 M</option>
                <option value="size3">사이즈 L</option>
            </select>
        </div>

        <div class="add-to-cart">
            <button>장바구니에 담기</button>
        </div>
    </div>
</div>

<div class="description">
    <h2>상품 설명</h2>
    <p>여기에 상품에 대한 자세한 설명이 들어갑니다. 상품의 특장점, 사용법, 소재 등의 정보가 포함될 수 있습니다.</p>
</div>

<div class="reviews">
    <h2>상품 리뷰</h2>
    <div class="review">
        <strong>사용자1</strong>
        <p>이 상품 정말 좋아요! 품질이 뛰어나고 가격도 합리적입니다.</p>
    </div>
    <div class="review">
        <strong>사용자2</strong>
        <p>배송도 빨라서 좋았습니다. 다시 구매할 의향이 있습니다.</p>
    </div>
    <div class="review">
        <strong>사용자3</strong>
        <p>상품이 생각보다 더 좋았어요. 추천합니다!</p>
    </div>

    <div class="review-form">
        <h3>리뷰 작성</h3>
        <textarea placeholder="리뷰를 남겨주세요..."></textarea>
        <button class="submit-review">리뷰 제출</button>
    </div>
</div>

<div class="related-products">
    <h2>관련 상품</h2>
    <div class="related-item">
        <img src="related1.jpg" alt="관련 상품 1" style="width: 100px;">
        <p>관련 상품 1</p>
        <p>가격: 80,000원</p>
    </div>
    <div class="related-item">
        <img src="related2.jpg" alt="관련 상품 2" style="width: 100px;">
        <p>관련 상품 2</p>
        <p>가격: 90,000원</p>
    </div>
  