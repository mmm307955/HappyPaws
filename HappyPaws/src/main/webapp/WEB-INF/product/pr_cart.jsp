<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
		
        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        main {
            max-width: 1000px;
            margin: 0 auto;
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
        }

        .cart-title {
            text-align: center;
            font-size: 40px;
            font-weight: bold;
            margin: 40px 0;
        }

	    .cart-table {
	        width: 100%;
	        border-collapse: collapse;
	        margin-bottom: 20px;
	        table-layout: fixed;
	    }
        
        .cart-table a {
		    text-decoration: none;
		    color: inherit;
		}

        .cart-table th {
            padding: 12px;
            background: white;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-weight: normal;
            font-size: 13px;
        }

        .cart-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }
        
	    .cart-table th,
	    .cart-table td {
	        padding: 12px;
	        border-bottom: 1px solid #ddd;
	        text-align: center;
	        vertical-align: middle;
	        word-break: break-all; /* 글자가 길어지면 줄바꿈 */
	        height: auto; /* 높이 자동 조절 */
	    }
	    
	    * 각 열의 너비 고정 */
	    .cart-table th:nth-child(1),
	    .cart-table td:nth-child(1) { /* 체크박스 */
	        width: 5%;
	    }
	    
	    .cart-table th:nth-child(2),
	    .cart-table td:nth-child(2) { /* 이미지 */
	        width: 15%;
	    }
	    
	    .cart-table th:nth-child(3),
	    .cart-table td:nth-child(3) { /* 상품정보 */
	        width: 25%;
	    }
	    
	    .cart-table th:nth-child(4),
	    .cart-table td:nth-child(4) { /* 판매가 */
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(5),
	    .cart-table td:nth-child(5) { /* 수량 */
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(6),
	    .cart-table td:nth-child(6) { /* 배송비 */
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(7),
	    .cart-table td:nth-child(7) { /* 합계 */
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(8),
	    .cart-table td:nth-child(8) { /* 선택 */
	        width: 15%;
	    }
	
	    /* 상품정보 셀 스타일 수정 */
	    .product-info {
	        text-align: left;
	        font-size: 14px;
	        white-space: normal; /* 상품정보는 줄바꿈 허용 */
	    }
	
	    /* 가격 관련 셀 스타일 */
	    .cart-table td:nth-child(4),
	    .cart-table td:nth-child(6),
	    .cart-table td:nth-child(7) {
	        min-width: 80px;
	        word-wrap: break-word; /* 긴 숫자도 줄바꿈 */
	        white-space: normal; /* 줄바꿈 허용 */
	    }

		.product-img {
		    width: 100px;
		    height: auto;
		    transition: opacity 0.2s;
		}
		
		.product-img:hover {
		    opacity: 0.8;
		}

        .product-info {
            text-align: left;
            font-size: 14px;
        }
        
        .product-info a {
		    text-decoration: none;
		    color: inherit;
		}
		
		.product-info a:hover {
		    color: #495057;
		    text-decoration: underline;
		}

        .product-info span {
            display: block;
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }

        .quantity-wrap {
            display: inline-block;
            width: auto;
            text-align: center;
        }

        .quantity-input-group {
            display: inline-block;
            position: relative;
            width: 50px;
            height: 23px;
            border: 1px solid #ddd;
            margin-bottom: 3px;
        }

        .quantity-input {
            width: 100%;
            height: 100%;
            border: none;
            text-align: center;
            padding: 0 15px 0 5px;
            margin: 0;
        }

        .quantity-buttons {
            position: absolute;
            right: 0;
            top: 0;
            bottom: 0;
            width: 15px;
            display: flex;
            flex-direction: column;
            border-left: 1px solid #ddd;
        }

        .quantity-button {
            height: 50%;
            border: none;
            background: #f8f8f8;
            cursor: pointer;
            padding: 0;
            font-size: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-button:first-child {
            border-bottom: 1px solid #ddd;
        }

        .quantity-btn {
            display: block;
            width: 50px;
            padding: 2px 0;
            border: 1px solid #ddd;
            background: white;
            font-size: 12px;
            cursor: pointer;
            margin: 0 auto;
        }

        .btn-list {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .btn {
            width: 100px;
            padding: 7px 0;
            font-size: 12px;
            cursor: pointer;
        }

        .btn-order {
            background: #5e5a14;
            color: white;
            border: none;
        }

        .btn-normal {
            background: white;
            border: 1px solid #ddd;
        }

        /* 하단부분 스타일 */
        .cart-footer {
            margin-top: 20px;
        }

        .footer-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .delete-selected {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 13px;
        }

        .delete-btn {
            background: #f5f5f5;
            border: 1px solid #ddd;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
        }

        .action-buttons button {
            background: white;
            border: 1px solid #ddd;
            padding: 5px 15px;
            font-size: 12px;
            cursor: pointer;
        }

	    .price-summary {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        padding: 30px 0;
	        text-align: center;
	        border-bottom: 1px solid #ddd;
	    }
	
	    .price-item {
	        flex: 1;
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	        text-align: center;
	    }
	
	    .price-label {
	        font-size: 14px;
	        color: #666;
	        margin-bottom: 10px;
	        width: 100%;
	    }
	
	    .price-value {
	        font-size: 24px;
	        font-weight: bold;
	        text-align: center;
	        width: 100%;
	    }
	
	    .price-value span {
	        font-size: 16px;
	        font-weight: normal;
	        margin-left: 2px;
	    }
	
	    .price-separator {
	        font-size: 20px;
	        color: #666;
	        padding: 0 20px;
	        display: flex;
	        align-items: center;
	        margin-top: 20px;
	    }

        .purchase-buttons {
            text-align: center;
            margin: 30px 0;
        }

        .purchase-btn {
            padding: 15px 40px;
            font-size: 14px;
            cursor: pointer;
            margin: 0 2px;
        }

        .btn-buy-all {
            background: #5e5a14;
            color: white;
            border: none;
        }

        .btn-buy-selected {
            background: white;
            border: 1px solid #ddd;
        }
        
        .modal.no-move {
		    pointer-events: none;
		}
		
		.modal.no-move .modal-dialog {
		    pointer-events: all;
		}
		
		.modal-backdrop {
		    pointer-events: none !important;
		}
    </style>
	<script>
		$(document).ready(function() {
		    var IMP = window.IMP;
		    IMP.init("imp21007778"); // 포트원 가맹점 식별코드
			
		    // 가격 포맷팅 함수
		    function formatPrice(price) {
		        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    }
		
		    let products = {};
		    let totalPrice = 0;
			// products 객체에 stock 정보 추가
		    <c:forEach var="item" items="${cartList}" varStatus="status">
		        products['quantity_${item.prsc_no}'] = {
		            price: ${item.pr_opt_price},
		            pr_id: ${item.pr_id},
		            pr_opt_name: '${item.pr_opt_name}',
		            quantity: ${item.prsc_quantity},
		            prsc_no: ${item.prsc_no},
		            stock: 0  // 초기값 설정
		        };
		        
		        // 각 상품의 재고 정보를 가져옴
		        $.get('${pageContext.request.contextPath}/product/get_stock', {
		            pr_id: ${item.pr_id},
		            pr_opt_name: '${item.pr_opt_name}'
		        }, function(stock) {
		            products['quantity_${item.prsc_no}'].stock = stock;
		            
		            // 재고보다 현재 수량이 많으면 재고량으로 조정
		            var $input = $('#quantity_${item.prsc_no}');
		            if (parseInt($input.val()) > stock) {
		                $input.val(stock);
		                updateProductTotal('quantity_${item.prsc_no}');
		                updateTotalPrice();
		                updateCartQuantity('quantity_${item.prsc_no}', stock);
		            }
		            
		            // max 속성 설정
		            $input.attr('max', stock);
		        });
		    </c:forEach>
		
		    // 상품별 총액 업데이트
		    function updateProductTotal(targetId) {
		        const $input = $('#' + targetId);
		        if (!$input.length) return;
		
		        const quantity = parseInt($input.val());
		        const key = targetId;
		        
		        if (products[key]) {
		            const basePrice = products[key].price;
		            const totalPrice = basePrice * quantity;
		            
		            const $row = $input.closest('tr');
		            $row.find('td:eq(3)').text('₩' + formatPrice(basePrice));
		            $row.find('td:nth-last-child(2)').text('₩' + formatPrice(totalPrice));
		
		            products[key].quantity = quantity;
		            
		            // 체크된 상품들의 총액만 업데이트
		            updateTotalPrice();
		        }
		    }
		
		    // 총 금액 계산 및 업데이트 함수 수정
			function updateTotalPrice() {
			    var totalProductPrice = 0;
			    var totalShipping = 0;
			    var checkedCount = $('.product-checkbox:checked').length;
			    var totalCount = $('.product-checkbox').length;
			
			    // 체크된 상품이 없거나 전체 선택일 경우 모든 상품의 금액 계산
			    if (checkedCount === 0 || checkedCount === totalCount) {
			        $('.cart-table tbody tr').each(function() {
			            var quantity = parseInt($(this).find('.quantity-input').val()) || 0;
			            var price = parseInt($(this).find('td:eq(3)').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('td:nth-last-child(2)').text('₩' + itemTotal.toLocaleString());
			            totalProductPrice += itemTotal;
			        });
			    } else {
			        // 일부 상품만 체크된 경우 체크된 상품의 금액만 계산
			        $('.cart-table tbody tr').each(function() {
			            var isChecked = $(this).find('.product-checkbox').prop('checked');
			            var quantity = parseInt($(this).find('.quantity-input').val()) || 0;
			            var price = parseInt($(this).find('td:eq(3)').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('td:nth-last-child(2)').text('₩' + itemTotal.toLocaleString());
			            
			            if (isChecked) {
			                totalProductPrice += itemTotal;
			            }
			        });
			    }
			
			    // 상품 금액이 있을 때만 배송비 추가
			    totalShipping = totalProductPrice > 0 ? 3000 : 0;
			
			    // 화면 업데이트
			    $('.price-summary .price-value').eq(0).html(totalProductPrice.toLocaleString() + '<span>원</span>');
			    $('.price-summary .price-value').eq(1).html(totalShipping.toLocaleString() + '<span>원</span>');
			    $('.price-summary .price-value').eq(2).html((totalProductPrice + totalShipping).toLocaleString() + '<span>원</span>');
			}
		
		    // 장바구니 수량 DB 업데이트
			function updateCartQuantity(targetId, quantity) {
			    const product = products[targetId];
			    if (!product) return;
			
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/update_cart_quantity',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify({
			            prsc_no: product.prsc_no,
			            prsc_quantity: quantity,
			            pr_opt_price: product.price,
			            prsc_price: product.price * quantity
			        }),
			        success: function(response) {
			            if (response !== "success") {
			                alert('수량 업데이트에 실패했습니다.');
			                location.reload();
			            }
			        },
			        error: function() {
			            alert('수량 업데이트 중 오류가 발생했습니다.');
			            location.reload();
			        }
			    });
			}
		
		    // 상품 삭제
		    window.removeFromCart = function(prId, prOptName) {
		        if (!confirm('선택하신 상품을 장바구니에서 삭제하시겠습니까?')) {
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/product/remove_from_cart',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: prId,
		                pr_opt_name: prOptName
		            }),
		            success: function(response) {
		                if (response === 'success') {
		                    location.reload();
		                } else {
		                    alert('삭제에 실패했습니다.');
		                }
		            },
		            error: function() {
		                alert('삭제 중 오류가 발생했습니다.');
		            }
		        });
		    };
		
		    // 개별 체크박스
		    $('.product-checkbox').on('change', function() {
		        const allChecked = $('.product-checkbox:not(:checked)').length === 0;
		        $('#selectAll').prop('checked', allChecked);
		    });
		
		    // 선택 상품 삭제
		    $('.delete-btn').on('click', function() {
		        const selectedItems = $('.product-checkbox:checked').map(function() {
		            const $row = $(this).closest('tr');
		            const $input = $row.find('.quantity-input');
		            const inputId = $input.attr('id');
		            return {
		                pr_id: products[inputId].pr_id,
		                pr_opt_name: products[inputId].pr_opt_name
		            };
		        }).get();
		
		        if (selectedItems.length === 0) {
		            alert('삭제할 상품을 선택해주세요.');
		            return;
		        }
		
		        if (confirm('선택한 상품을 삭제하시겠습니까?')) {
		            Promise.all(selectedItems.map(item => 
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/product/remove_from_cart',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify(item)
		                })
		            )).then(() => {
		                location.reload();
		            }).catch(() => {
		                alert('삭제 중 오류가 발생했습니다.');
		            });
		        }
		    });
		
		    // 장바구니 비우기
		    $('button:contains("장바구니비우기")').on('click', function() {
		        if (!confirm('장바구니를 비우시겠습니까?')) {
		            return;
		        }
		
		        const allItems = Object.values(products).map(product => ({
		            pr_id: product.pr_id,
		            pr_opt_name: product.pr_opt_name
		        }));
		
		        Promise.all(allItems.map(item => 
		            $.ajax({
		                url: '${pageContext.request.contextPath}/product/remove_from_cart',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify(item)
		            })
		        )).then(() => {
		            location.reload();
		        }).catch(() => {
		            alert('장바구니 비우기 중 오류가 발생했습니다.');
		        });
		    });
		
		    // 전체 선택 체크박스
		    $('#selectAll').on('change', function() {
		        const isChecked = $(this).prop('checked');
		        $('.product-checkbox').prop('checked', isChecked);
		    });
		    
		 	// 수량 증가 버튼 클릭 시
			$(document).on('click', '.quantity-button.plus', function() {
			    var input = $(this).closest('.quantity-input-group').find('.quantity-input');
			    var targetId = input.attr('id');
			    var currentValue = parseInt(input.val());
			    var maxStock = products[targetId].stock;
			    
			    if (currentValue < maxStock) {
			        input.val(currentValue + 1);
			        updateProductTotal(targetId);
			        updateTotalPrice();
			        updateCartQuantity(targetId, currentValue + 1);
			    } else {
			        alert('재고가 부족합니다.');
			    }
			});

		    // 수량 감소 버튼 클릭 시
			$(document).on('click', '.quantity-button.minus', function() {
			    var input = $(this).closest('.quantity-input-group').find('.quantity-input');
			    var currentValue = parseInt(input.val());
			    if (currentValue > 1) {
			        input.val(currentValue - 1);
			        updateProductTotal(targetId);  // 이 줄 추가
			        updateTotalPrice();
			        
			        // DB 업데이트를 위한 데이터 준비
			        var targetId = input.attr('id');
			        updateCartQuantity(targetId, currentValue - 1);
			    }
			});

			// 수량 직접 입력 처리
			$(document).on('change', '.quantity-input', function() {
			    var value = parseInt($(this).val());
			    var targetId = $(this).attr('id');
			    var maxStock = products[targetId].stock;
			    
			    if (isNaN(value) || value < 1) {
			        value = 1;
			    } else if (value > maxStock) {
			        value = maxStock;
			        alert('재고가 부족합니다.');
			    }
			    
			    $(this).val(value);
			    updateProductTotal(targetId);
			    updateTotalPrice();
			    updateCartQuantity(targetId, value);
			});
		 	
			// 숫자만 입력되도록 처리
			$('.quantity-input').on('input', function() {
			    var value = $(this).val().replace(/[^0-9]/g, '');
			    $(this).val(value);
			});
		    
		 	// 체크박스 이벤트 통합 처리
		    function initializeCheckboxes() {
		        // 전체 선택 체크박스
		        $('#selectAll').on('change', function() {
		            var isChecked = $(this).prop('checked');
		            $('.product-checkbox').prop('checked', isChecked);
		            updateTotalPrice(); // 전체 선택/해제 시 금액 업데이트
		        });

		        // 개별 체크박스
		        $('.product-checkbox').on('change', function() {
		            var allChecked = $('.product-checkbox:not(:checked)').length === 0;
		            $('#selectAll').prop('checked', allChecked);
		            updateTotalPrice(); // 개별 체크박스 변경 시 금액 업데이트
		        });
		    }
		 	
		    // 선택 상품 주문하기
		    $('.btn-buy-selected').on('click', function() {
		        const selectedItems = $('.product-checkbox:checked').map(function() {
		            const $row = $(this).closest('tr');
		            return {
		                pr_id: $(this).val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get();

		        if (selectedItems.length === 0) {
		            alert('주문할 상품을 선택해주세요.');
		            return;
		        }

		        processOrder(selectedItems);
		    });
		    
		    // 전체 주문하기
		    $('.btn-buy-all').on('click', function() {
		        const allItems = $('tr').slice(1).map(function() {
		            const $row = $(this);
		            if($row.find('.product-checkbox').length === 0) return null; // 장바구니가 비어있는 경우 처리
		            
		            return {
		                pr_id: $row.find('.product-checkbox').val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get().filter(item => item !== null);

		        if (allItems.length === 0) {
		            alert('장바구니가 비어있습니다.');
		            return;
		        }

		        processOrder(allItems);
		    });
		    
			// pr_cart.jsp의 processOrder 
			function processOrder(items) {
			    const shippingModal = new bootstrap.Modal(document.getElementById('shippingModal'));
			    shippingModal.show();
			
			    $('#shippingForm').off('submit').on('submit', function(e) {
			        e.preventDefault();
			        
			        const productTotalAmount = items.reduce((sum, item) => sum + (item.pr_opt_price * item.pror_qtt), 0); // 실제계산
			        const shippingCost = 3000; // 고정 배송비
			        
			        // 테스트용 결제 금액과 고정 배송비 설정
			        const payAmount = 1; // 테스트용 1원 결제
			     	// const payAmount = productTotalAmount + shippingCost; // 실제 환경
			        
			        const shippingData = {
			            pror_recipient: $('#recipient').val(),
			            pror_phone: $('#phone').val(),
			            pror_addr: $('#addr').val(),
			            pror_addr_detail: $('#addr_detail').val(),
			            pror_zipcode: $('#zipcode').val(),
			            pror_pay_method: 'card',
			            pror_ship_cost: shippingCost,  // 고정 배송비
			            pror_total_amt: payAmount      // 실제 결제 금액 (1원)
			        };
			
			        const modal = bootstrap.Modal.getInstance(document.getElementById('shippingModal'));
			        modal.hide();
			        
			        const today = new Date();
			        const merchantUid = 'PR_' + today.getTime();
			        
			        const firstItemName = items[0].pr_name.replace(/[\n\t\r\s]+/g, ' ').trim();
			        const productName = items.length > 1 ? 
			            firstItemName + " 외 " + (items.length - 1) + "건" :
			            firstItemName;
			
			        const paymentData = {
			            pg: 'html5_inicis',
			            pay_method: 'card',
			            merchant_uid: merchantUid,
			            name: productName,
			            amount: payAmount,  // 테스트용 1원 결제
			            buyer_email: '${user.us_email}',
			            buyer_name: shippingData.pror_recipient,
			            buyer_tel: shippingData.pror_phone,
			            buyer_addr: `${shippingData.pror_addr} ${shippingData.pror_addr_detail}`.trim(),
			            buyer_postcode: shippingData.pror_zipcode
			        };
			
			        const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
			
			        if (isMobile) {
			            IMP.request_pay(paymentData);
			        } else {
			            IMP.request_pay(paymentData, function(rsp) {
			                if (rsp.success) {
			                    // 각 상품의 개별 금액과 수량 정보 설정
			                    const finalOrderData = items.map(item => ({
			                        ...item,
			                        ...shippingData,
			                        merchant_uid: rsp.merchant_uid,
			                        imp_uid: rsp.imp_uid,
			                        success: rsp.success,
			                        error_code: rsp.error_code,
			                        error_msg: rsp.error_msg,
			                        status: rsp.status,
			                        paid_at: rsp.paid_at,
			                        receipt_url: rsp.receipt_url,
			                        pror_item_qtt: item.pror_qtt,         // 주문 수량
			                        pror_item_amt: item.pror_product_amt  // 개별 상품의 총 금액
			                    }));
			
			                    $.ajax({
			                        url: '${pageContext.request.contextPath}/product/process_payment',
			                        type: 'POST',
			                        contentType: 'application/json',
			                        data: JSON.stringify(finalOrderData)
			                    })
			                    .done(function(response) {
			                        if (response.success) {
			                            alert('주문이 완료되었습니다.');
			                            window.location.replace('${pageContext.request.contextPath}/product/pr_order_list');
			                        } else {
			                            alert(response.message || '주문 처리 중 오류가 발생했습니다.');
			                        }
			                    })
			                    .fail(function(xhr) {
			                        alert('주문 처리 중 오류가 발생했습니다.');
			                        console.error('Error:', xhr.responseText);
			                    });
			                } else {
			                    alert(`결제에 실패하였습니다.\n${rsp.error_msg}`);
			                }
			            });
			        }
			    });
			}
		 	
		    // 주소 검색 버튼 클릭 이벤트
		    $('#searchAddrBtn').on('click', function() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                $('#zipcode').val(data.zonecode);
		                $('#addr').val(data.address);
		                $('#addr_detail').focus();
		            }
		        }).open();
		    });
		    
			 // 개별 상품 주문하기 버튼 클릭 이벤트
		    $('.btn-order').on('click', function() {
		        const $row = $(this).closest('tr');
		        
		        // 해당 상품의 정보 수집
		        const orderItem = {
		            pr_id: $row.find('.product-checkbox').val(),
		            pr_name: $row.find('.product-info a').first().text().trim(),
		            pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		            pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		            pror_qtt: parseInt($row.find('.quantity-input').val()),
		            pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		            pror_ship_cost: 3000
		        };

		        // 주문 처리
		        processOrder([orderItem]);
		    });
		    
		 	// 위시리스트 버튼 클릭 이벤트
		    $(document).on('click', '.btn-normal:contains("위시리스트")', function() {
		        // 로그인 체크
		        if ('${user}' === '') {
		            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                window.location.href = '${pageContext.request.contextPath}/auth/login';
		            }
		            return;
		        }
		        
		        const $row = $(this).closest('tr');
		        const $thumbnail = $row.find('.product-img');
		        
		        // 썸네일 경로 가져오기
		        let thumbnailPath = '';
		        if ($thumbnail.length > 0) {
		            // 이미지가 있는 경우
		            thumbnailPath = $thumbnail.attr('src').split('/').pop(); // 파일명만 추출
		        } else {
		            // 이미지가 없는 경우 기본 이미지 설정
		            thumbnailPath = 'no-image.jpg';
		        }
		        
		        // 중복 체크를 위해 필요한 데이터 가져오기
		        const productId = $row.find('.product-checkbox').val();
		        const optionName = $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', '');
		        
		        // 중복 체크를 위한 AJAX 요청
		        $.ajax({
		            url: '${pageContext.request.contextPath}/product/check_cart_item',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: productId,
		                pr_opt_name: optionName
		            }),
		            success: function(response) {
		                if (response.exists) {
		                    alert('이미 위시리스트에 있는 상품입니다.');
		                    return;
		                }
		                
		                // 상품명만 추출 (옵션 정보 제외)
		                const productName = $row.find('.product-info a').first().contents().filter(function() {
		                    return this.nodeType === 3; // 텍스트 노드만 선택
		                }).text().trim();
		                
		                // 위시리스트에 추가
		                const productData = {
		                    pr_id: productId,
		                    pr_name: productName,
		                    pr_thumbnail: thumbnailPath,
		                    pr_opt_name: optionName,
		                    pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, ''))
		                };
		                
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/product/add_to_wishlist',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify(productData),
		                    success: function(response) {
		                        if (response === 'success') {
		                            alert('위시리스트에 추가되었습니다.');
		                        }
		                    },
		                    error: function(xhr) {
		                        if (xhr.status === 401) {
		                            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                                window.location.href = '${pageContext.request.contextPath}/auth/login';
		                            }
		                        } else if (xhr.status === 409) {
		                            alert('이미 위시리스트에 있는 상품입니다.');
		                        } else {
		                            alert('위시리스트 추가 중 오류가 발생했습니다.');
		                        }
		                    }
		                });
		            },
		            error: function() {
		                alert('위시리스트 추가 중 오류가 발생했습니다.');
		            }
		        });
		    }); 
			
		    // 초기 상태 설정
		    initializeCheckboxes();
		    updateTotalPrice();		 
		});
	</script>  	
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
    <section>
		<div class="top">
		    <div class="top-controls">
		        <a href="/product/pr_order_list" class="control-button">주문내역/위시리스트</a>
		        <a href="/product/pr_cart" class="control-button">장바구니</a>
		    </div>
		</div>
    </section>
    <main>
        <h1 class="cart-title">장바구니</h1>
        <table class="cart-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>배송비</th>
                    <th>합계</th>
                    <th>선택</th>
                </tr>
            </thead>
			<tbody>
			    <c:choose>
			        <c:when test="${empty cartList}">
			            <tr>
			                <td colspan="9" class="text-center">장바구니가 비어있습니다.</td>
			            </tr>
			        </c:when>
			        <c:otherwise>
			            <c:forEach var="item" items="${cartList}" varStatus="status">
			                <tr>
			                    <td><input type="checkbox" class="product-checkbox" name="selectedItem" value="${item.pr_id}"></td>
								<td>
								    <a href="/product/pr_detail?pr_id=${item.pr_id}">
								        <c:if test="${item.imageExists}">
								            <img src="${pageContext.request.contextPath}/product/getImage/${item.pr_thumbnail}" 
								                 alt="${item.pr_name}" class="product-img">
								        </c:if>
								        <c:if test="${!item.imageExists}">
								            <div class="no-image">이미지 없음</div>
								        </c:if>
								    </a>
								</td>
								<td class="product-info">
								    <a href="/product/pr_detail?pr_id=${item.pr_id}">
								        ${item.pr_name}
								        <span>[옵션: ${item.pr_opt_name}]</span>
								    </a>
								</td>
								<td>₩<fmt:formatNumber value="${item.pr_opt_price}" pattern="#,###"/></td>
								<td>
								    <div class="quantity-wrap">
								        <div class="quantity-input-group">
											<input type="number" value="${item.prsc_quantity}" min="1" 
											       class="quantity-input" id="quantity_${item.prsc_no}" 
											       data-product-id="${item.pr_id}"
											       data-option-name="${item.pr_opt_name}">
											<div class="quantity-buttons">
											    <button type="button" class="quantity-button plus" 
											            data-target="quantity_${item.prsc_no}">▲</button>  
											    <button type="button" class="quantity-button minus" 
											            data-target="quantity_${item.prsc_no}">▼</button> 
											</div>
								        </div>
								    </div>
								</td>
			                    <td>3,000원</td>
			                    <td><fmt:formatNumber value="${item.pr_opt_price * item.prsc_quantity}" pattern="#,###"/>원</td>
			                    <td>
			                        <div class="btn-list">
			                            <button class="btn btn-order">주문하기</button>
			                            <button class="btn btn-normal">위시리스트</button>
			                            <button class="btn btn-normal" onclick="removeFromCart(${item.pr_id}, '${item.pr_opt_name}')">× 삭제</button>
			                        </div>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
        <div class="cart-footer">
			<div class="price-summary">
			    <div class="price-item">
			        <div class="price-label">총 상품금액</div>
			        <div class="price-value">
			            <c:set var="totalPrice" value="0"/>
			            <c:forEach var="item" items="${cartList}">
			                <c:set var="itemTotal" value="${item.pr_opt_price * item.prsc_quantity}"/>
			                <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>
			            </c:forEach>
			            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-separator">+</div>
			    <div class="price-item">
			        <div class="price-label">총 배송비</div>
			        <div class="price-value">
			            <c:set var="shippingCost" value="${totalPrice > 0 ? 3000 : 0}"/>
			            <fmt:formatNumber value="${shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-separator">=</div>
			    <div class="price-item">
			        <div class="price-label">결제예정금액</div>
			        <div class="price-value">
			            <fmt:formatNumber value="${totalPrice + shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			</div>
            <div class="footer-info">
                <div class="delete-selected">
                    <span>선택상품을</span>
                    <button class="delete-btn">× 삭제하기</button>
                </div>
                <div class="action-buttons">
                    <button>장바구니비우기</button>
                </div>
            </div>
			<div class="purchase-buttons">
			    <button class="purchase-btn btn-buy-all">전체 주문하기</button>
			    <button class="purchase-btn btn-buy-selected">선택된 항목 주문하기</button>
			</div>
        </div>
		<div class="modal fade" id="shippingModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <div class="modal-dialog">
		        <form class="modal-content" id="shippingForm">
		            <div class="modal-header">
		                <h5 class="modal-title">배송 정보 입력</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="mb-3">
		                    <label for="recipient" class="form-label">받는 사람</label>
		                    <input type="text" class="form-control" id="recipient" name="pror_recipient" required>
		                </div>
		                <div class="mb-3">
		                    <label for="phone" class="form-label">연락처</label>
		                    <input type="tel" class="form-control" id="phone" name="pror_phone" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
		                </div>
		                <div class="mb-3">
		                    <label for="zipcode" class="form-label">우편번호</label>
		                    <div class="input-group">
		                        <input type="text" class="form-control" id="zipcode" name="pror_zipcode" readonly required>
		                        <button type="button" class="btn btn-secondary" id="searchAddrBtn">주소 찾기</button>
		                    </div>
		                </div>
		                <div class="mb-3">
		                    <label for="addr" class="form-label">주소</label>
		                    <input type="text" class="form-control" id="addr" name="pror_addr" readonly required>
		                </div>
		                <div class="mb-3">
		                    <label for="addr_detail" class="form-label">상세주소</label>
		                    <input type="text" class="form-control" id="addr_detail" name="pror_addr_detail" required>
		                </div>
		                <input type="hidden" name="pror_pay_method" value="card">
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-primary">결제하기</button>
		            </div>
		        </form>
		    </div>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>