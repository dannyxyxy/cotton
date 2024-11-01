<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
    <div class="container">
        <!-- 간단한 리뷰 카드들 -->
        <section class="reviews-container1">
            <div class="review-card">
                <div class="stars">★★★★★</div>
                <div class="review-title">매우 만족스러워요!</div>
                <div class="review-text">실물이 훨씬 예쁩니다!</div>
                <div class="review-footer">
                    <span>admin</span> <span>2024.10.26</span>
                </div>
            </div>
            <div class="review-card">
                <div class="stars">★★★★★</div>
                <div class="review-title">매우 만족스러워요!</div>
                <div class="review-text">실물이 훨씬 예쁩니다!</div>
                <div class="review-footer">
                    <span>admin</span> <span>2024.10.26</span>
                </div>
            </div>
            <div class="review-card">
                <div class="stars">★★★★★</div>
                <div class="review-title">매우 만족스러워요!</div>
                <div class="review-text">실물이 훨씬 예쁩니다!</div>
                <div class="review-footer">
                    <span>admin</span> <span>2024.10.26</span>
                </div>
            </div>
        </section>

        <!-- 상세 리뷰 카드 -->
        <section class="reviews-container2" style="margin-top: 10px;">
            <div class="detailed-review-card">
                <img src="../../upload/goods/bed01.png" alt="Product" class="review-image">
                <div class="review-content">
                    <div class="stars">★★★★★</div>
                    <div class="review-title">매우 만족스러워요!</div>
                    <div class="review-text">실물이 훨씬 예쁩니다!</div>
                    <div class="review-footer2">
                        <span>admin</span> <span>2024.10.26</span>
                    </div>
                    <div class="review-actions">
                        <button class="edit-btn">수정</button>
                        <button class="delete-btn">삭제</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- 리뷰 작성 폼 -->
        <section class="review-form-container">
            <h3 class="form-title">리뷰 남기기</h3>
            <p>해당 제품의 구매 리뷰를 남겨주세요!</p>

            <!-- 별점 입력 -->
            <div class="starContainer">
                <fieldset id="star">
                    <input type="radio" name="star" value="5" id="rate1">
                    <label for="rate1">★</label>
                    <input type="radio" name="star" value="4" id="rate2">
                    <label for="rate2">★</label>
                    <input type="radio" name="star" value="3" id="rate3">
                    <label for="rate3">★</label>
                    <input type="radio" name="star" value="2" id="rate4">
                    <label for="rate4">★</label>
                    <input type="radio" name="star" value="1" id="rate5">
                    <label for="rate5">★</label>
                </fieldset>
            </div>

            <!-- 리뷰 제목 입력 -->
            <div class="form-group">
                <input type="text" class="form-control" placeholder="리뷰 제목">
            </div>

            <!-- 리뷰 내용 입력 -->
            <div class="form-group">
                <textarea class="form-control" rows="5" placeholder="상품 구매 후기를 입력해 주세요."></textarea>
            </div>

            <!-- 제출 버튼 -->
            <div class="submitBtn">
                <button class="submit-btn">등록</button>
            </div>
        </section>
    </div>
</html>
