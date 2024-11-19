<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
    <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내정보 수정</title>
   <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background-color: #fdf8e5;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
        .profile-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 15px;
        }
        .profile-container img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
            background-color: #ddd;
        }
        .add-photo-btn {
            background-color: #FFD700;
            border: none;
            color: black;
            padding: 5px 15px; 
            border-radius: 15px;
            cursor: pointer;
            font-size: 12px;
            border: 1px solid #ccc;
            margin-top: 8px;
            display: inline-block;
        }
        .file-input {
            display: none;
        }
        table {
            width: 100%;
            border-spacing: 10px;
            table-layout: auto;
        }
        td.label {
            width: 30%;
            text-align: right;
            padding-right: 10px;
            font-weight: bold;
             vertical-align: middle;
        }
        td.input-field {
            width: 70%;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        input[name="us_id"],
input[name="us_password"] {
    background-color: #e0e0e0; 
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 8px;
    font-size: 14px;
    box-sizing: border-box;
}
       
        .password-container {
            position: relative;
            width: 100%;
        }
        .password-container input[type="password"] {
            width: 100%;
            padding-right: 90px; 
        }
        .change-password-btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background-color: #FFD700;
            color: black;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
        }
   .zipcode-container {
    display: flex;
    align-items: center;
    width: 100%; 
     gap: 0px;
}

.zipcode-container input[type="text"] {
    width: 100%; 
    height: 40px; 
    padding: 8px; 
    font-size: 14px; 
    border: 1px solid #ddd; 
    border-radius: 5px; 
    box-sizing: border-box; 
    margin-left: 0; 
}

.zipcode-btn {
    padding: 5px 10px; 
    font-size: 14px; 
    border-radius: 5px;
    background-color: #e0e0e0;
    border: 1px solid #ddd;
    cursor: pointer;
    height: 40px; 
    box-sizing: border-box; 
}

       .button-container {
    display: flex;
    justify-content: center; 
    gap: 17px;
    margin-top: 20px;
}

.submit-btn,
.delete-btn,
.logout-btn {
    width: 120px; 
    padding: 10px;
    background-color: #FFD700;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    color: #666;
    text-align: center;
    box-sizing: border-box;
}

        .delete-btn {
            background-color: #FFD700;  
            color: black;
        }
        .logout-btn {
            color: black;
            background-color: #FF6347;
        }
        
          /* 반응형 처리 */
        @media (max-width: 576px) {
            .container {
                padding: 15px;
                margin: 10px;
            }
            table {
                border-spacing: 5px;
            }
            td.label {
                text-align: left;
                width: 40%;
                padding-right: 5px;

            }
            td.input-field {
                width: 60%;
            }
            .zipcode-container {
                flex-direction: column;
                align-items: flex-start;
            }
            .button-container {
                flex-direction: column;
                gap: 10px;
            }
            .submit-btn,
            .delete-btn,
            .logout-btn {
                width: 100%;
            }
        }
    </style>


    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script>
        function confirmUpdate() {
            return confirm("수정하시겠습니까?");
        }
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('profilePreview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
        function openZipcodeSearch() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var fullAddr = data.address; 
                    var extraAddr = ''; 
                    
                    if (data.addressType === 'R') { 
                        if (data.bname !== '') extraAddr += data.bname;
                        if (data.buildingName !== '') extraAddr += (extraAddr !== '' ? ', ' : '') + data.buildingName;
                        fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                    }

                    // 입력 필드에 값 설정
                    document.getElementById('postcode').value = data.zonecode; 
                    document.getElementById('address').value = fullAddr; 
                }
            }).open();
        }

        
        function validateEmail(email) {
           
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return emailRegex.test(email);
        }

        function validateForm() {
            const emailField = document.querySelector('input[name="us_email"]');
            const email = emailField.value;

            if (!validateEmail(email)) {
                alert("유효한 이메일 주소를 입력해주세요.");
                emailField.focus();
                return false; 
            }

            return confirm("정보를 수정하시겠습니까?"); 
        }
    </script>

    </script>
</head>
<body>
    <%@include file="../../header.jsp" %>
    <main>
        <div class="container">
            <h2>내정보 수정</h2>
            <c:if test="${not empty message}">
                <script>alert("${message}");</script>
            </c:if>
            <form action="/us_myPage.do" method="post" enctype="multipart/form-data">
              <div class="profile-container">
  			<img id="profilePreview" src="${user.us_profile}" onerror="this.onerror=null; this.src='/resources/profile_images/default.jpg';" alt="프로필 이미지">
    
    <label class="add-photo-btn" for="profileImage">사진 추가</label>
    <input type="file" id="profileImage" class="file-input" name="us_profile_file" accept="image/*" onchange="previewImage(event)">
</div>

                
                 <div class="info-container">
            <table class="info-table">

                    <tr>
                        <td class="label">아이디:</td>
                        <td class="input-field"><input type="text" name="us_id" value="${user.us_id}" readonly></td>
                    </tr>
                   
                    <tr>
                        <td class="label">비밀번호:</td>
                        <td class="input-field">
                            <div class="password-container">
                                <input type="password" value="******" readonly>
<!--                                 <input type="password" name="us_password" value="********" readonly> -->
                                <button type="button" class="change-password-btn" onclick="location.href='/us_myPage2.do'">비밀번호 변경</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">이름:</td>
                        <td class="input-field"><input type="text" name="us_name" value="${user.us_name}" required></td>
                    </tr>
                    <tr>
                        <td class="label">닉네임:</td>
                        <td class="input-field"><input type="text" name="us_nick" value="${user.us_nick}" required></td>
                    </tr>
                    <tr>
                        <td class="label">이메일:</td>
                        <td class="input-field"><input type="email" name="us_email" value="${user.us_email}" required></td>
                    </tr>
            <tr>
    <td class="label">
        <button type="button" class="zipcode-btn" onclick="openZipcodeSearch()">우편번호 찾기</button>
    </td>
    <td class="input-field">
        <div class="zipcode-container">
            <input type="text" id="postcode" name="postcode" readonly value="${user.postcode}">
        </div>
    </td>
</tr>


                    <tr>
                        <td class="label">주소:</td>
                        <td class="input-field"><input type="text" id="address" name="us_address" value="${user.us_address}" required></td>
                    </tr>
                    <tr>
                        <td class="label">가입일:</td>
                        <td class="input-field"><input type="text" name="us_date" value="${user.us_date}" readonly></td>
                    </tr>
                </table>
             
<div class="button-container">
    <form action="/us_myPage.do" method="post" style="display:inline;" onsubmit="return confirmUpdate();">
        <button type="submit" class="submit-btn">정보 수정</button>  
    </form>
    <form action="userDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
        <input type="hidden" name="us_id" value="${user.us_id}">
         
        <button type="submit" class="delete-btn">탈퇴</button>
         <button type="button" onclick="location.href='/logout'" class="logout-btn">로그아웃</button>
    </form>
</div>

           
        </div>
</div>


                </div>
            </form>
        </div>
    </main>
    <%@include file="../../footer.jsp" %> 
</body>
</html>
