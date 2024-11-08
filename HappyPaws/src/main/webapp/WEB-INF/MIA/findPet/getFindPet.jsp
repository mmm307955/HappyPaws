<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../MIA.jsp"%>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script>
$(document).ready(function() {
    function setupEventHandlers() {
        $("#fpMod").click(function() {
            document.fm.action = "/updateFindPet.do";
            document.fm.method = "get";
            document.fm.fp_seq.value = "${findPet.fp_seq}";
            document.fm.nowPage.value = "${nowPage}" || 1;
            document.fm.searchCondition.value = "${searchCondition}";
            document.fm.searchKeyword.value = "${searchKeyword}";
            document.fm.category.value = "${category}";
            document.fm.submit();
        });

        $("#fpDel").click(function() {
            let con_test = confirm("정말로 삭제하시겠습니까?");
            if (con_test) {
                let s = document.fm.fp_seq.value;
                location.href = "/deleteFindPet.do?fp_seq=" + s;
            }
        });

        $("#fpList").click(function() {
            document.hideFrm.action = "/getFindPetList.do";
            document.hideFrm.method = "post";
            document.hideFrm.nowPage.value = "${nowPage}" || 1;
            document.hideFrm.searchCondition.value = "${searchCondition}";
            document.hideFrm.searchKeyword.value = "${searchKeyword}";
            document.hideFrm.category.value = "${category}";
            document.hideFrm.submit();
        });

        $(document).on('click', '#open', function() {
        	let fpCommentDiv = $(this).closest(".fpComment");
            let fpcMod1 = fpCommentDiv.find(".fpcMod1");
            let fpcMod2 = fpCommentDiv.find(".fpcMod2");
            let fpcMod3 = fpCommentDiv.find(".fpcMod3");
        	fpcMod1.hide();
            fpcMod2.show();
            fpcMod3.hide();
        });
        
        $(document).on('click', '#close', function() {
        	let fpCommentDiv = $(this).closest(".fpComment");
            let fpcMod1 = fpCommentDiv.find(".fpcMod1");
            let fpcMod2 = fpCommentDiv.find(".fpcMod2");
            let fpcMod3 = fpCommentDiv.find(".fpcMod3");
        	fpcMod1.show();
            fpcMod2.hide();
            fpcMod3.show();
        });
        
        $(document).on('click', '#fpcMod', function() {
            let fpCommentDiv = $(this).closest(".fpComment");
            let fpcMod1 = fpCommentDiv.find(".fpcMod1");
            let fpcMod2 = fpCommentDiv.find(".fpcMod2");
            let textarea = fpCommentDiv.find("textarea");

                // 댓글 내용 확인
                let content = $.trim(textarea.val());
                let fp_seq = fpCommentDiv.find("input[name='fp_seq']").val();
                let fpc_seq = fpCommentDiv.find("input[name='fpc_seq']").val();

                if (content === '') {
                    alert("댓글 내용을 입력해야 합니다.");
                    textarea.focus(); // 텍스트 영역에 포커스
                    return;
                }

                if (fp_seq && fpc_seq) {
                    location.href = "/updateFpComment.do?fp_seq=" + fp_seq +
                        "&fpc_seq=" + fpc_seq +
                        "&fpc_content=" + encodeURIComponent(content) +
                        "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
                        "&searchCondition=" + encodeURIComponent("${searchCondition}") +
                        "&category=" + encodeURIComponent("${category}") +
                        "&nowPage=" + "${nowPage}";
                } else {
                    console.error("수정할 수 없는 댓글입니다.");
                }            
        });

        $(document).on('click', '#fpcDel', function() {
            let con_test = confirm("정말로 삭제하시겠습니까?");
            if (con_test) {
                let fp_seq = $(this).closest(".fpComment").find("input[name='fp_seq']").val();
                let fpc_seq = $(this).closest(".fpComment").find("input[name='fpc_seq']").val();

                if (fp_seq && fpc_seq) {
                    location.href = "/deleteFpComment.do?fp_seq=" + fp_seq +
                        "&fpc_seq=" + fpc_seq +
                        "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
                        "&searchCondition=" + encodeURIComponent("${searchCondition}") +
                        "&category=" + encodeURIComponent("${category}") +
                        "&nowPage=" + "${nowPage}";
                } else {
                    console.error("삭제할 수 없는 댓글입니다.");
                }
            }
        });
    }

    setupEventHandlers();
});
</script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_write">
			<div class="n_viewform">
				<h1>아이를 찾아주세요</h1>
				<div class="n_title">
					<span class="title">
						${findPet.fp_title}
						<c:if test="${findPet.fp_ok == 'Y'}">
							<span style="color: red; font-weight: bold;">[찾았어요]</span>
						</c:if>
					</span>
					<span class="author">작성자: ${findPet.us_nick}</span>
				</div>
				<div class="n_second">
					<span class="cnt">조회수: ${findPet.fp_cnt}</span>
					<span class="date">작성일: ${findPet.fp_date}</span>
				</div>

				<div class="n_third">
					<div class="ph">연락처: ${findPet.fp_ph}</div>
					<img src="${pageContext.request.contextPath}/resources/MIA-img/findPetImg/${findPet.fp_img}" alt="Find Pet Image" class="find-pet-image">
					<table class="detail-table">
						<tr class="detail-row">
							<td class="label">실종 장소</td>
							<td class="value">${findPet.fp_place}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">실종 날짜</td>
							<td class="value">${findPet.fp_time}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">품종</td>
							<td class="value">${findPet.fp_breed}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">사례금</td>
							<td class="value">${findPet.formattedReward}원</td>
						</tr>
					</table>
				</div>

				<form name="fm">
					<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="nowPage" value="${nowPage}">
					<div class="n_content">
						<p>${fn:replace(findPet.fp_content, lf, "<br>")}</p>
					</div>
				</form>
			</div>
		</div>

		<form name="hideFrm" style="display: none;">
			<input type="hidden" name="searchKeyword" value="${searchKeyword}">
			<input type="hidden" name="searchCondition" value="${searchCondition}">
			<input type="hidden" name="category" value="${category}">
			<input type="hidden" name="nowPage" value="${nowPage}">
		</form>

		<div class="commentlist">
			<c:forEach var="fpComment" items="${fpComment}">
				<div class="fpComment">
					<input type="hidden" name="fp_seq" value="${fpComment.fp_seq}">
					<input type="hidden" name="fpc_seq" value="${fpComment.fpc_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="nowPage" value="${nowPage}">
					<div>
						<strong><c:out value="${fpComment.us_nick}" /></strong>
						<span><c:out value="${fpComment.fpc_date}" /></span>
					</div>
					<div>
						<p class="fpcMod1">
							<c:out value="${fpComment.fpc_content}" />
						</p>
						<div class="fpcMod2" style="display: none">
							<textarea name="fpc_content" required>${fpComment.fpc_content}</textarea>
							<div class="btn-container">
								<button id="fpcMod" type="button">수정</button>
								<button id="close" type="button">닫기</button>
							</div>
						</div>
						<div class="fpcMod3">
							<button id="open" type="button">수정</button>
							<button id="fpcDel" type="button">삭제</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<form action="insertFpComment.do" method="post" class="fpCommentwrite">
			<div class="fpComment">
				<input type="hidden" name="fpc_id" value="admin">
				<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
				<input type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="category" value="${category}">
				<input type="hidden" name="nowPage" value="${nowPage}">
				<strong>관리자</strong>
				<textarea id="fpc_content" name="fpc_content" required></textarea>
				<div class="btn-container">
					<button type="submit">등록</button>
				</div>
			</div>
		</form>

		<section class="commandList">
			<div class="btn-container">
				<button id="fpMod" type="button">글 수정</button>
				<button id="fpDel" type="button">글 삭제</button>
				<button id="fpList" type="button">글 목록</button>
			</div>
		</section>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>
