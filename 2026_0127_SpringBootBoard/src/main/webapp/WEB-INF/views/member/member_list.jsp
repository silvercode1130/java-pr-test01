<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Bootstrap 3.x -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<style type="text/css">
	#box{
		width:1000px;
		margin:auto;
		margin-top: 50px;
	}
	
	#title{
		text-align:center;
		font-size:26px;
		color:rgb(51,122,183);
		text-shadow: 1px 1px 1px white;
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">
function member_delete(f){
	
	// 삭제확인
	if(confirm("정말 삭제 하시겠습니까?")==false)return;
	
	f.method = "POST";		// delete.do?mem_idx=1 방식의 삭제는 허용하지 않겠다
	f.action = "delete.do";	//MemberDeleteAction
	f.submit();
	
}
</script>
</head>
<body>
 <div id="box">
 	<h1 id="title">::::회원목록::::</h1>
 	
 	<div class="row" style="margin-top: 30px; margin-bottom: 5px;">
 		<!-- 회원가입버튼 -->
  		<div class="col-sm-4">
  			 		<input class="btn btn-primary" type="button" value="회원가입"
  			 				onclick="location.href='insert_form.do'">
  		</div>
  	
  	<!-- 로그인정보 -->
  		<div class="col-sm-8" style="text-align:right;">
  		 
  		 <!-- 로그인 안된경우 -->
  		 <c:if test="${empty sessionScope.user }">
  		 <input class="btn btn-primary" type="button" value="로그인" 
  		 		onclick="location.href='login_form.do'">
  		 </c:if>
  		 
  		 <!-- 로그인 된경우 -->
  		 <c:if test="${not empty sessionScope.user }">
  		 		<b>${user.mem_name}</b>님 환영합니다
  		 		<input class="btn btn-primary" type="button" value="로그아웃" 
  		 		onclick="location.href='logout.do'">
  		 </c:if>
  		</div>
	</div>
 	
 	<!-- Data -->
 	<table class="table">
 		<tr class="info">
 			<th>회원번호</th>
 			<th>이름</th>
 			<th>아이디</th>
 			<th>비밀번호</th>
 			<th>이메일</th>
 			<th>전화</th>
 			<th>(우편번호)주소</th>
 			<th>아이피</th>
 			<th>가입일자</th>
 			<th>등급</th>
 			<th>편집</th>
 		</tr>
 		<!-- table data -->
 		<!-- for(MemberVo vo : list) -->
 		<c:forEach var="vo" items="${list}">
 			<tr>
 				<td>${ vo.mem_idx }</td>
 				<td>${ vo.mem_name }</td>
 				<td>${ vo.mem_id }</td>
 				<td>${ vo.mem_pwd }</td>
 				<td>${ vo.mem_email}</td>
 				<td>${ vo.mem_tel }</td>
 				<td>
 					(${ vo.mem_zipcode})<br>
 					${ vo.mem_addr}
 				</td>
 				<td>${ vo.mem_ip }</td>
 				<td>${ fn:substring(vo.mem_regdate,0,10)}</td>
 				<td>${ vo.mem_role }</td>
 				
 				<!-- 편집  -->
 				<td>
 					<!-- 로그인 유저의 권한이 ROLE_ADMIN이거나 본인이면 보여줘라 -->
 					<c:if test="${(user.mem_role eq 'ROLE_ADMIN') or (user.mem_idx eq vo.mem_idx)}">
 						<form>
 						<input type="hidden" name="mem_idx" value="${vo.mem_idx}">
 						<input class="btn btn-success btn-xs" type="button" value="수정"
 								onclick="location.href='modify_form.do?mem_idx=${vo.mem_idx}'">
 						<input class="btn btn-danger btn-xs" type="button" value="삭제" 
 							onclick="member_delete(this.form);">
 						</form>
 				 	</c:if>				
 				
 				</td>
 			</tr>
 		</c:forEach>
 	</table>
 </div>
</body>
</html>