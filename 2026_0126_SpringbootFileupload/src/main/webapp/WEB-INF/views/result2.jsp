<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<hr><h4>업로드된 파일정보</h4><hr>
제목 : "${ title }"<br>
이미지1 : <img src="/images/${ filename1 }" width=500><br>
이미지2 : <img src="/images/${ filename2 }" width=500><br>

<a href="input2.html">다시하기</a>
</body>
</html>