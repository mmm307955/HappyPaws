<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header>
	<div class="admin-header-container">
		<!-- 로고 -->
		<div class="logo">
			<a href="/index.jsp"><img src="${pageContext.request.contextPath}/resources/images/HappyPawsLogo.png" alt="로고"/></a>
	    </div>
	    <div class="header-menu">
	    	<a href="${pageContext.request.contextPath}/admin">메인</a>
		    <a href="#">회원관리</a>
		    <a href="#">상품관리</a>
		    <a href="#">유기동물</a>
		    <a href="${pageContext.request.contextPath}/admin/ad_notice_list" class="notice-link">공지사항</a>
		    <a href="#">Q&amp;A</a>
		    <a href="#">커뮤니티</a>
		    <a href="#">마이페이지</a>
	    </div>
       	
       	<div id="session-info" data-user-id="${user.us_id}" style="display: none"></div>
   </div>
</header>
<aside>
	 <script>
        $(document).ready(function() {
            if (window.location.href.includes("ad_notice_")) { //url에 포함되어있는것만
                $(".notice-link").addClass("active"); //클릭된 링크 노랑색으로
                $("aside").html(
                	'<h3>공지사항</h3>'+
                	'<ul>'+
                    '<li><a href="#" class="notice-link">공지사항 메뉴 1</a></li>' +
                    '<li><a href="#" class="notice-link">공지사항 메뉴 2</a></li>' +
                   	'</ul>'
                );
            } else if (window.location.href.includes("member")) {
                $(".member-link").addClass("active");
            } else if (window.location.href.includes("products")) {
                $(".products-link").addClass("active");
            } else if (window.location.href.includes("qna")) {
                $(".qna-link").addClass("active");
            } else {
                $(".home-link").addClass("active");
            }
        });
    </script>
</aside>
