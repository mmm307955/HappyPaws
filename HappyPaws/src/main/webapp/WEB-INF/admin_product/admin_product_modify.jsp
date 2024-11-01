<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 600px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .title {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .image-upload {
            width: 100%;
            height: 300px;
            background-color: #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            margin-top: 120px;
        }
        #image-preview {
            max-width: 100%;
            max-height: 100%;
            display: none; /* 기본적으로 숨김 */
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group textarea {
            resize: none;
            height: 80px;
        }
        .options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 15px;
        }
         .option-group {
		        display: flex;
		        gap: 10px; /* 각 입력 필드 간의 간격 */
		    }
		
		    .option-group input {
		        width : 65%;
		    }
		
		    .option-group button {
		        flex-shrink: 0; /* 버튼이 작게 유지되도록 */
		        padding : 10px;
		    }
        .options input[type="text"],
        .options input[type="number"] {
            width: 45%;
            padding : 10px;
        }
        .buttons {
            display: flex;
            justify-content: center;
        }
        .buttons button {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background-color: #333;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        .buttons button.cancel {
            background-color: #bbb;
        }
        .buttons button.register {
            background-color: #4CAF50;
        }
        .buttons button.delete {
        background-color: #ff5858;
        }
    </style>
</head>
<body>


<div class="container">
	<form action="ad_manageProductModify" method="POST" enctype="multipart/form-data">
	<input type="hidden" id="pr_id" name="pr_id" value="${param.pr_id}">
    <div class="title">상품 수정</div>
    
    <!-- 이미지 업로드 영역 -->
<!--     <div class="image-upload"> -->
<!--         <img id="image-preview" src="#" alt="이미지 미리보기"> -->
<!--     </div> -->
    
    <!-- 이미지 업로드 영역 -->
	<div class="image-upload">
	    <img id="image-preview" src="${product.pr_thumbnail}" alt="이미지 미리보기" style="display: ${product.pr_thumbnail != null ? 'block' : 'none'};">
	</div>
	
	<!-- 기존 이미지 경로를 저장하는 hidden 필드 -->
	<input type="hidden" name="existingThumbnail" value="${product.pr_thumbnail}">

	
    
    <!-- 파일 업로드 필드 -->
    <div class="form-group" style="text-align:center">
        <input type="file" id="pr_thumbnail_file" name="pr_thumbnail_file" accept="image/*">
    </div>

    <div class="form-group">
        <label for="pr_name">상품명</label>
        <input type="text" id="pr_name" name="pr_name" value="${product.pr_name}">
    </div>

    <div class="form-group">
        <label for="pr_price">대표 가격(원)</label>
        <input type="number" id="pr_price" name="pr_price" value="${product.pr_price}" placeholder="숫자만 입력 가능합니다.">
    </div>

    <div class="form-group">
        <label for="pr_category">카테고리 선택</label>
        <select id="pr_category" name="pr_category">
            <option value="간식">간식</option>
            <option value="매트">매트</option>
            <option value="사료">사료</option>
            <option value="식기">식기</option>
            <option value="영양제">영양제</option>
            <option value="위생">위생</option>
            <option value="이동장">이동장</option>
            <option value="장난감">장난감</option>
            <option value="집/하우스">집/하우스</option>
            <option value="패션">패션</option>
            <option value="펫가전">펫가전</option>
            <option value="하네스/줄">하네스/줄</option>
            <option value="해충방지용품">해충방지용품</option>
        </select>
    </div>

<%--     77777777777777777:  ${productOption }  <br><br><br> --%>
    <div id="options-container" class="options">
            <c:forEach items="${productOption}" var="productOption">
            <div class="option-group">
                <input type="text" id="pr_opt_name" name="pr_opt_name" value="${productOption.pr_opt_name}" placeholder="옵션 필수 입력" required >
                <input type="number" id="pr_opt_stock" name="pr_opt_stock" value="${productOption.pr_opt_stock}" placeholder="수량 입력" required >
                <input type="number" id="pr_opt_price" name="pr_opt_price" value="${productOption.pr_opt_price}" placeholder="옵션 추가금 입력" required >
                <button type="button" class="add-option">+</button>
                <button type="button" class="remove-option">-</button>
            </div>
            </c:forEach>
        </div>
     <div class="form-group">
            <label for="pr_desc">제품 정보</label>
            <textarea id="pr_desc" name="pr_desc">${product.pr_desc}</textarea>
        </div>

        <div class="form-group">
            <label for="pr_detail_desc">상품 상세 설명</label>
            <textarea id="pr_detail_desc" name="pr_detail_desc">${product.pr_detail_desc}</textarea>
        </div>
        
		<input type="hidden" id="option_count" name="option_count" value="1">
		
		<div class="buttons">
		    <button type="button" class="cancel" onclick="cancel()">취소</button>
		    <button type="submit">수정</button>
		    <button type="button" class="delete" onclick="deleteProduct()">삭제</button>
		</div>
		
		<script>
		    function cancel() {
		        location.href = "/ad_manageProductList";
		    }
		
		    function deleteProduct() {
		        if (confirm("정말로 삭제하시겠습니까?")) {
		        	location.href = "/deleteProduct?pr_id=" + document.getElementById("pr_id").value;
		        }
		    }
		</script>
    </form>
</div>

<script>
	//옵션 개수 구하는 함수
	function getOptionCount() {
	    const optionGroups = document.querySelectorAll('.option-group');
	    return optionGroups.length;
	}

	//옵션 업데이트 함수
	function updateOptionCount() {
	    const optionCount = getOptionCount();  // 현재 옵션 개수 구하기
	   	document.getElementById('option_count').value = optionCount;  // 숨겨진 필드에 옵션 개수 설정
	}

    document.addEventListener('DOMContentLoaded', function () {
        const optionsContainer = document.getElementById('options-container');
		const imagePreview = document.getElementById('image-preview');
		const fileInput = document.getElementById('pr_thumbnail_file');
        // 옵션 추가
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('add-option')) {
                const optionGroup = document.querySelector('.option-group');
                const newOption = optionGroup.cloneNode(true); // 기존 옵션 복사
                newOption.querySelectorAll('input').forEach(input => input.value = ''); // 새 옵션은 빈 값
                optionsContainer.appendChild(newOption);
                updateOptionCount();  // 옵션 개수 업데이트
            }
        });

        // 옵션 삭제
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('remove-option')) {
                const optionGroups = document.querySelectorAll('.option-group');
                if (optionGroups.length > 1) {
                    e.target.closest('.option-group').remove();
                    updateOptionCount();  // 옵션 개수 업데이트
                } else {
                    alert("최소 옵션 수량은 1개입니다.(옵션 필수 작성)");
                }
            }
        });
        
        //파일 선택 시 이미지 미리보기
        fileInput.addEventListener('change',function(event) {
        	const file = event.target.files[0];
        	if(file){
        		const reader = new FileReader();
        		
        		reader.onload = function(e){
        			imagePreview.src = e.target.result;
        			imagePreview.style.display = 'block'; //이미지 미리보기 표시
        		}
        		reader.readAsDataURL(file);
        	}
        });
        
       
        
    });
</script>

</body>
</html>
