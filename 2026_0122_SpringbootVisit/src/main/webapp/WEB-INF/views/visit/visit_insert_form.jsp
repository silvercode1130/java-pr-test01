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
		background: #c9e2f3;
	}
	
	#box {
		width: 600px;
		margin: auto;
		margin-top: 100px;
	}
	
	/* 패널 */
	.panel {
		border-radius: 6px;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	}
	
	.panel-primary>.panel-heading {
		background: linear-gradient(135deg, #3498db, #2c81ba);
		border: none;
	}
	
	.panel-heading h4 {
		margin: 0;
		line-height: 1.6;
	}
	
	textarea {
		resize: none;
	}
	
	#box .table th {
    	vertical-align: middle;
	}
	
</style>
</head>
<body>

	<form action="">
		<div id="box">

			<!-- Bootstrap 3.x Panel -->
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>방명록 글쓰기</h4></div>
				<div class="panel-body">
					
					<table class="table">
						<tr>
							<th width="80">작성자 :</th>
							<td><input class="form-control" name="name"></td>
						</tr>
						<tr>
							<th>내용 :</th>
							<td><textarea class="form-control" name="content" rows="5" cols=""></textarea></td>
						</tr>
						<tr>
							<th>비밀번호 :</th>
							<td><input class="form-control" type="password" name="pwd"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input	class="btn btn-success" type="button" value="목록보기"
										onclick="location.href='list.do'">
								<input	class="btn btn-primary" type="button" value="글올리기"
										onclick="send(this.form);">
						</tr>
					</table>
				
				</div>
			</div>

		</div>
	</form>
	
	<script type="text/javascript">
	
		function send(f){
			let name = f.name.value.trim();
			let content = f.content.value.trim();
			let pwd = f.pwd.value.trim();
			
			if(name=="") {
				alert("이름을 입력하세요!");
				f.name.value="";	// 값 지우기
				f.name.focus();		// 입력포커스
				return;
			}
			if(content=="") {
				alert("내용을 입력하세요!");
				f.content.value="";	// 값 지우기
				f.content.focus();	// 입력포커스
				return;
			}
			if(pwd=="") {
				alert("비밀번호를 입력하세요!");
				f.pwd.value="";		// 값 지우기
				f.pwd.focus();		// 입력포커스
				return;
			}
		
			f.action = "insert.do";		// VisitInsertAction
			f.submit();					// 지정된 서버로 전송(제출)
/*
			submit은 속성처럼 보이지만 함수
				JS에서는	submit ❌
						submit() ⭕
			f.submit; 으로 적으면 함수를 참조만 할 뿐 호출하지 않음
			() 누락실수는 실무에서도 자주 틀리고 찾기 매우 어려우니 주의!
*/
		
		}
		
		
	</script>
	
</body>
</html>