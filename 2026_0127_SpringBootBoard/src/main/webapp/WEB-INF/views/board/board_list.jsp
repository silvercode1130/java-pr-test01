<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../css/common.css">

<style type="text/css">
	#box{
		width: 1000px;
		margin: auto;
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
	// 글쓰기 버튼을 눌렀을 때
	function insert_form(){

		// 로그인 안 된 경우
		if("${ empty user }"== "true"){
			
			if(confirm("글쓰기는 로그인 후에 가능합니다.\n로그인 하시겠습니까?")==false) return;
			
			// 로그인폼으로 이동
			location.href="../member/login_form.do";
			
			return;
		}
		
		// 특정 아이피 밴
		if("${ user.mem_ip }"=="172.30.1.98"){
			alert("게시판 규칙위반으로 2036.01.29 까지 차단되었습니다."); return;
		}
		
		// 로그인 된 경우
		location.href="insert_form.do"
	}
	
	
	
	function board_delete(f){

		let b_idx = f.b_idx;
		
		// 삭제 확인은 항상 필수!!
		if(!confirm("정말 삭제하시겠습니까?\n되돌릴 수 없습니다.")) return;
		
		f.method = "POST";		// delete.do?mem_idx=1 방식의 삭제는 허용하지 않겠다
		f.action = "delete.do";	// boardDelete
		f.submit();
  	}
	
</script>



<script type="text/javascript">
	$(document).ready(function(){
		// 100 : 0.1초 후에 show_message 호출하라
		setTimeout( show_message, 100 );
	});
	
	//------------------------------------------------------------------------
	
	function show_message(){
		// /member/login_form.do?reason=fail_id
		// JSP 의 Javascript 코드 내에서 EL을 사용하려면 ""로 감싸줘야 충돌을 피할 수 있음
		// EL 과 JSTL 의 $가 구분이 안됨
		// 그러므로 명확한 구분을 위해 ""(큰따옴표)로 감싸준다
	    if (${param.reason eq 'ban_ip'}) {
	        alert("게시판 규칙위반으로 2036.01.29 까지 차단되었습니다.");
	    }
	}
	
</script>

</head>
<body>

<div id="box">
 <h1 id="title">:::: 게시판 ::::</h1>
 
 	<!-- Bootstrap 3.x Grid -->
	<div class="row">
	
		<div class="col-sm-4" style="margin-top:30px; margin-bottom:10px;">
			<input class="btn btn-primary" type="button" value="새글쓰기"
				   onclick="insert_form()">
		</div>
	
	 	<!-- 로그인 기능 -->
	 	<div class="col-sm-8" style="text-align:right; margin-top:30px; margin-bottom:10px;">
	 	
	 		<!-- 로그인 안된 경우 -->
	 		<c:if test="${ empty user }">
	 			<input class="btn btn-primary" type="button" value="로그인"
	 				   onclick="location.href='${pageContext.request.contextPath}/member/login_form.do'">
	 				   <!-- 						절대경로 : root path -->
	 			<input	class="btn btn-primary" type="button" value="회원가입"
						onclick="location.href='${pageContext.request.contextPath}/member/insert_form.do'">
	 		</c:if>
	 		
	 		<!-- 로그인 된 경우 -->
			<c:if test="${ not empty sessionScope.user }">
					<c:choose>
					    <c:when test="${user.mem_role eq 'ROLE_ADMIN'}">
					    	<button type="button" class="btn btn-danger btn-xs">
					    		관리자
					    	</button>
					    </c:when>
					    <c:when test="${user.mem_role eq 'ROLE_USER'}">
					    	<button type="button" class="btn btn-default btn-xs">
					    		일반
					    	</button>
					    </c:when>
					</c:choose>
				
				<b>${ user.mem_name }</b>님 환영합니다!&nbsp;&nbsp;
				<input	class="btn btn-primary" type="button" value="로그아웃"
						onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">
			</c:if>
	 		
	 	</div>
 	</div>	
	 <!-- 게시글 -->
	 <table class="table">
	  <thead>
		<tr class="success">
			<th>번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>작성일</th>
			<c:if test="${ not empty sessionScope.user }">
			<th>편집</th>
			</c:if>
		</tr>
	  </thead>
	  
	  <tbody>
		
		<!-- 게시글 없는 경우 -->
		<c:if test="${ empty list }">
			<tr>
				<td colspan="5" align="center">
					<font color = "red">등록된 게시물이 없습니다.</font>
				</td>
			</tr>
		</c:if>
		
		<!-- table data -->
		<!-- 게시글 있는 경우 -->
		<c:forEach var="vo" items="${ requestScope.list }">
			<tr>
				<td>${ vo.b_idx }</td>
				<td style="text-align:left;">
				
					<!-- b_depth 만큼 공백 넣는다 -->
					<c:forEach begin="1" end="${ vo.b_depth }">
						&nbsp;&nbsp;&nbsp;
					</c:forEach>
					
					<!-- 답글일때만 ㄴ 붙여라 -->
					<c:if test="${ vo.b_depth ne 0 }">
						ㄴ
					</c:if>
					
					<a href="view.do?b_idx=${ vo.b_idx }">${ vo.b_subject } (${ vo.b_ip })</a>
				</td>
				<td>${ vo.b_readhit }</td>
				<td>
					${ vo.mem_name }
				</td>
				<td>${ vo.b_regdate }</td>
				
				<!-- 편집 -->
				<td>
					<!-- 로그인 유저의 권한이 ROLE_ADMIN 이거나 본인이면 수정/삭제 버튼 보이기 -->
					<c:if test="${ (user.mem_role eq 'ROLE_ADMIN') or (user.mem_idx eq vo.mem_idx)}">
						<form>
							<input type="hidden" name="mem_idx" value="${ vo.mem_idx }">
							<input	class="btn btn-warning btn-xs" value="수정"
									onclick="location.href='modify_form.do?mem_idx='+${ vo.mem_idx };" style="width: 40px">
							<input	class="btn btn-danger btn-xs" value="삭제"
									onclick="board_delete(this.form);" style="width: 40px;">
						</form>
					</c:if>
				</td>
				
			</tr>
		</c:forEach>
	  </tbody>
	 </table>
</div>

</body>
</html>