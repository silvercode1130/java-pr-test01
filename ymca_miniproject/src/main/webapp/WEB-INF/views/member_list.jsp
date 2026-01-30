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
 <table style="width:1000px; text-align:center">
	<tr>
		<th>회원번호</th>
		<th>ID</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>역할</th>
		<th>등급</th>
		<th>생일</th>
		<th>가입일</th>
	</tr>
	<c:forEach>
	<tr>
		<th>"${ mem_idx }"</th>
		<th>"${ mem_id }"</th>
		<th>"${ mem_pwd }"</th>
		<th>"${ mem_name }"</th>
		<th>"${ mem_tel }"</th>
		<th>"${ mem_email }"</th>
		<th>"${ mem_role}"</th>
		<th>"${ mem_grade }"</th>
		<th>"${ mem_bday }"</th>
		<th>"${ mem_regdate }"</th>
	</tr>
	
	</c:forEach>
 </table>
</body>
</html>