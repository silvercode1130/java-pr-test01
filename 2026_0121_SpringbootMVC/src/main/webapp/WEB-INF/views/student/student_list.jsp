<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<hr><h1>학생목록</h1><hr>
 <table border="1px" width=700px style="text-align:center;">
	<tr>
		<th>이름</th>
		<th>나이</th>
		<th>성별</th>
		<th>ip</th>
		<th>분단</th>
	</tr>
<c:forEach var="vo" items="${ requestScope.list }">
	<tr>
		<td>${ vo.name }</td>
		<td>${ vo.age }</td>
		<td>${ vo.gender }</td>
		<td>${ vo.ip }</td>
		<td>${ vo.seat_no }</td>
	</tr>
</c:forEach>
 </table>
</body>
</html>