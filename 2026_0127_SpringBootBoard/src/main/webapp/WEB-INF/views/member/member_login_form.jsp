<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#box {
	width: 500px;
	margin: auto;
	margin-top: 120px;
	}
	
	th{
		vertical-align:middle !important;
	}
	
	input[type='button']{
		width:100px;
	}
	
</style>

<script type="text/javascript">

	function send(f){
		
		let mem_id	= f.mem_id.value.trim();
		let mem_pwd	= f.mem_pwd.value.trim();
		
		if(mem_id==""){
			alert("아이디를 입력하세요!");
			f.mem_id.value="";
			f.mem_id.focus();
			return;
		}
		
		if(mem_pwd==""){
			alert("비밀번호를 입력하세요!");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		
		f.action = "login.do";	// MemberLoginAction
		f.submit();
	
	}//end:send()
	
//------------------------------------------------------------------
	//Javascript window event
	//window.onload = function(){};
	
	//jQuery
	$(document).ready(function(){
		
		// 100 : 0.1초후에 show_message 호출해
		setTimeout(show_message , 100);
		
		
	});
	
	//-----------------------------
	function show_message(){
		
		// /member/login_form.do?reason=fail_id
		// JSP내에서 Javascript 코드내에서 EL를 사용하려면 
		// ""내에 작성해야 충돌을 피할수 있다
		if("${ param.reason eq 'fail_id'}"=="true"){
			alert("아이디가 틀립니다!");
		}
		
		// /member/login_form.do?reason=fail_pwd
		if("${ param.reason eq 'fail_pwd'}"=="true"){
			alert("비밀번호가 틀립니다!");
		}
	}
	
</script>
</head>
<body>
	<form>
		<div id="box">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>로그인</h4>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<th>아이디</th>
							<td><input class="form_control" name="mem_id" value="${param.mem_id}"></td>
						</tr>

						<tr>
							<th>비밀번호</th>
							<td><input class="form_control" type="password"
								name="mem_pwd"></td>
						</tr>

						<tr>
							<td colspan="2" align="center">
							<input class="btn btn-info"
								type="button" value="목록보기" 
								onclick="location.href='list.do'">
								 
							<input
								class="btn btn-primary" type="button" value="로그인" 
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