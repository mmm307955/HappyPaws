$(document).ready(function(){ 
	
	//Quill 라이브러리
	if ($('#editor').length) {
		
		var quill = new Quill('#editor', {
			theme: 'snow',
			modules: {
			  toolbar: {
				container: [
				  [{ 'header': [1, 2, false] }],
				  ['bold', 'italic', 'underline'],
				  ['image','code-block'],
				  [{ list: 'ordered' }, { list: 'bullet' }]
				],
				handlers: {
					image: imageHandler  // 커스텀 이미지 핸들러
				}
			  }
			}
		  });
	}
	
	 // 이미지 핸들러 함수
	 function imageHandler() {
		var input = document.createElement('input');
		input.setAttribute('type', 'file');
		input.setAttribute('accept', 'image/*');
		input.click();
  
		input.onchange = function () {
		  var file = input.files[0];
		  var formData = new FormData();
		  formData.append('file', file);
  
		  // 서버로 이미지 업로드
		  $.ajax({
			url: '/upload',  // 이미지 업로드 서버 URL
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function (data) {
			  // 서버로부터 이미지 URL을 받음
			  var imageUrl = data.url;
  
			  // Quill 에디터에 이미지 삽입
			  var range = quill.getSelection();
			  quill.insertEmbed(range.index, 'image', imageUrl);
			},
			error: function (error) {
			  console.error('Image upload failed:', error);
			}
		  });
		};
	  }

	//공지사항 
	
	//취소버튼 
	$(".n_backButton").click(function(){
		window.history.back();
	});


	//글쓰기 페이지로
	$("#notice_write").click(function(){
		location.href = "/board/notice_write";
	});

	//공지사항 목록 페이지로
	$("#notice_list").click(function(){
		document.hideFrm.action="/board/notice_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//공지사항 글 수정페이지로
	$('.notice_modify').on('click', function() {
        var val = $(this).data('seq');
        location.href = "/board/notice_modify?n_seq=" + val // URL을 변경합니다.
    });
	
	//공지사항 글 삭제
	$('.notice_delete').on('click', function() {
		var val = $(this).data('seq');
		location.href = "/board/notice_delete?n_seq=" + val
	});

	//공지사항 상세페이지
	$('.notice_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/board/notice_view?n_seq=" + val + 
		"&n_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });
	
	//공지사항-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#noticeForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#n_content').val(content); 
	});


	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
	});
	
	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#conWrite").click(function(){
		location.href = "/insertBoard.do";
	});
	
	$("#conDel").click(function(){
		let con_test = confirm("정말로 삭제하시겠습니까?");
		if(con_test == true){
			let s = document.fm.seq.value;
			let w = document.fm.writer.value;
			location.href = "/deleteBoard.do?seq="+s+"&writer="+w;
		}
		else if(con_test == false){
		  	return false;
		}
	});
	
	
	/* 241017_추가 페이징처리와 목록, 검색 유지 기능 처리*/
	$("#conList").click(function(){
		document.hideFrm.action="/getBoardList.do";
		document.hideFrm.method="post";
		document.hideFrm.submit();
	});


	/*====================QNA==================== */
	//QNA 상세페이지
	$('.qna_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/board/qna_view?qna_seq=" + val + 
		"&qna_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//QNA 목록 페이지로
	$("#qna_list").click(function(){
		document.hideFrm.action="/board/qna_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//QNA 글 수정페이지로
	$('.qna_modify').on('click', function() {
		var val = $(this).data('seq');
		location.href = "/board/qna_modify?qna_seq=" + val // URL을 변경합니다.
	});

	//QNA-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#qnaForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#qna_content').val(content); 
	});

	//QNA 페이지로
	$("#qna_write").click(function(){
		location.href = "/board/qna_write";
	});

	//QNA 글 삭제
	$('.qna_delete').on('click', function() {
		var val = $(this).data('seq');
		location.href = "/board/qna_delete?qna_seq=" + val
	});


    // 댓글 등록 -QNA
    $('#submitComment').click(function() {
        const commentContent = $('#commentContent').val();
		const qna_seq = $('#submitComment').val();

        if (!commentContent) {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/board/addComment",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "POST",
            data: {
                "qna_seq": qna_seq,                  // 해당 qna_seq 설정
                "qna_cmt_id": "사용자 아이디",           // 실제 사용자 아이디 설정
                "qna_cmt_content": commentContent
            },
            success: function() {
                $('#commentContent').val('');  // 입력 필드 초기화
                loadComments();                // 댓글 목록 새로고침
            }
        });
    });

    // 댓글 삭제 -QNA
    window.deleteComment = function(qna_cmt_seq) {

        $.ajax({
            url: "/board/deleteComment?qna_cmt_seq="+qna_cmt_seq,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "GET",
            success: function() {
                loadComments();  // 댓글 목록 새로고침
            }
        });
    };

	//======================커뮤니티============================
	//커뮤니티 상세페이지
	$('.cmty_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/board/cmty_view?cmty_seq=" + val + 
		"&cmty_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//QNA 목록 페이지로
	$("#cmty_list").click(function(){
		document.hideFrm.action="/board/cmty_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//커뮤니티 글 수정페이지로
	$('.cmty_modify').on('click', function() {
		var val = $(this).data('seq');
		location.href = "/board/cmty_modify?cmty_seq=" + val // URL을 변경합니다.
	});

	//커뮤니티-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#cmtyForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#cmty_content').val(content); 
	});

	//커뮤니티 페이지로
	$("#cmty_write").click(function(){
		location.href = "/board/cmty_write";
	});

	//커뮤니티 글 삭제
	$('.cmty_delete').on('click', function() {
		var val = $(this).data('seq');
		location.href = "/board/cmty_delete?cmty_seq=" + val
	});

	// 댓글 등록 -QNA
    $('#cmty_comment').click(function() {
        const commentContent = $('#commentContent').val();
		const cmty_seq = $('#cmty_comment').val();

        if (!commentContent) {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/board/c_addComment",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "POST",
            data: {
                "cmty_seq": cmty_seq,                  // 해당 qna_seq 설정
                "cmty_cmt_id": "작성자아이디",           // 실제 사용자 아이디 설정
                "cmty_cmt_content": commentContent
            },
            success: function() {
                $('#commentContent').val('');  // 입력 필드 초기화
                c_loadComments();                // 댓글 목록 새로고침
            }
        });
    });

	//커뮤니티 답글달기
	$(document).on("click", ".c_comment", function() {
		const commentId = $(this).data("cmty_cmt_seq");

		// 기존 입력 폼이 있으면 삭제
		$(".reply-form").remove();

		// 댓글 쓰기 폼 HTML 생성
		const replyFormHtml = `
			<div class="reply-form" style="margin-top: 10px;">
				<div>
					<span>댓글쓰기<span>
					<button class="reply-form-close">x닫기</button>
				</div>
				<textarea rows="2" placeholder="답글을 입력하세요"></textarea>
				<button class="submit-reply" data-cmty_cmt_parent_seq="${commentId}">등록</button>
			</div>
		`;

		// 현재 댓글 밑에 폼 추가
		$(`#comment-${commentId}`).after(replyFormHtml);
	});

	//커뮤니티 답글달기 창 닫기
	$(document).on("click", ".reply-form-close", function() {
		$(".reply-form").remove();
	});

	// 대댓글 등록 AJAX
	$(document).on("click", ".submit-reply", function() {
		const commentId = $(this).data("cmty_cmt_parent_seq"); // 부모 댓글 ID
		const replyContent = $(this).siblings("textarea").val(); // 입력된 답글 내용
		const cmty_seq = $('#cmty_comment').val();

		if (!replyContent) {
			alert("답글 내용을 입력하세요.");
			return;
		}

		$.ajax({
			url: "/board/c_addReply", 
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"cmty_seq": cmty_seq,
				"cmty_cmt_parent_seq": commentId,
				"cmty_cmt_id": "작성자아이디",  // 실제 사용자 아이디 설정
				"cmty_cmt_content": replyContent
			},
			success: function() {
				$(".reply-form").remove();  // 입력 폼 초기화
				loadReplies(commentId);     // 대댓글 목록 새로고침
			},
			error: function(error) {
				console.error("대댓글 등록 실패:", error);
				alert("대댓글 등록에 실패했습니다.");
			}
		});
	});
});

