$(document).ready(function() {
    // URL에 "cmty"가 포함된 경우 "active" 클래스 추가
    if (window.location.href.includes("cmty_")) {
        $(".cmty-link").addClass("active");
    }
    
    if (window.location.href.includes("qna_")) {
        $(".qna-link").addClass("active");
    }
    
    if (window.location.href.includes("notice_")) {
        $(".notice-link").addClass("active");
    }
    
    if (window.location.href.includes("pr_")) {
        $(".pr_-link").addClass("active");
    }
   
    
});