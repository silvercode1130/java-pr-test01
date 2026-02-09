<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 
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
     width: 800px;
     margin: auto;
     margin-top: 50px;
  }
  
  .common{
     border: 1px solid #dddddd;
     border-radius: 5px;
     padding: 5px;
     
  }
  
  .content{
     min-height: 80px;
  }
  
  textarea {
	 resize: none;
  }
  
  .cmt_common{
     height: 80px !important;
  }

</style>

<script type="text/javascript">
   
   function reply_form(){
	   
	   //alert(location.href); //현재 URL주소 =>location.href
	   
	   //로그인 안된경우
	   if("${ empty user }" == "true"){
		   
		   if(confirm("답글쓰기는 로그인후에 가능합니다\n로그인 하시겠습니까?")==false) return;
		   
		   //로그인폼으로 이동
		   location.href="../member/login_form.do?url=" + encodeURIComponent(location.href, "utf-8");
		   
		   return;
	   }
	   
	   //답글쓰기 폼으로 이동
	   location.href = "reply_form.do?b_idx=${ vo.b_idx }&page=${ param.page }";
	      
   }//end:reply_form()
   
   function board_delete(f){
	   
	   if(confirm("정말 삭제 하시겠습니까?")==false) return;
	   
	   //location.href="delete.do?b_idx=${ vo.b_idx }" ;
	   
	   f.method = "POST";
	   f.action = "delete.do";
	   f.submit();
	   
	   
   }//end:board_delete()

</script>


<!--  댓글용 자바스크립트  -->
<script type="text/javascript">
   
   //jQuery 초기화
   $(document).ready(function(){
	   
	   comment_list(1);
   });   
   
   // 전역변수
   var g_current_comment_page;
   
   function comment_insert(){

	   
	   //로그인 여부 체크
	   if("${ empty user }"=="true"){
		   
		   if(confirm("댓글은 로그인후 작성가능합니다\n로그인 하시겠습니까?")==false) return;
		   
		   //로그인폼으로 이동
		   location.href="../member/login_form.do?url=" + encodeURIComponent(location.href);
		   
		   return;
	   }
	   
	   
	   //입력값 체크
	   let cmt_content = $("#cmt_content").val().trim();
	   if(cmt_content==""){
		   alert("내용을 입력하세요!");
		   $("#cmt_content").val("");
		   $("#cmt_content").focus();
		   return;
	   }
	   
	   //Ajax 추가 요청...
	   $.ajax({
		   url		:	"../comment/insert.do",
		   data		:	{
			              "b_idx" 		: "${ vo.b_idx }",
			              "cmt_content" : cmt_content,
			              "mem_idx"		: "${ user.mem_idx }",
			              "mem_name"	: "${ user.mem_name }" 
		                },
		   dataType	:	"json",
		   success	:	function(res_data){
			            // res_data = {"result": true } or {"result": false }
			            if(res_data.result==false){
			            	alert("댓글쓰기 실패!!");
			            	return;
			            }
			            
			            //이전작성내용 지우기
			            $("#cmt_content").val("");
			            
			            //댓글목록 읽어오기
			            comment_list(1);
			            
		   },
		   error	:	function(err){
			            
			            alert(err.responseText);
			   
		   }
		   
	   });//end:  $.ajax()
	   
   }//end:comment_insert()
   
   function comment_list(page){
	   
	   g_current_comment_page = page;
	   
	   // Ajax로 요청
	   $.ajax({
		   url		:	"../comment/list.do",
		   data		:	{  
			               "b_idx" : "${ vo.b_idx }",
			               "page"  : page
			            },
		   dataType :   "html",	            
		   success	:	function(res_data){
			    
			            //댓글목록을 id=disp인 div 넣는다
			            $("#disp").html(res_data);
			               			   
		   },
		   error	:	function(err){
			   
			            alert(err.responseText);  
			   
		   }
	   });
	   
   }//end: comment_list()
   
   function comment_delete(cmt_idx){

		// alert(cmt_idx+"삭제");
		// 실제 댓글목록은 comment_list에 들어있음 - 이벤트 동작시키면 comment_list를 호출한다
		if(confirm("정말 삭제하시겠습니까?")==false) return;
			// jQuery Ajax로 삭제 요청
			$.ajax({
				url			: "../comment/delete.do",
				data		: {"cmt_idx" : cmt_idx },
				dataType	: "json",
				success		: function(res_data){		// 성공시 결과 데이터
					if(res_data.result==false){
						alert("삭제 실패");
						return;
					}
					// 삭제 성공시(목록보기)
					comment_list(1);
				},
				error		: function(err){			// 에러시 에러 메시지 출력
					alert(err.responseText);
				}
			});
   }//end: comment_delete(cmt_idx)

</script>





</head>
<body>
  <div id="box">
        <!-- Bootstrap 3.x  Panel -->  
		<div class="panel panel-primary">
		    
		    <div class="panel-heading"><h4>${ fn:replace(vo.mem_name,"img","") }(${ vo.b_ip})님의 글:</h4></div>
		    
		    <div class="panel-body">
		       <div>
		          <label>제목</label>
		          <p class="common subject">${ fn:replace(vo.b_subject,"img","") }</p>
		       </div>
		       
		       <div>
		          <label>내용</label>
		          <p class="common content">
		             <%-- ${ fn:replace(vo.b_content,"img","") } --%>
		             ${ vo.b_content }
		          </p>
		       </div>
		       
		       <div>
		          <label>작성(수정)일자</label>
		          <p class="common regdate">${ vo.b_regdate }(${ vo.b_moddate })</p>
		       </div>
		       
		       <div class="common">
		          
		          <form class="form-inline">
		          
			          <input  class="btn btn-primary" type="button" value="메인화면"
			                  onclick="location.href='list.do?page=${ param.page }&search=${param.search}&search_text=${param.search_text}'">
			                  
			          <!-- main글일 경우만 답글 허용 -->        
			          <c:if test="${ (vo.b_depth le 0) and  (param.search eq 'all') }">        
				          <input  class="btn btn-info"    type="button" value="답글쓰기"
				                  onclick="reply_form();">
			          </c:if>        
			          
			          <!-- 작성자 본인일 경우에만 보여준다 -->
			          <c:if test="${ user.mem_idx eq vo.mem_idx }">
			    
			              <input type="hidden"  name="b_idx" value="${ vo.b_idx }">
			              <input type="hidden"  name="page"  value="${ param.page }">
			              <input type="hidden"  name="search"  value="${ param.search }">
			              <input type="hidden"  name="search_text"  value="${ param.search_text }">
			               
				          <input  class="btn btn-success" type="button" value="수정하기"
				          		  onclick="location.href='modify_form.do?b_idx=${ vo.b_idx }&page=${ param.page }'">
				          <input  class="btn btn-danger"  type="button" value="삭제하기"
				                  onclick="board_delete(this.form);">
				                  
			          </c:if>
		          </form>  
		       </div>
		       
		    </div>
		</div>
		
	    <hr>
	    <!-- 댓글쓰기 폼 -->
	    <div class="row">
		  <div class="col-sm-10">
		     <textarea  id="cmt_content" class="form-control cmt_common" placeholder="댓글은 로그인후에 작성가능합니다" ></textarea>
		  </div>
		  
		  <div class="col-sm-2">
		     <input class="btn btn-primary cmt_common" type="button"  value="댓글쓰기"
		            onclick="comment_insert();" >
		  </div>
		</div>	
		
		<hr>
		
		<!-- 댓글목록 출력 -->
		<div id="disp"></div>
				
		
  </div>
</body>
</html>








