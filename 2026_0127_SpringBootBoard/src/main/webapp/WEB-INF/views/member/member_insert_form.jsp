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

<!-- Daum 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
#box{
	width:800px;
	margin: auto;
	margin-top: 80px;
}

	th{
		vertical-align: middle !important;
	}
	
	#id_msg{
		display: inline-block;
		width: 400px;
		margin-left: 10px;
	}
	
</style>

<script type="text/javascript">

function check_id() {
	let mem_id=$("#mem_id").val().trim();
	
	//회원가입버튼을 비활성화 시킨다
	$("input[value='회원가입']").prop("disabled",true);
	
	//3글자 이상
	if(mem_id.length < 3){
		
		$("#id_msg").html("3글자 이상을 입력하셔야 합니다")
					.css("color","red");
		return;
	}
	
	//Ajax이용해서 중복아이디 체크
	$.ajax({
		url		:	"check_id.do",		//MemberCheckIdAction
		data	:	{"mem_id":mem_id},	//check_id.do?mem_id=hong
		dataType:	"json",
		success : 	function(res_data){
			// res_data = { result:true } or { result:false }
			
		if(res_data.result){
			//사용가능한 상황
			$("#id_msg").html("사용 가능한 아이디 입니다")
							.css("color","blue");
			//회원가입버튼을 비활성화 시킨다
			$("input[value='회원가입']").prop("disabled",false);
			
			
		}else{
			//이미 사용중인 상황
			$("#id_msg").html("이미 사용중인 아이디 입니다")
							.css("color","red");	
			}
		
		},
		error	:	function(err){
			alert(err.responseText);
		}
	});
	
	}//end:check_id()
	
	function find_addr(){
		
		 new daum.Postcode({
		        oncomplete: function(data) {
		         
		        	console.log(data);
		        	
		        	//우편번호 넣기
		        	$("#mem_zipcode").val(data.zonecode);
		        	
		        	//주소넣기
		        	$("#mem_addr").val(data.address);
		        	
		        	
		        }
		    }).open();
		 
	}//end:find_addr()
	
//------------------------------------------------------
	
	function send(f){
		
		let mem_name 	= f.mem_name.value.trim();
		let mem_pwd 	= f.mem_pwd.value.trim();
		let mem_email 	= f.mem_email.value.trim();
		let mem_tel 	= f.mem_tel.value.trim();
		let mem_zipcode = f.mem_zipcode.value.trim();
		let mem_addr	= f.mem_addr.value.trim();
		
		if(mem_name==""){
			alert("이름을 입력하세요!");
			f.mem_name.value="";
			f.mem_name.focus();
			return;
		}
		
		if(mem_pwd==""){
			alert("비밀번호를 입력하세요!");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		
		if(mem_email==""){
			alert("이메일을 입력하세요!");
			f.mem_email.value="";
			f.mem_email.focus();
			return;
		}
		
		if(mem_tel==""){
			alert("전화번호를 입력하세요!");
			f.mem_tel.value="";
			f.mem_tel.focus();
			return;
		}
		
		if(mem_zipcode==""){
			alert("우편번호를 입력하세요!");
			f.mem_zipcode.value="";
			f.mem_zipcode.focus();
			return;
		}
		
		if(mem_addr==""){
			alert("주소를 입력하세요!");
			f.mem_addr.value="";
			f.mem_addr.focus();
			return;
		}
		
		f.action = "insert.do";	//MemberInsertAction
		f.submit();	//전송(제출)
		
	
	}//end:send()
	
//----------------------------------------------------------------

</script>

</head>
<body>
<form class="form-inline">
	<div id="box">
		 <div class="panel panel-primary">
      <div class="panel-heading"><h4>회원가입</h4></div>
      <div class="panel-body">
      	<table class="table">
      		<tr>
      			<th>이름</th>
      			<td>
      				<input class="form-control" name="mem_name">
      			</td>
      		</tr>
      		<tr>
      			<th>아이디</th>
      			<td>
      				<input class="form-control" name="mem_id" id="mem_id" onkeyup="check_id();">
      				<span id="id_msg"></span>
      			</td>
      		</tr>
      		<tr>
      			<th>비밀번호</th>
      			<td>
      				<input class="form-control"type="password" name="mem_pwd">
      			</td>
      		</tr>
      		<tr>
      			<th>이메일</th>
      			<td>
      				<input class="form-control" name="mem_email">
      			</td>
      		</tr>
      		<tr>
      			<th>전화</th>
      			<td>
      				<input class="form-control" name="mem_tel">
      			</td>
      		</tr>
      		<tr>
      			<th>우편번호</th>
      			<td>
      				<input class="form-control" name="mem_zipcode" id="mem_zipcode" readonly>
      				<input class="btn btn-primary" type="button" value="주소찾기"
      						onclick="find_addr();">
      			</td>
      		</tr>
      		
      		<tr>
      			<th>주소</th>
      			<td>
      				<input class="form-control" name="mem_addr" id="mem_addr" style="width:100%;">
      			</td>
      		</tr>
      		
      		<tr>
      			<td colspan="2" align="center">
      				<input class="btn btn-info" type="button" value="메인화면"
      						onclick="location.href='list.do'">
      						
      				<input class="btn btn-primary" type="button" value="회원가입" disabled="disabled"
      						onclick="send(this.form);">
      			</td>
      		</tr>
      	</table>
      </div>
  		</div>
	</div>
</form>

</body>
</html>