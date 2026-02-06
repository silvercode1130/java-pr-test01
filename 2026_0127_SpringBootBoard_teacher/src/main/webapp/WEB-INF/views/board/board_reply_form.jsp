<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
     width: 600px;
     margin: auto;
     margin-top: 80px;
  }
  
  textarea {
	 resize: none;
  }
  
  .common{
     margin-bottom: 10px;
  }
</style>



<script type="text/javascript">
  
  function send(f){
	  
	  let b_subject = f.b_subject.value.trim();
	  let b_content = f.b_content.value.trim();
	  
	  if(b_subject==""){
		  alert("제목을 입력하세요!");
		  f.b_subject.value="";
		  f.b_subject.focus();
		  return;
	  }
	  
	  if(b_content==""){
		  alert("내용을 입력하세요!");
		  f.b_content.value="";
		  f.b_content.focus();
		  return;
	  }
	  
	  f.method = "POST";
	  f.action = "reply.do";
	  f.submit();
	  	  
  }

</script>

</head>
<body>

<form>

  <input type="hidden"  name="b_idx"  value="${ param.b_idx }">
  <input type="hidden"  name="page"   value="${ param.page }">

  <div id="box">
        <!-- Bootstrap 3.x  Panel -->  
		<div class="panel panel-primary">
		    <div class="panel-heading"><h4>답글쓰기</h4></div>
		    <div class="panel-body">
		       
		       <!-- 1 line -->
		       <div class="common">
		          <label>제목</label>
		          <input class="form-control"  name="b_subject">
		       </div>
		       
		       <!-- 2 line  -->
		       <div class="common">
		          <label>내용</label>
		          <textarea class="form-control" rows="6" cols="" name="b_content"></textarea>
		       </div>
		       
		       <!-- 3 line  -->
		       <div class="common"  style="text-align: center;">
		           <input class="btn  btn-success" type="button"  value="메인화면" 
		                  onclick="location.href='list.do'">
		                  
		           <input class="btn  btn-primary" type="button"  value="답글쓰기" 
		                  onclick="send(this.form);">
		       </div>
		       
		       
		    </div>
		</div>
  </div>
</form>

   
</body>
</html>