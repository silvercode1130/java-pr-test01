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
	
	body {
	    background: #F3EFEA; /* 차분한 웜 아이보리 */
	}
	
	/* 중앙 박스 */
	#box {
	    width: 800px;
	    margin: auto;
	    margin-top: 80px;
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

	$(document).ready(function(){	// DOM이 전부 만들어진 다음에 실행
	// HTML 문서의 모든 태그가 메모리에 로드된 뒤에 이 안의 코드를 실행해라!
    	// 자동 커서 전환
    	$("#tel_front").change(function(){
        	$("#tel_middle").focus();
    	});
    	
    	$("#tel_middle").keyup(function(){
    	    if(this.value.length == 4){
    	        $("#tel_last").focus();
    	    }
    	});
    });



	function check_id(){
		let mem_id = $("#mem_id").val().trim();
		
		// 회원가입버튼을 비활성화 시키기
		// attribute selector (value가 회원가입인 input)
		$("input[value='회원가입']").prop("disabled",true);
		
		// 3글자 이상
		if(mem_id.length < 3){
			$("#id_msg").html("아이디는 3글자 이상이어야 합니다.").css("color", "red");
			return;
		}
		
		// Ajax 이용해서 중복아이디 체크
		$.ajax({
			url		:	"check_id.do",		// MemberCheckIdAction
			data	:	{"mem_id":mem_id},	// check_id.do?mem_id=hong
			dataType:	"json",
			success	:	function(res_data){
				// res_data = {result:true} or {result:false}
				if(res_data.result){
					$("#id_msg").html("사용 가능한 아이디 입니다.").css("color", "blue");
					
					// 회원가입버튼을 활성화 시킨다
					$("input[value='회원가입']").prop("disabled",false);
				}else{
					$("#id_msg").html("이미 사용중인 아이디 입니다.").css("color", "red");
				}
			},
			error	:	function(err){
				alert(err.responseText);
			}
		});
	
		
	}// end:check_id()
	
	function find_addr(){
		 new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		            console.log(data);
		            // 우편번호 넣기
		            $("#mem_zipcode").val(data.zonecode);
		            // 얻어낸 주소값 넣기
		            $("#mem_addr").val(data.address);
		            // 커서를 주소칸 입력값 맨 뒤로 이동
		            let addr = $("#mem_addr").val();
            		$("#mem_addr").focus()[0].setSelectionRange(addr.length, addr.length);
			}
		}).open();
	}// end:find_addr()
	
	function changeMailDomain(){
	    let sel = $("#mail_select").val();
	
	    if(sel === ""){
	        $("#mail_domain").val("").prop("readonly", false).focus();
	    } else {
	        $("#mail_domain").val(sel).prop("readonly", true);
	    }
	}// end:changeMailDomain()
	
	
	// 전송폼
	function send(f){
	
	    let mem_name = f.mem_name.value.trim();
	    let mem_id   = f.mem_id.value.trim();
	    let mem_pwd  = f.mem_pwd.value.trim();
	    let email = f.mail_addr.value.trim() + "@" + f.mail_domain.value.trim();
	    let tel   = f.tel_front.value + "-" + f.tel_middle.value + "-" + f.tel_last.value;
	    let mem_zipcode = f.mem_zipcode.value.trim();
	    let addr	= f.mem_addr.value.trim();
	    
	    if(mem_name===""){
	        alert("이름을 입력하세요!");
	        f.mem_name.focus();
	        return;
	    }
	
	    if(mem_id===""){
	        alert("아이디를 입력하세요!");
	        f.mem_id.focus();
	        return;
	    }
	
	    if(mem_pwd===""){
	        alert("비밀번호를 입력하세요!");
	        f.mem_pwd.focus();
	        return;
	    }
	
	    if(f.mail_addr.value==="" || f.mail_domain.value===""){
	        alert("이메일을 입력하세요!");
	        f.mail_addr.focus();
	        return;
	    }
	
	    // 합친 값 세팅
	    f.mem_email.value	= email;	// mem_email에 합친값 넣기
	    f.mem_tel.value		= tel;		// mem_tel에 합친값 넣기
	
	    f.action = "insert.do";		// MemberInsertAction
	    f.submit();					// 지정된 서버로 전송
	}
	
</script>

</head>
<body>

	<form class="form-inline" action="">
		<div id="box">

			<!-- Bootstrap 3.x Panel -->
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>회원가입</h4></div>
				<div class="panel-body">
					
					<table class="table">
						<tr>
							<th width="120">이름 :</th>
							<td><input class="form-control" name="mem_name" style="width: 30%;"></td>
						</tr>
						<tr>
							<th>아이디 :</th>
							<td>
								<input class="form-control" name="mem_id" id="mem_id" onkeyup="check_id();" style="width: 30%;">
								<span id="id_msg"></span>
							</td>
						</tr>
						<tr>
							<th>비밀번호 :</th>
							<td><input class="form-control" type="password" name="mem_pwd" style="width: 30%;"></td>
						</tr>
						<tr>
							<th>이메일 :</th>
							<td>
								<input class="form-control" name="mail_addr" style="width: 30%;">
								&nbsp;@&nbsp;
								<input class="form-control" name="mail_domain" id="mail_domain" style="width: 30%;">
								&nbsp;
								<select class="form-control" id="mail_select" onchange="changeMailDomain();">
									<option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.com">hanmail.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
								</select>
								<input type="hidden" name="mem_email">
							</td>
						</tr>
						<tr>
							<th>전화번호 :</th>
							<td>
							<select class="form-control" name="tel_front" id="tel_front">
							    <option value="010" selected>010</option>
							    <option value="011">011</option>
							    <option value="016">016</option>
							    <option value="018">018</option>
							</select>
							&nbsp;-&nbsp;
							<input class="form-control" name="tel_middle" id="tel_middle" maxlength="4" style="width:10%;">
							&nbsp;-&nbsp;
							<input class="form-control" name="tel_last" id="tel_last" maxlength="4" style="width:10%;">
							<input type="hidden" name="mem_tel">
							</td>
						</tr>
						<tr>
							<th>우편번호 :</th>
							<td>
								<input class="form-control" name="mem_zipcode" id="mem_zipcode" style="width: 20%;" readonly>
								<input class="btn btn-primary" type="button" value="주소찾기"
									   onclick="find_addr();">
								
							</td>
						</tr>
						<tr>
							<th>주소 :</th>
							<td>
								<input class="form-control" name="mem_addr" id="mem_addr" style="width: 100%;">
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input	class="btn btn-primary" type="button" value="회원가입"
										onclick="send(this.form);" disabled="disabled">
								<input	class="btn btn-info" type="button" value="목록보기"
										onclick="location.href='list.do'">
						</tr>
					</table>
				
				</div>
			</div>

		</div>
	</form>
	
</body>
</html>