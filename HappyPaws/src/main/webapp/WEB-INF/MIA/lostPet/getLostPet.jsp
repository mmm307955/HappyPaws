<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../../../header.jsp"%>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.link {
	text-decoration: underline;
	color: #005ACD;
}

#articleForm {
	width: 100%;
	margin: auto;
}

h2 {
	text-align: center;
}

#basicInfoArea {
	padding: 10px;
	margin: 10px;
	position: relative;
	height: 50px;
	text-align: left;
	border-top: solid 2px #000;
	border-bottom: solid 2px #000;
}

#basicInfoArea h3 {
	float: left;
}

#basicInfoArea p {
	float: right;
}

#articleNameArea {
	display: flex;
	align-items: center;
	justify-content: space-between;
	widht: 100%;
	height: 30px;
	margin: 10px;
	padding: 0 10px;
	text-align: right;
	margin-bottom: 0px;
}

#articleNameArea .btn-list {
	display: flex;
}

#articleNameArea .btn-list li {
	margin: 0 5px;
}

#articleContentArea {
	background: #EAEAED;
	padding: 10px;
	margin: 10px;
	min-height: 350px;
	height: fit-content;
	border-top: solid 2px #000;
}

#articleFileArea {
	widht: 100%;
	height: 30px;
	margin: 10px;
	padding: 0 10px;
	text-align: right;
	margin-top: 0px;
}

#commandList {
	margin: auto;
	width: 100%;
	text-align: center;
}

#imgDiv {
	position: absolute;
	top: 0;
	left: 20px;
	width: 90%;
	height: 250px;
	border: 1px solid #ccc;
	border-radius: 8px;
	overflow-y: auto;
	background-color: #fff;
	padding: 0px;
}

#lpCommentsSection {
	margin: 10px;
	border-top: solid 2px #000;
}

#lpCommentsSection .lpComment {
	margin-top: 10px;
}

#lpCommentsSection .lpComment div strong {
	
}

#lpCommentsSection .lpComment div span {
	float: right;
	font-size: 14px;
	color: #242424;
}

#lpCommentsSection .lpComment div:nth-of-type(2) {
	margin-top: 10px;
	border-bottom: solid 1px #ccc;
}

#lpCommentsSection .lpComment div p {
	display: inline-block;
	width: calc(100% - 40px);
	margin-bottom: 10px;
}

#lpCommentsSection .lpComment div button {
	width: 35px;
	float: right;
	border: none;
	cursor: pointer;
}

#lpComment {
	border: 1px solid #ccc;
	width: 100%;
	height: 100px;
	padding: 10px;
	overflow: auto;
}

#lpCommentwrite {
	display: flex;
	justifiy-content: center;
	width: 100%;
	padding: 10px 0;
	/* 	border: 1px solid #ccc; */
}

#lpCommentwrite strong {
	width: 50px;
	line-height: 60px;
	text-align: center;
}

#lpCommentwrite textarea {
	width: calc(100% - 100px);
	height: 60px;
	padding: 5px;
	border-radius: 5px 0 0 5px;
}

#lpCommentwrite button {
	width: 50px;
	border: 1px solid #242424;
	border-radius: 0 5px 5px 0;
}

img {
	display: block;
}

#commandList a {
	display: inline-block;
	background-color: #0B4DA2; /* 파란색 배경 */
	color: white; /* 글자색 흰색 */
	padding: 10px 20px; /* 내부 여백 */
	text-decoration: none; /* 밑줄 제거 */
	border-radius: 5px; /* 둥근 테두리 */
	font-weight: bold; /* 글자 두껍게 */
}

#commandList a:hover {
	background-color: #0056b3; /* 마우스 오버 시 어두운 파란색 */
}

