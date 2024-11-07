$(document).ready(function() {
    // URL에 "cmty"가 포함된 경우 "active" 클래스 추가
    if (window.location.href.includes("cmty")) {
        $(".cmty-link").addClass("active");
    }
});