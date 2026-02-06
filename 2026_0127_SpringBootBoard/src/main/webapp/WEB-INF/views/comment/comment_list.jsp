<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>

<!-- for(CommentVo  : list ) -->
<c:forEach var="vo" items="${ list }">
   <div>
        <!-- 1 line -->
		<div class="row">
		  <div class="col-sm-6"><b>${ vo.mem_name }</b></div>
		  <div class="col-sm-6" style="text-align: right;">
		     <input  type="button"  value="x">
		  </div>
		</div>
		
		<!-- 2 line -->
		<div style="color:#a3a3a3;">${ vo.cmt_regdate }</div>
		
		<!-- 3 line -->
		<div>${ vo.cmt_content }</div>
   </div>
   
   <hr>
</c:forEach>


</body>
</html>