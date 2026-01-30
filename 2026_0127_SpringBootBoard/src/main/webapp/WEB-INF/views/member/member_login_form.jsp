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

	body {
	    background: #F3EFEA; /* 차분한 웜 아이보리 */
	}
	
	/* 중앙 박스 */
	#box {
	    width: 500px;
	    margin: auto;
	    margin-top: 160px;
	}
	
	/* 패널 */
	.panel {
	    border-radius: 8px;
	    background: #FFFFFF;
	    border: 1px solid #E0E0E0;
	    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
	}
	
	/* 패널 헤더 */
	.panel-primary > .panel-heading {
	    background: linear-gradient(135deg, #E67E22 0%, #FFE082 100%);
	    border: none;
	    color: #FFFFFF;
	}
	
	/* 헤더 텍스트 */
	.panel-heading h4 {
	    margin: 0;
	    line-height: 1.6;
	    font-weight: 600;
	    letter-spacing: 0.5px;
	}
	
	/* 테이블 */
	#box .table th {
	    vertical-align: middle;
	    color: #3E2723;
	    background: #FAFAFA;
	    border-bottom: 1px solid #E0E0E0;
	}
	
	#box .table td {
	    color: #4E342E;
	}
	
	/* 입력창 */
	.form-control {
	    border-radius: 4px;
	    border: 1px solid #D7CCC8;
	    box-shadow: none;
	}
	
	/* 포커스 */
	.form-control:focus {
	    border-color: #E67E22;
	    box-shadow: 0 0 0 2px rgba(230, 126, 34, 0.2);
	}
	
	/* 아이디 메시지 */
	#id_msg {
	    display: inline-block;
	    width: 400px;
	    margin-left: 10px;
	    font-weight: 500;
	}
	
	/* 버튼 (메인) */
	.btn-primary {
	    background: linear-gradient(135deg, #F2994A, #E67E22);
	    border: none;
	    color: #ffffff;
	    font-weight: 600;
	}
	
	.btn-primary:hover {
	    background: linear-gradient(135deg, #E67E22, #D35400);
	}
	
	/* 버튼 (보조) */
	.btn-info {
	    background: linear-gradient(135deg, #EFE6D8, #FFE082); 
	    border: 1px solid #D7CCC8;
	    color: #3E2723;
	}
	
	.btn-info:hover {
	    background: #E5D8C8;
	    border: 1px solid #D7CCC8;
	}

	
</style>

<script type="text/javascript">
	function send(f){
	
		let mem_id	= f.mem_id.value.trim();
		let mem_pwd	= f.mem_pwd.value.trim();
		
		if(mem_id==""){
			alert("아이디를 입력하세요!");
			f.mem_id="";
			f.mem_id.focus();
			return;
		}
		if(mem_pwd==""){
			alert("비밀번호를 입력하세요!");
			f.mem_id="";
			f.mem_id.focus();
			return;
		}
		
		f.action = "login.do";	// MemberLoginAction
		f.submit();
	}// end:send()
	
	//------------------------------------------------------------------------
	
	// javascript window event
	// window.onload = function(){};
	
	// jQuery
	// 모든 DOM이 로딩되고 난 후에 실행함
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
	    if (${param.reason eq 'fail_id'}) {
	        alert("아이디를 확인해주세요.");
	    }

	    if (${param.reason eq 'fail_pwd'}) {
	        alert("비밀번호를 확인해주세요.");
	    }
	    
	    if (${param.reason eq 'session_timeout'}) {
	        alert("세션만료로 로그아웃 되었습니다.\n다시 로그인 해주세요.");
	    }
	}
	
</script>

</head>
<body>
 <form>
 	<div id="box">
 		<!-- Bootstrap 3.x Panel -->
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>로그인</h4></div>
			<div class="panel-body">
				
				<table class="table">
					<tr>
						<th>아이디</th>
						<td><input class="form-control" name="mem_id" value="${ param.mem_id }"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input class="form-control" type=password name="mem_pwd"></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
								<input	class="btn btn-primary" type="button" value="로그인"
										onclick="send(this.form);">
								<input	class="btn btn-info" type="button" value="목록보기"
										onclick="location.href='../board/list.do'">
						</td>
				</table>
				
			</div>
		</div>
 	</div>
 </form>
</body>
</html>