input, textarea {
	font-size: 16px;
}
</style>
<script>
$(document).ready(function() {
    function setupEventHandlers() {
        $("#lpDel").click(function() {
            let con_test = confirm("정말로 삭제하시겠습니까?");
            if (con_test) {
                let s = document.fm.lp_seq.value;
                location.href = "/deleteLostPet.do?lp_seq=" + s;
            }
        });

        $("#lpList").click(function() {
            document.hideFrm.action = "/getLostPetList.do";
            document.hideFrm.method = "post";
            document.hideFrm.nowPage.value = "${nowPage}" || 1;
            document.hideFrm.searchCondition.value = "${searchCondition}";
            document.hideFrm.searchKeyword.value = "${searchKeyword}";
            document.hideFrm.category.value = "${category}";
            document.hideFrm.submit();
        });

        $("#lpMod").click(function() {
            document.fm.action = "/updateLostPet.do";
            document.fm.method = "get"; 
            document.fm.enctype = "multipart/form-data";
            document.fm.submit(); 
        });
    }

    setupEventHandlers();
});
</script>


<body>
	<%@ include file="../../../menu.jsp"%>
	<div class="jumbotron">
		<h1>상세 보기</h1>
	</div>
	<section id="articleForm">
		<form name="fm">
			<input type="hidden" name="lp_seq" value="${lostPet.lp_seq}">
			<div id="basicInfoArea">
				<h3>${lostPet.lp_title}</h3>
			</div>
			<div id="articleNameArea">
				<div>${lostPet.lp_id}</div>
				<div>${lostPet.lp_date}</div>
			</div>
			<%
			pageContext.setAttribute("lf", "\n");
			%>
			<div id="articleContentArea">
				<img
					src="${pageContext.request.contextPath}/resources/MIA-img/lostPetImg/${lostPet.lp_img}"
					alt="Lost Pet Image">
				<p>${fn:replace(lostPet.lp_content, lf, "<br>")}</p>
			</div>
		</form>
	</section>

	<form name="hideFrm" style="display: none;">
		<input type="hidden" name="searchKeyword" value="${searchKeyword}">
		<input type="hidden" name="searchCondition" value="${searchCondition}">
		<input type="hidden" name="category" value="${category}"> 
		<input type="hidden" name="nowPage" value="${nowPage}">
	</form>

	<c:forEach var="lpComment" items="${lpComment}">
		<div class="lpComment">
			<span style="display: none;">${lpComment.lpc_seq}</span>
			<div>
				<strong><c:out value="${lpComment.lpc_id}" /></strong> <span><c:out
						value="${lpComment.lpc_date}" /></span>
			</div>
			<div>
				<p>
					<c:out value="${lpComment.lpc_content}" />
				</p>
				<c:if
					test="${sessionScope.id == lostPet.lp_id || sessionScope.id == 'admin'}">
					<button onclick="removelpComment(${lpComment.lpc_seq})">[삭제]</button>
				</c:if>
			</div>
		</div>
	</c:forEach>

	<c:if test="${not empty sessionScope.id}">
	</c:if>
		<form action="lpCommentWrite.do" method="post" id="lpCommentwrite">
			<input type="hidden" name="lpc_ID" value="admin"> 
			<input type="hidden" name="lp_seq" value="${lostPet.lp_seq}"> 
			<input type="hidden" name="searchKeyword" value="${searchKeyword}">
			<input type="hidden" name="searchCondition" value="${searchCondition}">
			<input type="hidden" name="category" value="${category}"> 
			<input type="hidden" name="nowPage" value="${nowPage}">
			<strong>닉네임</strong>
			<textarea id="lpComment_CONTENT" name="lpComment_CONTENT" required></textarea>
			<button>등록</button>
		</form>
	
	
	<section id="commandList">
		<c:if
			test="${sessionScope.id==lostPet.lp_id || sessionScope.id=='admin' }">
		</c:if>
		<button id="lpMod" type="button" class="btn btn-primary">글수정</button>
		<button id="lpDel" type="button" class="btn btn-primary">글삭제</button>
		<button id="lpList" type="button" class="btn btn-primary">글목록</button>
	</section>

</body>
</html>
