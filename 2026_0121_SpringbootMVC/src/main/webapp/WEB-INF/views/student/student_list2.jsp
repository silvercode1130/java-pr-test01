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
<c:forEach var="vo2" items="${ requestScope.list2 }">
	<tr>
		<td>${ vo2.name }</td>
		<td>${ vo2.age }</td>
		<td>${ vo2.gender }</td>
		<td>${ vo2.ip }</td>
		<td>${ vo2.seat_no }</td>
	</tr>
</c:forEach>
 </table>
</body>
</html>