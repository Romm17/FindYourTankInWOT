<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<body>
<h1>Title : ${title}</h1>
<h1>Message : ${message}</h1>

<c:if test="${pageContext.request.userPrincipal.name != null}">
    <h2>Welcome : ${pageContext.request.userPrincipal.name} | <c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}"
			  method="post">
			<input type="submit"
				   value="Log out" />
			<input type="hidden"
				   name="${_csrf.parameterName}"
				   value="${_csrf.token}"/>
		</form>
	</h2>

</c:if>

<!-- Alternative
	<c:if test="${pageContext.request.remoteUser != null}">
		<h2>Welcome : ${pageContext.request.remoteUser}</h2>
	</c:if>`
 	-->

</body>
</html>