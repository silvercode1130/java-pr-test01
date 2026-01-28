<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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

<!-- Daum 주소검색 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
#box {
	width: 800px;
	margin: auto;
	margin-top: 80px;
}

th {
	vertical-align: middle !important;
}

#id_msg {
	display: inline-block;
	width: 400px;
	margin-left: 10px;
}
</style>

<script type="text/javascript">
	//----------------------------------------------------------

	function find_addr() {

		new daum.Postcode({
			oncomplete : function(data) {

				console.log(data);

				//우편번호 넣기
				$("#mem_zipcode").val(data.zonecode);

				//주소넣기
				$("#mem_addr").val(data.address);

			}
		}).open();

	}//end:find_addr()

	//------------------------------------------------------

	function send(f) {

		let mem_name = f.mem_name.value.trim();
		let mem_pwd = f.mem_pwd.value.trim();
		let mem_email = f.mem_email.value.trim();
		let mem_tel = f.mem_tel.value.trim();
		let mem_zipcode = f.mem_zipcode.value.trim();
		let mem_addr = f.mem_addr.value.trim();

		if (mem_name == "") {
			alert("이름을 입력하세요!");
			f.mem_name.value = "";
			f.mem_name.focus();
			return;
		}

		if (mem_pwd == "") {
			alert("비밀번호를 입력하세요!");
			f.mem_pwd.value = "";
			f.mem_pwd.focus();
			return;
		}

		if (mem_email == "") {
			alert("이메일을 입력하세요!");
			f.mem_email.value = "";
			f.mem_email.focus();
			return;
		}

		if (mem_tel == "") {
			alert("전화번호를 입력하세요!");
			f.mem_tel.value = "";
			f.mem_tel.focus();
			return;
		}

		if (mem_zipcode == "") {
			alert("우편번호를 입력하세요!");
			f.mem_zipcode.value = "";
			f.mem_zipcode.focus();
			return;
		}

		if (mem_addr == "") {
			alert("주소를 입력하세요!");
			f.mem_addr.value = "";
			f.mem_addr.focus();
			return;
		}

		f.action = "modify.do"; //MemberModifyAction
		f.submit(); //전송(제출)

	}//end:send()

	//----------------------------------------------------------------
	//모든요소가 배치가 완료되면...호출
	$(document).ready(function() {
		$("#mem_role").val("${vo.mem_role}");
	});
//-------------------------------------------------------------------
</script>

</head>
<body>
	<form class="form-inline">
	
	<input type="hidden" name="mem_idx" value="${vo.mem_idx}"> 
	
		<div id="box">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>회원수정</h4>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<th>이름</th>
							<td><input class="form-control" name="mem_name"
								value="${vo.mem_name}"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input class="form-control" name="mem_id"
								value="${ vo.mem_id}" readonly="readonly"></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input class="form-control" type="password"
								name="mem_pwd" value="${vo.mem_pwd}"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input class="form-control" name="mem_email"
								value="${vo.mem_email}"></td>
						</tr>
						<tr>
							<th>전화</th>
							<td><input class="form-control" name="mem_tel"></td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td><input class="form-control" name="mem_zipcode"
								id="mem_zipcode" value="${vo.mem_zipcode}"> <input
								class="btn btn-primary" type="button" value="주소찾기"
								onclick="find_addr();"></td>
						</tr>

						<tr>
							<th>주소</th>
							<td><input class="form-control" name="mem_addr"
								id="mem_addr" style="width: 100%;" value="${vo.mem_addr}">
							</td>
						</tr>

						<!-- 등급(권한) -->
						<tr>
							<th>등급</th>
							<td><select class="form-control" name="mem_role"
								id="mem_role">
									<option value="ROLE_USER">일반</option>

									<!-- 관리자 로그인시 선택권한 부여 -->
									<c:if test="${user.mem_role eq 'ROLE_ADMIN'}">
										<option value="ROLE_ADMIN">관리자</option>
									</c:if>
							</select></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input class="btn btn-info"
								type="button" value="메인화면" onclick="location.href='list.do'">

								<input class="btn btn-primary" type="button" value="회원수정"
								onclick="send(this.form);"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>

</body>
</html>