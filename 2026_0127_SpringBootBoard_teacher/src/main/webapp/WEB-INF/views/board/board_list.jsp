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
	   
   }//end: insert_form()
   
   function find(){
		let search = $("#search").val();
		let search_text = $("#search_text").val().trim();
		
		// 전체 검색이 아닌데 검색어가 비어있으면
		if(search != "all" && search_text == ""){
			alert("검색어를 입력하세요!");
			$("#search_text").val("");
			$("#search_text").focus();
			
			return;
		}
		
		// 서버로 전송
		location.href = "list.do?search="+search+
						"&search_text="+encodeURIComponent(search_text,"utf-8");
		
   }//end: find()

</script>

<!-- 초기화 -->
<script type="text/javascript">

	$(document).ready(function(){
	 /* 검색이 비어있지 않으면 */
	 if("${ not empty param.search }"=="true"){
		$("#search").val("${param.search}");

	 }
	 
	 /* 전체검색시에는 검색어를 비우자*/
	 if("${ param.search eq 'all'}"=="true"){
		$("#search_text").val("");
	 }
	 
	});

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
                   	  <a href="view.do?b_idx=${ vo.b_idx }&page=${ (empty param.page) ? 1 : param.page }&search=${param.search}&search_text=${param.search_text}">${ fn:replace(vo.b_subject,"img","") }</a>
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
       <!-- 검색메뉴 -->
       <form class="form-inline">
	       <div style="text-align:center;">
	       	<select class="form-control" id="search">
	       		<option value="all">전체보기</option>
	       		<option value="name">이름</option>
	       		<option value="subject">제목</option>
	       		<option value="content">내용</option>
	       		<option value="subject_content">제목+내용</option>
	       		<option value="name_subject_content">이름+제목+내용</option>
	       	</select>
	       	
	       	<input class="form-control" id="search_text" value="${ param.search_text }">
	       	<input class="btn btn-primary" type="button" value="검색"
	       			onclick="find();">
	       </div>
       </form>
       
       
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