//댓글 목록 불러오기 -QNA
function loadComments() {
	const qna_seq = $('#submitComment').val();
    $.ajax({
        url: "/board/commentList?qna_seq="+qna_seq,  // qna_seq에 맞는 댓글 불러오기
        method: "GET",
        success: function(comments) {
            $('#commentList').empty();
            comments.forEach(comment => {
                $('#commentList').append(`
                    <div class="comment">
						<div class="comment-header">
							<span class="comment-id">${comment.qna_cmt_id}</span>
							<span class="comment-date">${comment.qna_cmt_date}</span>
						</div>
						<div class="comment-body">
							<span class="comment-content">${comment.qna_cmt_content}<span>
							<button class="comment-delete" onclick="deleteComment(${comment.qna_cmt_seq})">삭제</button>
						</div>
                    </div>
                `);
            });
        }
    });
}

//댓글 목록 불러오기 -커뮤니티
function c_loadComments() {
	const cmty_seq = $('#cmty_comment').val();
    $.ajax({
        url: "/board/c_commentList?cmty_seq="+cmty_seq,  // cmty_seq 맞는 댓글 불러오기
        method: "GET",
        success: function(comments) {
            $('#commentList').empty();
            comments.forEach(comment => {
                $('#commentList').append(`
                    <div class="comment" id="comment-${comment.cmty_cmt_seq}">
						<div class="comment-header">
							<span class="comment-id">
								${comment.cmty_cmt_id}
								<button class="c_comment" data-cmty_cmt_seq="${comment.cmty_cmt_seq}">답글달기</button>
							</span>
							<span class="comment-date">${comment.cmty_cmt_date}</span>
						</div>
						<div class="comment-body">
							<span class="comment-content">${comment.cmty_cmt_content}<span>
							<button class="comment-delete" onclick="deleteComment(${comment.cmty_cmt_seq})">삭제</button>
						</div>
                    </div>
                `);
            });
        }
    });

}