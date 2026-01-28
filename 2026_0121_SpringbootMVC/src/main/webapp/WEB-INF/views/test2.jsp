<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 전달된 데이터(test2.do) : ${ requestScope.msg }
  <c:forEach var="fruit" items="${ requestScope.fruit_arr }">
  	<li>${ fruit }</li><br>
  </c:forEach>
</body>
</html>