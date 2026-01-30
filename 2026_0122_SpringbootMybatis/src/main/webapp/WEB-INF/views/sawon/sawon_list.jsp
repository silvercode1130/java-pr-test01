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
 <table border=1px style="width:1000px; text-align:center;">
 	<tr>
 		<th>사원번호</th>
 		<th>이름</th>
 		<th>성별</th>
 		<th>부서번호</th>
 		<th>업무</th>
 		<th>입사일</th>
 		<th>상사번호</th>
 		<th>연봉</th>
 	</tr>
 	<!-- data -->
 	<c:forEach var="vo" items="${ requestScope.list }">
	 	<tr>
	 		<td>${ vo.sabun }</td>
	 		<td>${ vo.saname }</td>
	 		<td>${ vo.sagender }</td>
	 		<td>${ vo.deptno }</td>
	 		<td>${ vo.sajob }</td>
	 		<td>${ vo.sahire }</td>
	 		<td>${ vo.samgr }</td>
	 		<td>${ vo.sapay }</td>
	 	</tr>
 	</c:forEach>
 </table>
</body>
</html>