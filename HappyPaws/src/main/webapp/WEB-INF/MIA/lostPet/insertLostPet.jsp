<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>

<style>
    #registForm {
        width: 90%;
        border: 1px solid #ccc;
        margin: auto;
        padding: 20px;
        background-color: #f9f9f9;
    }

    h2, .jumbotron h1 {
        text-align: center;
        color: #333;
    }

    .input-group {
        margin-bottom: 15px;
    }

    .input-group-prepend span {
        width: 100px;
        display: inline-block;
        text-align: center;
        background-color: #eee;
        border: 1px solid #ddd;
        padding: 10px 0;
    }

    input, select, textarea {
        font-size: 16px;
        width: 100%;
    }

    #commandCell {
        text-align: center;
        margin-top: 20px;
    }

    #submit {
        display: inline-block;
        background-color: #0B4DA2;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        border: none;
        font-size: 16px;
    }

    #submit:hover {
        background-color: #0056b3;
        cursor: pointer;
    }

    .form-row {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }

    .left-column, .right-column {
        flex: 1;
        min-width: 200px;
    }

    .filebox {
        display: block;
        margin-top: 10px;
        text-align: center;
    }

    .image-box {
        max-width: 100%;
        height: auto;
        margin-bottom: 10px;
    }
</style>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        const fileDOM = document.querySelector('#file2'); // 사진 업로드 input
        const preview = document.querySelector('.image-box'); // 이미지 미리보기

        fileDOM.addEventListener('change', () => {
            const reader = new FileReader();
            reader.onload = ({ target }) => {
                preview.src = target.result; // 미리보기 이미지 업데이트
            };
            if (fileDOM.files[0]) {
                reader.readAsDataURL(fileDOM.files[0]); // 선택된 파일의 데이터 URL 읽기
            }
        });
    });
</script>

<body>
    <div class="jumbotron">
        <h1>글 작성</h1>
    </div>
    <section id="writeForm">
        <form id="registForm" action="/insertLostPet.do" method="post" enctype="multipart/form-data" name="boardform">
            <input type="hidden" name="lp_id" value="${sessionScope.id}">

            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">제목</span>
                </div>
                <input type="text" class="form-control" name="lp_title" placeholder="제목을 입력하세요." required>
            </div>

            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">연락처</span>
                </div>
                <input type="text" class="form-control" name="lp_ph" placeholder="연락처를 입력하세요." required>
            </div>

             <div class="form-row">
                <div class="left-column">
                    <div class="filebox">
                        <img src="${pageContext.request.contextPath}/resources/MIA-img/lostPetImg/기본이미지.png" class="image-box" />
                        <label for="file2" class="upload-btn" style="cursor: pointer;">
                            <input id="file2" type="file" name="uploadFile" accept="image/*" style="display:none;" />
                            <span>사진 첨부</span>
                        </label>
                    </div>
                </div>

                <div class="right-column">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">실종 장소</span>
                        </div>
                        <input type="text" class="form-control" name="lp_place" placeholder="실종 장소 입력" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">실종 일시</span>
                        </div>
                        <input type="date" class="form-control" name="lp_time" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">분류</span>
                        </div>
                        <select class="form-control" name="lp_category" required>
                            <option value="dog">강아지</option>
                            <option value="cat">고양이</option>
                            <option value="mini">소동물</option>
                            <option value="etc">기타</option>
                        </select>
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">품종</span>
                        </div>
                        <input type="text" class="form-control" name="lp_breed" placeholder="품종 입력" required>
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">사례금</span>
                        </div>
                        <input type="number" class="form-control" name="lp_reward" placeholder="숫자만 입력해주세요" min="0" required>
                    </div>
                </div>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text">상세 설명</span>
                </div>
                <textarea class="form-control" rows="5" name="lp_content" placeholder="상세 설명을 입력하세요"></textarea>
            </div>

            <input type="hidden" name="lp_ok" value="N">
            <input type="hidden" name="lp_del" value="N">

            <div id="commandCell">
                <input id="submit" type="submit" value="글 등록">
            </div>
        </form>
    </section>
</body>
</html>
