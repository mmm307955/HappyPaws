<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
    <style>
		* {
		    box-sizing: border-box;
		}
		
		body {
		    margin: 0;
		    padding: 0;
		}
		
		a {
		    text-decoration: none;
		}
		
		ul {
		    list-style-type: none;
		}
		
		.top {
		    max-width: 1000px;
		    margin: 0 auto;
		}
		
		.top-controls {
		    display: flex;
		    justify-content: flex-end;
		    gap: 10px;
		    padding: 10px 20px;
		    background: white;
		    border-bottom: 1px solid #dee2e6;
		}
		
		.control-button {
		    padding: 8px 16px;
		    background: #868e96;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		    text-decoration: none;
		}
		
		.control-button:hover {
		    background: #495057;
		}
		
		.header {
		    text-align: center;
		    padding: 10px 0;
		    border-bottom: 2px solid #eee;
		    margin-bottom: 20px;
		}
		
		.product-title {
		    font-size: 24px;
		    margin-bottom: 10px;
		}
		
		.product-content {
		    display: flex;
		    margin-bottom: 20px;
		}
		
		.product-thumbnail {
		    width: 50%;
		    height: 470px;
		    margin-right: 20px;
		    background-color: #f8f8f8;
		    border: 1px solid #ddd;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: #666;
		    position: relative;
		    overflow: hidden;
		}
		
		.thumbnail-item {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.product-details {
		    width: 50%;
		}
		
		.rating-container {
		    display: flex;
		    gap: 12px;
		    margin-bottom: 20px;
		}
		
		.star-ratings {
		    unicode-bidi: bidi-override;
		    color: hsl(0, 0%, 80%);
		    font-size: 30px;
		    position: relative;
		    margin: 0;
		    padding: 0;
		    display: inline-block;
		}
		
		.fill-ratings {
		    color: #e7711b;
		    padding: 0;
		    position: absolute;
		    z-index: 1;
		    display: block;
		    top: 0;
		    left: 0;
		    overflow: hidden;
		}
		
		.fill-ratings span {
		    display: inline-block;
		}
		
		.empty-ratings {
		    padding: 0;
		    display: block;
		    z-index: 0;
		}
		
		.product-ratings-count {
		    color: black;
		    font-size: 19px;
		    text-decoration: none;
		    white-space: nowrap;
		    margin-top: 10px;
		}
		
		.product-info {
		    margin: 20px 0;
		    padding: 15px;
		}
		
		.product-info p:first-child {
		    font-size: 24px;
		    font-weight: bold;
		}
		
		.product-info p:last-child {
		    font-size: 20px;
		    font-weight: bold;
		}
		
		.option-select {
		    width: 100%;
		    padding: 10px;
		    margin: 10px 0;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		}
		
		.warning-message {
		    padding: 12px;
		    margin: 10px 0;
		    font-size: 13px;
		    color: #666;
		    display: flex;
		    align-items: center;
		}
		
		.warning-message::before {
		    content: "!";
		    color: red;
		    border: 1px solid red;
		    border-radius: 50%;
		    width: 16px;
		    height: 16px;
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		    margin-right: 8px;
		    font-size: 12px;
		}
		
		.selected-option {
		    background-color: #f8f8f8;
		    padding: 15px;
		    margin: 10px 0;
		    border-radius: 4px;
		}
		
		.product-name {
		    font-weight: bold;
		    margin-bottom: 5px;
		}
		
		.option-name {
		    color: #666;
		    margin-bottom: 10px;
		}
		
		.quantity-control {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-top: 10px;
		}
		
		.quantity-adjust {
		    display: flex;
		    align-items: center;
		    border: 1px solid #ddd;
		    border-radius: 3px;
		    background: white;
		}
		
		.quantity-btn {
		    width: 28px;
		    height: 28px;
		    border: none;
		    background: white;
		    font-size: 16px;
		    cursor: pointer;
		}
		
		.quantity-input {
		    width: 40px;
		    height: 28px;
		    border: none;
		    text-align: center;
		    border-left: 1px solid #ddd;
		    border-right: 1px solid #ddd;
		    outline: none;
		}
		
		.total-price {
		    margin-top: 20px;
		    padding-top: 15px;
		    border-top: 1px solid #ddd;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    font-weight: bold;
		}
		
		.button-group {
		    display: flex;
		    justify-content: space-between;
		    gap: 10px;
		    margin-top: 50px;
		}
		
		.button-cart, .button-buy {
		    flex: 1;
		    padding: 10px 20px;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.button-cart {
		    background-color: #868e96;
		}
		
		.button-buy {
		    background-color: #6c757d;
		}
		
		.button-cart:hover,
		.button-buy:hover {
		    opacity: 0.5;
		}
		
		.tabs {
		    display: flex;
		    margin: 20px 0;
		    border-bottom: 1px solid #ddd;
		}
		
		.tab {
		    padding: 10px 20px;
		    cursor: pointer;
		    border: 1px solid transparent;
		    margin-bottom: -1px;
		}
		
		.tab.active {
		    border: 1px solid #ddd;
		    border-bottom: 1px solid white;
		    background: white;
		}
		
		.tab-content {
		    display: none;
		    margin-top: 20px;
		}
		
		.tab-content.active {
		    display: block;
		}
		
		/* 리뷰 섹션 */
		.review-section {
		    padding: 20px;
		}
		
		.review-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.write-review-btn {
		    padding: 10px 20px;
		    background-color: #6c757d;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.write-review-btn:hover {
		    opacity: 0.5;
		}
		
		.review-item {
		    border: 1px solid #dee2e6;
		    border-radius: 4px;
		    padding: 20px;
		    margin-bottom: 20px;
		}
		
		.review-image-container {
		    position: relative;
		    max-width: 100%;
		    background-color: #f8f9fa;
		    border: 1px solid #dee2e6;
		    margin: 10px 0;
		}
		
		.review-show-item {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.review-user {
		    display: flex;
		    justify-content: space-between;
		    margin-bottom: 10px;
		    align-items: center;
		    padding-right: 100px;
		}
		
		.review-rating {
		    position: relative;
		    right: -80px;
		    top: 0;
		    margin: 0;
		    padding: 0;
		    display: inline-block;
		    unicode-bidi: bidi-override;
		    font-size: 24px;
		    width: auto !important;
		}
		
		.review-empty-ratings {
		    color: #ccc;
		    padding: 0;
		    display: block;
		    z-index: 0;
		    position: relative;
		}
		
		.review-fill-ratings {
		    color: #ffd43b;
		    padding: 0;
		    position: absolute;
		    z-index: 1;
		    display: block;
		    top: 0;
		    left: 0;
		    overflow: hidden;
		}
		
		.review-fill-ratings span, 
		.review-empty-ratings span {
		    display: inline-block;
		}
		
		.user-info {
		    color: #666;
		    font-size: 14px;
		    flex-grow: 1;
		}
		
		.review-content {
		    clear: both;
		    margin-top: 15px;
		    line-height: 1.5;
		}
		
		/* 리뷰 수정/삭제 버튼 */
		.review-modify {
		    display: flex;
		    justify-content: flex-end;
		    gap: 10px;
		}
		
		.review-edit,
		.review-delete {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.review-edit {
		    background-color: #ffc107;
		    color: black;
		}
		
		.review-delete {
		    background-color: #dc3545;
		    color: black;
		}
		
		.review-edit:hover,
		.review-delete:hover {
		    opacity: 0.5;
		}
		
		.stars {
		    cursor: pointer;
		}
		
		.stars .star {
		    color: #ddd;
		    margin: 0 5px;
		}
		
		.stars .star.active {
		    color: #ffd43b;
		}
		
		.modal {
		    pointer-events: none;
		}
		
		.modal-dialog {
		    pointer-events: all;
		}
		
		.review-star-rating {
		    width: 45px;
		    text-align: center;
		    border: 0;
		    background-color: white !important;
		    font-size: 32px;
		    font-weight: bold;
		}
		
		.review-star-rating:focus {
		    outline: none;
		    border: 0;
		    box-shadow: none;
		}
		
		.detail-pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 5px;
		    margin-top: 20px;
		}
		
		.detail-page-item {
		    min-width: 32px;
		    height: 32px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    cursor: pointer;
		}
		
		.detail-page-item:hover {
		    background-color: #000;
		}
		
		.detail-page-item.active {
		    background: #000;
		}
		
		.detail-page-link {
		    text-decoration: none;
		    color: #000;
		    width: 100%;
		    height: 100%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.detail-page-link:hover {
		    color: #fff;
		}
		
		.detail-page-item.active .detail-page-link {
		    color: #fff;
		}
		        
		.no-image-text,
		.modal-no-image-text {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: #6c757d;
		    background-color: #f8f9fa;
		    border: 1px solid #dee2e6;
		}
		
		.no-image-text {
		    width: 100%;
		    height: 100%;
		}
		
		.modal-no-image-text {
		    width: 100%;
		    height: 200px;
		}
		
		.inquiry-container {
		    max-width: 1000px;
		    margin: 0 auto;
		    padding: 20px;
		}
		
		.inquiry-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		    padding: 10px 0;
		}
		
		.inquiry-header p {
		    font-size: 18px;
		    font-weight: bold;
		    margin: 0;
		}
		
		.inquiry-notice {
		    background-color: #f8f9fa;
		    padding: 20px;
		    margin-bottom: 20px;
		    border-radius: 4px;
		}
		
		.inquiry-notice ul {
		    margin: 0;
		    padding: 0;
		}
		
		.inquiry-notice li {
		    position: relative;
		    padding-left: 15px;
		    margin-bottom: 8px;
		    color: #666;
		    font-size: 14px;
		    line-height: 1.5;
		}
		
		.inquiry-notice li:before {
		    content: "•";
		    position: absolute;
		    left: 0;
		    color: #999;
		}
		
		.inquiry-notice li:last-child {
		    margin-bottom: 0;
		}
		
		.inquiry-list {
		    border-top: 1px solid #dee2e6;
		}
		
		.inquiry-item {
		    border-bottom: 1px solid #dee2e6;
		    padding: 20px 0;
		}
		
		.inquiry-info,
		.answer-info {
		    display: flex;
		    align-items: center;
		    gap: 10px;
		    margin-bottom: 10px;
		}
		
		.inquiry-badge,
		.answer-badge {
		    padding: 4px 8px;
		    border-radius: 4px;
		    font-size: 12px;
		    font-weight: bold;
		}
		
		.inquiry-badge {
		    background-color: #e9ecef;
		    color: #495057;
		}
		
		.answer-badge {
		    background-color: #6c757d;
		    color: white;
		}
		
		.answer-text {
		    color: #666;
		    font-size: 14px;
		}
		
		.inquiry-content,
		.answer-content {
		    padding: 0 30px;
		    margin: 10px 0;
		    font-size: 15px;
		    line-height: 1.5;
		}
		
		.answer-item {
		    background-color: #f8f9fa;
		    margin: 10px 0;
		    padding: 20px;
		    border-radius: 4px;
		}
		
		.answer-text {
		    font-weight: bold;
		    color: #495057;
		}
		
		.inquiry-write-btn,
		.inquiry-delete-btn,
		.inquiry-answer-btn {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		.inquiry-write-btn {
		    background-color: #6c757d;
		    color: white;
		}
		
		.inquiry-delete-btn {
		    background-color: #dc3545;
		    color: black;
		    margin-left: auto;
		}
		
		.inquiry-answer-btn {
		    background-color: #28a745;
		    color: white;
		    margin-left: 10px;
		}
		
		.inquiry-write-btn:hover,
		.inquiry-delete-btn:hover,
		.inquiry-answer-btn:hover {
		    opacity: 0.8;
		}
    </style>
    <script>
        $(document).ready(function() {  	
            var initialRating = '5';
            $('#selected-rating').val(initialRating);
            $('#rating-display').val(initialRating);
            highlightStars(initialRating);
            
            var star_rating_width = $('.fill-ratings span').width();
            $('.star-ratings').width(star_rating_width);
            
            var review_rating_width = $('.review-fill-ratings span').width();
            $('.review-rating').width(review_rating_width);
            
            $('.review-fill-ratings').each(function() {
                var rating = $(this).data('rating');
                if (rating) {
                    $(this).css('width', rating + '%');
                }
            });
                        
            $('.tab').on('click', function() {
                showTab(this);
            });
            
            $('.product-ratings-count').click(function() {
                const tabs = document.querySelectorAll('.tab');
                const contents = document.querySelectorAll('.tab-content');
                const selectedTab = document.getElementById('reviewTab');
                
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
    
                selectedTab.classList.add('active');
    
                const contentId = selectedTab.getAttribute('data-target');
                document.getElementById(contentId).classList.add('active');
            });
            
            $('.option-select').on('change', function() {
                const selectedOption = $(this).find('option:selected');
                const productName = selectedOption.val();
                const optionName = selectedOption.data('option-name');
                const price = selectedOption.data('option-price');

                $('.warning-message').hide();
                $('.selected-option').show();
                $('.product-name').text(productName);
                $('.product-option-name').text(optionName);
                $('.product-option-price').text('₩' + price.toLocaleString());
                updateTotalPrice();
            });

            $('.quantity-btn.plus').click(function() {
                let input = $(this).siblings('.quantity-input');
                input.val(parseInt(input.val()) + 1);
                updateTotalPrice();
            });

            $('.quantity-btn.minus').click(function() {
                let input = $(this).siblings('.quantity-input');
                let value = parseInt(input.val());
                if (value > 1) {
                    input.val(value - 1);
                    updateTotalPrice();
                }
            });

            function updateTotalPrice() {
                const quantity = parseInt($('.quantity-input').val());
                const price = parseInt($('.option-select option:selected').data('option-price'));
                const total = quantity * price;
                $('.total-amount').text('₩' + total.toLocaleString() + '(' + quantity + '개)');
            }

            $('.write-review-btn').click(function() {
                new bootstrap.Modal(document.getElementById('reviewModal')).show();
            });

            $('.stars .star').click(function() {
                var rating = $(this).data('rating');
                $('#selected-rating').val(rating);  
                $('#rating-display').val(rating); 
                highlightStars(rating);
            });

            $('.stars .star').hover(
	       	    function() {
	       	        var hoverRating = $(this).data('rating');
	       	        highlightStars(hoverRating);
	       	        $('#rating-display').val(hoverRating);
	       	    },
	       	    function() {
	       	        var selectedRating = $('#selected-rating').val() || '5';
	       	        highlightStars(selectedRating);
	       	        $('#rating-display').val(selectedRating);
	       	    }
            );
            
            function highlightStars(rating) {
                $('.stars .star').removeClass('active');
                $('.stars .star').each(function() {
                    if ($(this).data('rating') <= rating) {
                        $(this).addClass('active');
                    }
                });
            }
            
            $('#reviewForm').on('submit', function(e) {
                e.preventDefault();
                
                // 입력값 검증
                let description = $('textarea[name="prc_desc"]').val().trim();
                if (!description) {
                    alert('리뷰 내용을 입력해주세요.');
                    return;
                }

                let formData = new FormData(this);
                
                $.ajax({
                    url: '/review_write',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response === "success") {
                            alert('리뷰가 등록되었습니다.');
                            window.location.href = 'pr_detail?pr_id=${pr_id}&tab=reviews';
                        } else {
                            alert(response);
                        }
                    },
                    error: function(xhr, status, error) {
                        if (xhr.status === 401) {
                            alert('로그인이 필요합니다.');
                            window.location.href = 'auth/login';
                        } else if (xhr.status === 400) {
                            alert(xhr.responseText);
                        } else {
                            alert(xhr.responseText);
                        }
                    }
                });
            });
            
            // 리뷰 삭제 버튼 클릭 이벤트
            $('.review-delete').click(function() {
                if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
                    return;
                }
                
                const reviewNo = $(this).data('review-no');
                const formData = new FormData();
                formData.append('prc_no', reviewNo);
                
                fetch('${pageContext.request.contextPath}/review_remove', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        if (response.status === 401) {
                            throw new Error('로그인이 필요합니다.');
                        }
                        throw new Error('리뷰 삭제에 실패했습니다.');
                    }
                    return response.text();
                })
                .then(data => {
                    if (data === 'success') {
                        alert('리뷰가 삭제되었습니다.');
                        window.location.href = 'pr_detail?pr_id=${pr_id}&tab=reviews';
                    } else {
                        alert(data);
                    }
                })
                .catch(error => {
                    if (error.message === '로그인이 필요합니다.') {
                        window.location.href = '${pageContext.request.contextPath}/auth/login';
                    } else {
                        alert(error.message);
                    }
                });
            });
            
         	// 문의하기 버튼 클릭 시 모달 표시
            $('.inquiry-write-btn').click(function() {
                new bootstrap.Modal(document.getElementById('inquiryModal')).show();
            });

            // 문의하기 폼 제출
            $('#inquiryForm').on('submit', function(e) {
                e.preventDefault();
                
                // 입력값 검증
                let description = $('textarea[name="prq_desc"]').val().trim();
                if (!description) {
                    alert('문의 내용을 입력해주세요.');
                    return;
                }

                let formData = new FormData(this);
                
                $.ajax({
                    url: '/question_write',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response === "success") {
                            alert('문의가 등록되었습니다.');
                            window.location.href = 'pr_detail?pr_id=${pr_id}&tab=inquiries';
                        } else {
                            alert(response);
                        }
                    },
                    error: function(xhr, status, error) {
                        if (xhr.status === 401) {
                            alert('로그인이 필요합니다.');
                            window.location.href = 'auth/login';
                        } else if (xhr.status === 400) {
                            alert(xhr.responseText);
                        } else {
                            alert('문의 등록에 실패했습니다.');
                        }
                    }
                });
            });
            
            // 문의글 삭제 버튼 클릭 이벤트
            $('.inquiry-delete-btn').click(function() {
                if (!confirm('이 문의글을 삭제하시겠습니까?')) {
                    return;
                }
                
                const inquiryNo = $(this).data('inquiry-no');
                
                fetch('${pageContext.request.contextPath}/question_remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'prq_no=' + inquiryNo
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('문의글 삭제에 실패했습니다.');
                    }
                    return response.text();
                })
                .then(data => {
                    if (data === 'success') {
                        alert('문의글이 삭제되었습니다.');
                        window.location.href = 'pr_detail?pr_id=${pr_id}&tab=inquiries';
                    } else {
                        alert(data);
                    }
                })
                .catch(error => {
                    alert(error.message);
                });
            });
            
         	// 답글달기 버튼 클릭 시 모달 표시
            $('.inquiry-answer-btn').click(function() {
                const inquiryNo = $(this).data('inquiry-no');
                $('#answer_prq_no').val(inquiryNo);
                new bootstrap.Modal(document.getElementById('answerModal')).show();
            });

            // 답글 폼 제출
            $('#answerForm').on('submit', function(e) {
                e.preventDefault();
                
                // 입력값 검증
                let answer = $('textarea[name="prq_comments"]').val().trim();
                if (!answer) {
                    alert('답변 내용을 입력해주세요.');
                    return;
                }

                let formData = new FormData(this);
                
                $.ajax({
                    url: '/question_answer_write',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response === "success") {
                            alert('답변이 등록되었습니다.');
                            location.reload();
                            window.location.href = 'pr_detail?pr_id=${pr_id}&tab=inquiries';
                        } else {
                            alert(response);
                        }
                    },
                    error: function(xhr, status, error) {
                        if (xhr.status === 401) {
                            alert('관리자만 답변을 등록할 수 있습니다.');
                        } else {
                            alert('답변 등록에 실패했습니다.');
                        }
                    }
                });
            });
            
         	// 리뷰 정렬 select 엘리먼트의 change 이벤트 핸들러
            $('.form-select').on('change', function() {
                var sortType = this.value.replace('review-sort-', '');
                var prId = '${pr_id}';
                var currentReviewPage = '${reviewPaging.btnCur}';
                
                // 페이지 이동 전 세션 스토리지에 상태 저장
                sessionStorage.setItem('scrollToReviewBtn', 'true');
                
                window.location.href = 'pr_detail?pr_id=' + prId + 
                                      '&reviewPage=' + currentReviewPage +
                                      '&sortType=' + sortType + 
                                      '&tab=reviews';
            });
         	
            $('.button-cart').click(function() {
                // 로그인 체크
                if ('${user}' === '') {
                    if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                        window.location.href = '${pageContext.request.contextPath}/auth/login';
                    }
                    return;
                }

                // 옵션이 선택되었는지 확인
                const selectedOption = $('.option-select option:selected');
                if (selectedOption.val() === undefined || selectedOption.val() === '' || 
                    selectedOption.data('option-name') === undefined || selectedOption.data('option-price') === undefined) {
                    alert('상품 옵션을 선택해주세요.');
                    return;
                }

                // 기본 옵션인지 확인 (첫 번째 옵션이 선택되었는지)
                if (selectedOption.text() === '- [필수] 옵션을 선택해 주세요 -') {
                    alert('상품 옵션을 선택해주세요.');
                    return;
                }

                // 선택된 상품 정보 가져오기
                const productData = {
                    pr_id: '${productDetail[0].pr_id}',
                    pr_name: '${productDetail[0].pr_name}',
                    pr_thumbnail: '${productDetail[0].pr_thumbnail}',
                    pr_opt_name: selectedOption.data('option-name'),
                    pr_opt_price: selectedOption.data('option-price'),
                    prsc_quantity: parseInt($('.quantity-input').val())
                };

                // null 체크
                for (let key in productData) {
                    if (productData[key] === null || productData[key] === undefined) {
                        alert('상품 정보가 올바르지 않습니다. 다시 시도해주세요.');
                        return;
                    }
                }

                // 장바구니에 추가하는 AJAX 요청
                $.ajax({
                    url: '${pageContext.request.contextPath}/add_to_cart',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(productData),
                    success: function(response) {
                        if (response === 'success') {
                            if (confirm('장바구니에 상품이 담겼습니다.\n장바구니로 이동하시겠습니까?')) {
                                window.location.href = '${pageContext.request.contextPath}/pr_cart';
                            }
                        } else if (response === 'duplicate') {
                            alert('장바구니에 동일한 상품이 있습니다.');
                        } else {
                            alert('장바구니 담기에 실패했습니다.');
                        }
                    },
                    error: function(xhr) {
                        if (xhr.status === 401) {
                            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                                window.location.href = '${pageContext.request.contextPath}/auth/login';
                            }
                        } else if (xhr.status === 409) {
                            alert('장바구니에 동일한 상품이 있습니다.');
                        } else {
                            alert('장바구니 담기 중 오류가 발생했습니다.');
                        }
                    }
                });
            });
        });
        
        function validateFile(input) {
            const file = input.files[0];
           
            // 확장자 검사
            const extension = file.name.split('.').pop().toLowerCase();
            const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'svg'];
           
            if (!allowedExtensions.includes(extension)) {
                alert('jpg, jpeg, png, gif, svg 파일만 업로드 가능합니다.');
                input.value = '';  // 선택된 파일 초기화
                return false;
            }
            return true;
        }
        
     	// 페이지 로드 시 스크롤 처리를 위한 이벤트 리스너
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const tabParam = urlParams.get('tab');

            if (tabParam === 'reviews') {
                // 탭 활성화
                const reviewTab = document.getElementById('reviewTab');
                if (reviewTab) {
                    showTab(reviewTab);
                }
                
                // sessionStorage 확인 및 스크롤 처리
                if (sessionStorage.getItem('scrollToReviewBtn')) {
                    const element = document.getElementById('write-review-btn');
                    if (element) {
                        element.scrollIntoView();
                        window.scrollBy(0, -100);  // 헤더 높이만큼 조정
                    }
                    sessionStorage.removeItem('scrollToReviewBtn');
                }
            }
        }); 
        
     	// 전역으로 showTab 함수 정의
        function showTab(tab) {
            const tabs = document.querySelectorAll('.tab');
            const contents = document.querySelectorAll('.tab-content');

            tabs.forEach(t => t.classList.remove('active'));
            contents.forEach(c => c.classList.remove('active'));

            tab.classList.add('active');

            const contentId = tab.getAttribute('data-target');
            document.getElementById(contentId).classList.add('active');
        }     
    </script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
    <section>
		<div class="top">
		    <div class="top-controls">
		        <button class="control-button">주문내역</button>
		        <a href="pr_cart" class="control-button" style="text-decoration: none;">장바구니</a>
		    </div>
		</div>
    </section>
    <main>
        <div class="header">
            <h1 class="product-title">${productDetail[0].pr_name}</h1>
        </div>
        <div class="product-content">
			<div class="product-thumbnail">
			    <c:if test="${productDetail[0].imageExists}">
			        <img class="thumbnail-item" src="${pageContext.request.contextPath}/getImage/${productDetail[0].pr_thumbnail}" 
			             alt="${productDetail[0].pr_thumbnail}">
			    </c:if>
			    <c:if test="${!productDetail[0].imageExists}">
			        <div class="no-image-text">이미지 없음</div>
			    </c:if>
			</div>
            <div class="product-details">
            	<div class="rating-container">
	                <div class="star-ratings">
	                    <div class="fill-ratings" style="width: ${averageRating}%;">
	                        <span>★★★★★</span>
	                    </div>
	                    <div class="empty-ratings">
	                        <span>★★★★★</span>
	                    </div>
	                </div>
	                <a href="#reviews" class="product-ratings-count">(${countRating}개의 고객 상품평)</a>
                </div>
                <div class="product-info">
                    <p>제품 요약 설명</p>
                    <p>${productDetail[0].pr_desc}</p>
                    <p>₩<fmt:formatNumber value="${productDetail[0].pr_price}" pattern="#,###"/></p>
                </div>
                <select class="option-select">
                    <option selected disabled>- [필수] 옵션을 선택해 주세요 -</option>
                    <c:forEach var="options" items="${productDetail}">
                        <option value="${options.pr_name}" data-option-price="${options.pr_opt_price}" data-option-name="${options.pr_opt_name}">
                        		${options.pr_opt_name} (${options.pr_opt_stock}개)</option>
                    </c:forEach>
                </select>
                <div class="warning-message">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</div>
                <div class="selected-option" style="display: none;">
                    <div class="selected-product">
                        <div class="product-name"></div>
                        <div class="product-option-name"></div>
                        <div class="quantity-control">
                            <div class="quantity-adjust">
                                <button class="quantity-btn minus">-</button>
                                <input type="text" class="quantity-input" value="1" readonly>
                                <button class="quantity-btn plus">+</button>
                            </div>
                            <div class="product-option-price"></div>
                        </div>
                    </div>
                    <div class="total-price">
                        <span>총 상품금액(수량)</span>
                        <span class="total-amount"></span>
                    </div>
                </div>
                <div class="button-group">
                    <button class="button-cart">장바구니 담기</button>
                    <button class="button-buy">구매하기</button>
                </div>
            </div>
        </div>
        <div class="tabs">
            <div class="tab active" data-target="detail">상품상세</div>
            <div class="tab" id="reviewTab" data-target="reviews">상품평</div>
            <div class="tab" id="inquiriesTab" data-target="inquiries">상품문의</div>
        </div>
        <div class="tab-content active" id="detail">
            <div class="product-detail-image">${productDetail[0].pr_detail_desc}</div>
        </div>
        <div class="tab-content" id="reviews">
            <div class="review-section">
				<div class="review-header">
				    <button id="write-review-btn" class="write-review-btn">리뷰 작성하기</button>
				    <select class="form-select" style="width: auto;">
				        <option value="review-sort-latest" ${sortType == 'latest' ? 'selected' : ''}>최신순</option>
				        <option value="review-sort-rating" ${sortType == 'rating' ? 'selected' : ''}>평점순</option>
				        <option value="review-sort-my" ${sortType == 'my' ? 'selected' : ''}>나의 리뷰</option>
				    </select>
				</div>
                <c:choose>
			        <c:when test="${empty productReview}">
			            <div class="text-center p-5">
			                <p class="text-muted mb-0">
			                    <c:choose>
			                        <c:when test="${sortType == 'my' && empty user}">
			                            로그인 후 작성한 리뷰를 확인할 수 있습니다.
			                        </c:when>
			                        <c:otherwise>
			                            작성된 리뷰가 없습니다.
			                        </c:otherwise>
			                    </c:choose>
			                </p>
			            </div>
			        </c:when>    
			        <c:otherwise>          
		                <c:forEach var="rev" items="${productReview}">
			                <div class="review-item">
			                    <div class="review-user">
			                        <div class="user-info">${rev.us_id} 작성일 - ${rev.prc_start_date} 옵션 - ${rev.pr_opt_name }</div>
				                    <div class="review-rating">
				                        <div class="review-fill-ratings" style="width: ${rev.prc_rating * 20}%;">
				                            <span>★★★★★</span>
				                        </div>
				                        <div class="review-empty-ratings">
				                            <span>★★★★★</span>
				                        </div>
				                    </div>
			                    </div>
								<c:if test="${rev.imageExists}">
								    <div class="review-image-container">
								        <img class="review-show-item" src="${pageContext.request.contextPath}/getImage/${rev.prc_image}" 
								        alt="${rev.prc_image}">
								    </div>
								</c:if>
			                    <div class="review-content">${rev.prc_desc}</div>
			                    <c:if test=
			                    "${not empty sessionScope.user.us_id && sessionScope.user.us_id eq rev.us_id || sessionScope.user.us_id eq 'admin'}">
			                   		<div class="review-modify">
					                    <button type="button" id="review-delete" class="review-delete" data-review-no="${rev.prc_no}">삭제</button>
				                    </div>
			                    </c:if>
			                </div>
		                </c:forEach>
	                </c:otherwise>  
                </c:choose>
				<div class="detail-pagination">
				    <c:if test="${reviewPaging.btnCur > 1}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="pr_detail?pr_id=${pr_id}&reviewPage=1&sortType=${sortType}&tab=reviews">＜＜</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnCur-1}&sortType=${sortType}&tab=reviews">＜</a>
				        </div>
				    </c:if>
				    <c:forEach var="i" begin="${reviewPaging.btnFirst}" end="${reviewPaging.btnLast}" step="1">
				        <c:choose>
				            <c:when test="${reviewPaging.btnCur == i}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">${i}</a>
				                </div>
				            </c:when>
				            <c:when test="${i == 0}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">1</a>
				                </div>
				            </c:when>				            
				            <c:otherwise>
				                <div class="detail-page-item">
				                    <a class="detail-page-link" 
				                       href="pr_detail?pr_id=${pr_id}&reviewPage=${i}&sortType=${sortType}&tab=reviews">${i}</a>
				                </div>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				    <c:if test="${reviewPaging.btnCur < reviewPaging.btnTotalCount}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnCur+1}&sortType=${sortType}&tab=reviews">＞</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnTotalCount}&sortType=${sortType}&tab=reviews">＞＞</a>
				        </div>
				    </c:if>
				</div>               
            </div>
        </div>
		<div class="tab-content" id="inquiries">
		    <div class="inquiry-container">
		        <div class="inquiry-header">
		            <button class="inquiry-write-btn">문의하기</button>
		        </div>
		        <div class="inquiry-notice">
		            <ul>
		                <li>구매한 상품의 취소/반품은 주문내역에서 신청 가능합니다.</li>
		                <li>상품문의 및 후기게시판을 통해 취소나 환불 반품 등은 처리되지 않습니다.</li>
		                <li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.</li>
		                <li>해당 상품 자체와 관련없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
		                <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
		            </ul>
		        </div>
				<c:set var="currentQNo" value="0" />
				<c:forEach var="proQ" items="${productQuestion}">
				    <c:if test="${currentQNo ne proQ.prq_no}">
				        <div class="inquiry-list">
				            <div class="inquiry-item">
				                <div class="inquiry-info">
				                    <span class="badge inquiry-badge">질문</span>
				                    <span>작성일 - ${proQ.prq_date}</span>
				                    <c:if test="${sessionScope.user.us_id eq 'admin'}">
				                        <button type="button" class="inquiry-delete-btn" data-inquiry-no="${proQ.prq_no}">삭제</button>
				                        <button type="button" class="inquiry-answer-btn" data-inquiry-no="${proQ.prq_no}">답글달기</button>
				                    </c:if>
				                </div>
				                <div class="inquiry-content">${proQ.prq_desc}</div>
				            </div>
	            		</div>
				    </c:if>
				    <c:if test="${not empty proQ.prq_comments}">
				        <div class="answer-item">
				            <div class="answer-info">
				                <span class="badge answer-badge">답변</span>
				                <span class="answer-text">[관리자]</span>
				            </div>
				            <div class="answer-content">${proQ.prq_comments}</div>
				        </div>
				    </c:if>
				    <c:if test="${currentQNo ne proQ.prq_no}">
				        <c:set var="currentQNo" value="${proQ.prq_no}" />
				    </c:if>
				</c:forEach>
				<div class="detail-pagination">
				    <c:if test="${inquiryPaging.btnCur > 1}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&inquiryPage=1&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＜＜</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnCur-1}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＜</a>
				        </div>
				    </c:if>
				    <c:forEach var="i" begin="${inquiryPaging.btnFirst}" end="${inquiryPaging.btnLast}" step="1">
				        <c:choose>
				            <c:when test="${inquiryPaging.btnCur == i}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">${i}</a>
				                </div>
				            </c:when>
				            <c:otherwise>
				                <div class="detail-page-item">
				                    <a class="detail-page-link" 
				                       href="pr_detail?pr_id=${pr_id}&inquiryPage=${i}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">${i}</a>
				                </div>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				    <c:if test="${inquiryPaging.btnCur < inquiryPaging.btnTotalCount}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnCur+1}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＞</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnTotalCount}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＞＞</a>
				        </div>
				    </c:if>
				</div>				
		    </div>
		</div>
		<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true" data-bs-backdrop="static" 
			 data-bs-keyboard="false">
		    <form class="modal-dialog" id="reviewForm" method="post" action="/review_write" enctype="multipart/form-data">
		    	<input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
						<div class="text-center mb-3">
						    <c:if test="${productDetail[0].imageExists}">
						        <img class="thumbnail-item" src="${pageContext.request.contextPath}/getImage/${productDetail[0].pr_thumbnail}" 
						        	 alt="${productDetail[0].pr_thumbnail}">
						    </c:if>
						    <c:if test="${!productDetail[0].imageExists}">
						        <div class="modal-no-image-text">이미지 없음</div>
						    </c:if>
						    <div>
						        <h6 class="mb-1">${productDetail[0].pr_name}</h6>
						        <input type="hidden" name="pr_id" value="${productDetail[0].pr_id}"> 
						    </div>
						</div>
						<div class="text-center mb-3">
						    <div class="d-flex flex-column align-items-center">
						        <div class="stars mb-2">
						            <span class="star fs-1" data-rating="1">★</span>
						            <span class="star fs-1" data-rating="2">★</span>
						            <span class="star fs-1" data-rating="3">★</span>
						            <span class="star fs-1" data-rating="4">★</span>
						            <span class="star fs-1" data-rating="5">★</span>
						        </div>
						        <input type="text" class="form-control review-star-rating" id="rating-display" value="5" readonly>
						        <input name="prc_rating" type="hidden" id="selected-rating" value="5">
						    </div>
						</div>
		                <div class="mb-3">
		                    <textarea name="prc_desc" class="form-control" rows="5" placeholder="리뷰를 작성해주세요."></textarea>
		                </div>
		                <div class="mb-3">
		                	<label for="review-image" class="form-label">이미지 선택</label>
		                    <input type="file" name="review-image" class="form-control form-control-sm" id="review-image" accept="image/*" 
		                    	   onchange="return validateFile(this)">
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>	
		        </div>
		    </form>
	    </div>
	    <div class="modal fade" id="inquiryModal" tabindex="-1" aria-labelledby="inquiryModalLabel" aria-hidden="true" data-bs-backdrop="static" 
     data-bs-keyboard="false">
		    <form class="modal-dialog" id="inquiryForm" method="post" action="/inquiry_write">
		    	<input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="inquiryModalLabel">상품 문의하기</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="mb-3">
		                    <textarea name="prq_desc" class="form-control" rows="5" placeholder="문의하실 내용을 입력해주세요."></textarea>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>  
		        </div>
		    </form>
		</div>
		<div class="modal fade" id="answerModal" tabindex="-1" aria-labelledby="answerModalLabel" aria-hidden="true" data-bs-backdrop="static" 
		     data-bs-keyboard="false">
		    <form class="modal-dialog" id="answerForm" method="post" action="/answer_write">
		    	<input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="answerModalLabel">답변 작성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <input type="hidden" name="prq_no" id="answer_prq_no">
		                <div class="mb-3">
		                    <textarea name="prq_comments" class="form-control" rows="5" placeholder="답변을 입력해주세요."></textarea>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>  
		        </div>
		    </form>
		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>