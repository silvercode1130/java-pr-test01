<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</head>
<body>

<form>
	<div id="box">
		<!-- Bootstrap 3.x Panel -->		
			
			<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>
							<span class="writer">제목 : ${vo.b_subject}</span>
							
						 <c:if test="${user.mem_idx eq vo.mem_idx}">
							<span class="pull-right">
								<button type="button" class="btn btn-warning btn-xs btn-edit"
										onclick="location.href='insert.do'">수정</button>
								<button type="button" class="btn btn-danger btn-xs btn-delete"
										onclick="location.href='delete.do'">삭제</button>
							</span>
						 </c:if>	
						</h4>
					</div>

					<div class="panel-body">
						<div class="date" style="text-align:right;">작성일자 : ${vo.b_regdate}</div>
						<div class="date" style="text-align:right;">수정일자 : ${vo.b_moddate}</div>

						<div class="common" style="font-size:18px; font-weight:400;">${vo.b_content}</div>
			
			
				
				
				
				<!-- 4line -->
				<div class="table" align="center">
					<input class="btn btn-primary" type="button" value="메인화면"
							onclick="location.href='list.do'">
					<input class="btn btn-info" type="button" value="답글쓰기"
							onclick="">
				</div>
				
			</div>
		</div>
	</div>
</form>

</body>
</html>