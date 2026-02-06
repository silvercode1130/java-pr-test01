<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
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
     width: 1000px;
     margin: auto;
     margin-top: 30px;
  }
  
   #title{
       text-align: center;
       font-size: 26px;
       color:rgb(51,122,183);
       text-shadow: 1px 1px 1px black;
       
   }
</style>

<script type="text/javascript">
   
   function insert_form(){
	   
	   //로그인 안된경우
	   if("${ empty user }" == "true"){
		   
		   if(confirm("글쓰기는 로그인후에 가능합니다\n로그인 하시겠습니까?")==false) return;
		   
		   //로그인폼으로 이동
		   location.href="../member/login_form.do";
		   
		   return;
	   }
	   
	   //글쓰기 폼으로 이동
	   location.href = "insert_form.do";
	   
   }

</script>

</head>
<body>
  
  <div id="box">
       <h1 id="title">::::게시판::::</h1>
       
       <!-- 로그인 및 글쓰기 -->
       <div class="row" style="margin-top: 30px; margin-bottom: 5px;">
		  
		  <div class="col-sm-4">
		      <input class="btn btn-primary" type="button" value="새글쓰기" 
		             onclick="insert_form();">
		  </div>
		  
		  <!-- 로그인기능 -->
		  <div class="col-sm-8" style="text-align: right;">
		     
		     <!-- 로그인 안된경우 -->
		     <c:if test="${ empty user }">
		         <input class="btn btn-primary"  type="button"  value="로그인"  
		                onclick="location.href='${ pageContext.request.contextPath }/member/login_form.do'">
		         <input class="btn btn-primary"  type="button"  value="회원가입"  
		                onclick="location.href='${ pageContext.request.contextPath }/member/insert_form.do'">
		     </c:if>
		     
		     <!-- 로그인이 된경우 -->
		     <c:if test="${ not empty user }">
		        <b>${ user.mem_name }</b>님 환영합니다.
		        <input class="btn btn-primary"  type="button"  value="로그아웃"  
		                onclick="location.href='${ pageContext.request.contextPath }/member/logout.do'">
		     
		     </c:if>
		  
		  </div>
	   </div>
       
       
       
       
       <!-- 게시글 -->
       <table class="table table-striped table-hover">
           <!-- table title -->
           <tr class="success">
              <th>번호</th>
              <th width="50%">제목</th>
              <th>작성자</th>
              <th>작성일자</th>
              <th>조회수</th>
           </tr>
           
           <!-- table data  -->
           <!-- 게시글이 없는경우 -->
           <c:if test="${ empty list }">
              <tr>
                 <td colspan="5" align="center">
                    <font color="red">등록된 게시글이 없습니다</font>
                 </td>
              </tr>
           </c:if>
           
           <!-- 게시글이 있는 경우 -->
           <!-- for(BoardVo vo : list) -->
           <c:forEach var="vo"  items="${ list }">
              <tr>
                 <td>${ vo.no }(${ vo.b_idx })</td>
                 <td>
                   
                   <!-- b_depth만큼 공백 넣는다 -->
                   <c:forEach begin="1"  end="${ vo.b_depth }">
                      &nbsp;&nbsp;&nbsp;
                   </c:forEach>
                   
                   <!-- 답글일때만 붙여라 -->
                   <c:if test="${ vo.b_depth ne 0 }">
                    ㄴ
                   </c:if> 
                    
                   <!-- 삭제가 된경우 -->
                   <c:if test="${ vo.b_use eq 'n' }">
                      <font color="red">삭제된 게시물입니다(${ fn:replace(vo.b_subject,"img","") })</font>
                   </c:if> 
                  
                   <!-- 삭제가 안된경우 -->
                   <c:if test="${ vo.b_use eq 'y' }">
                   	  <a href="view.do?b_idx=${ vo.b_idx }&page=${ (empty param.page) ? 1 : param.page }">${ fn:replace(vo.b_subject,"img","") }</a>
                   	  	<!-- 댓글이 있을 때만 개수 표시 -->
                   	  	<c:if test="${ vo.cmt_count ne 0 }">
                   	  		&nbsp;<span class="badge" style="background: #33aacc;">${ vo.cmt_count }</span>
                   	  	</c:if>	
                   </c:if>
                    
                    
                 </td>
                 <td>${ fn:replace(vo.mem_name,"img","") }</td>
                 <td>${ vo.b_regdate }</td>
                 <td>${ vo.b_readhit }</td>
              </tr>
           </c:forEach>
       </table>
       
       <!-- Page Menu -->
       <div style="text-align: center;">
       
           ${ pageMenu }

			<!-- <ul class='pagination'>
				<li><a href='#'>◀</a></li>
				<li class='active'><a href='#'>1</a></li>
				<li><a href='list.do?page=2'>2</a></li>
				<li><a href='list.do?page=3'>3</a></li>
				<li><a href='list.do?page=4'>▶</a></li>
			</ul> -->


		</div>
  
  </div>
  
</body>
</html>