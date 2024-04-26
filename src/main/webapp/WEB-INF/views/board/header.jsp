<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="icon" href="${pageContext.request.contextPath}/image/home.ico">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<meta name="_csrf" 		  content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script>
$(function(){
	$("#logout").click(function(event){
		event.preventDefault();
	 	$("form[name=logout]").submit();
	})
})
</script>
<style>
body > nav.navbar {
	justify-content: flex-end; /* 오른쪽 정렬 */
}

.dropdown-menu {
min-width: 0rem; 
}

/* nav 색상 지정 */
.navbar {
	background: #096988;
	margin-bottom: 3em;
	padding-right: 3em;
}

.navbar-dark .navbar-nav .nav-link {
	color: rgb(255, 255, 255);
}

textarea {
	resize: none;
}
</style>
<%-- 현재 사용자가 인증되지 않은 사용자인 경우 --%>
<sec:authorize access="isAnonymous()">
	<script>
		location.href = "${pageContext.request.contextPath}/member/login";
	</script>
</sec:authorize>
<nav class="navbar navbar-expand-sm right-block navbar-dark">
	<!-- Brand -->
	<!-- <a class="navbar-brand" href="#">Logo</a> -->

	<ul class="navbar-nav">
		<sec:authorize access="isAuthenticated()"><%-- 현재 사용자가 인증이 된 사용자인 경우 --%>
			<sec:authentication property="principal" var="pinfo"/>
			<%-- sec:authentication를 통해 JSP 페이지에서 
				 현재 사용자의 인증 정보를 쉽게 접근할 수 있도록 도와줍니다.
				 인증된 정보를 변수 pinfo에 저장하라는 의미입니다. --%>
			<li class="nav-item">
				<form action="${pageContext.request.contextPath}/member/logout" method="post"
					  style="margin-bottom:0px" name="logout">
				 <a class="nav-link" href="#" id="logout">
					 <span id="loginid">${pinfo.username}</span> 님(로그아웃)
				 </a>
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/member/update">정보수정</a></li>
			
		<c:if test="${pinfo.username=='admin'}">
		 <!-- Dropdown -->
		 <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" 
				data-toggle="dropdown"> 관리자 </a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/member/list">회원정보</a>
				<a class="dropdown-item" href="${pageContext.request.contextPath}/board/list">게시판</a>
			</div>
		 </li>
		</c:if>
		</sec:authorize>
	</ul>
</nav>








