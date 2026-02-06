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
	
<!-- CKEditor 4 -->
<script src="https://cdn.ckeditor.com/4.22.1/full/ckeditor.js"></script>	
	
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

	function send(f){
		let b_subject = f.b_subject.value.trim();
//		let b_content = f.b_content.value.trim();
//		ck 에디터가 content를 replace 하므로 메서드를 바꿔줘야함!

		//CKEditor 입력값 체크하기
		   let content = CKEDITOR.instances.b_content.getData();
			//								ㄴ실제 content 변수로 변경해주기
			
/*		   // 원본코드 - 이미지만 올렸을 때 공백판정되는 버그 있음!
		   content = content.replace(/<[^>]*>/g, '').trim();
		   content = content.replace(/\s+/g, '');
		   content = content.replaceAll("<br />","").replaceAll("&nbsp;","");
		   
		   if(content==""){
				   alert("내용을 입력하세요!");
				   CKEDITOR.instances.b_content.setData("");
				   f.b_content.focus();
				   return;
		}
*/
		    // 1) 태그 다 제거해서 텍스트만 추출
		    let textOnly = content.replace(/<[^>]*>/g, '')
		                          .replace(/&nbsp;/gi, '')
		                          .replace(/\s+/g, '')
		                          .trim();

		    // 2) 이미지 태그 있는지 검사
		    let hasImage = /<img\b[^>]*>/i.test(content);

		    // 3) 텍스트도 없고 이미지도 없으면 막기
		    if(!hasImage && textOnly === ""){
		        alert("내용을 입력하세요!");
		        CKEDITOR.instances.b_content.setData("");
		        f.b_content.focus();
		        return;
		    }
		
		
		if(b_subject==""){
			alert("제목을 입력하세요!");
			f.b_subject.value="";
			f.b_subject.focus();
			return;
		}
/* 		ck에디터로 대체 되었음
		if(b_content==""){
			alert("내용을 입력하세요!");
			f.b_subject.value="";
			f.b_subject.focus();
			return;
		}
*/
		
		// 특정 아이피 밴
		if("${ user.mem_ip }"=="172.30.1.00"){
			alert("게시판 규칙위반으로 2036.01.29 까지 차단되었습니다."); return;
		}
		
		f.method = "POST"
		f.action = "modify.do";
		f.submit();
	}

</script>

<script type="text/javascript">
   //CKEditor내에서 이미지 삭제시 이벤트 처리
   let previousImageUrls = [];
   
   $(document).ready(function(){
	   
	   // CKEditor 내용을 작성하는 <textarea name="content">
	   //									┌ 실제 content 변수명으로 변경!
	   const editor = CKEDITOR.instances.b_content; 
	   
	   editor.on('change', function () {

		    const currentHtml = editor.getData();
		    const currentImageUrls = extractImageUrls(currentHtml);

		    // 이전 이미지 중 현재 HTML에 없는 항목은 삭제 대상
		    previousImageUrls.forEach(oldUrl => {
		        if (!currentImageUrls.includes(oldUrl)) {
		        	
		        	//oldUrl =  http://localhost:8080/images/1763707289780_병아리.png
		            //console.log("삭제할 기존 이미지:", oldUrl);
		        	let lastIndex = oldUrl.lastIndexOf("/");
		        	let filename  = oldUrl.substring(lastIndex+1);
		        	filename      = decodeURIComponent(filename);
		        	//console.log("삭제할 화일명:", filename);
		            deleteImageOnServer(filename);
		        }
		    });
		    
		    // 현재 이미지 목록을 저장
		    previousImageUrls = currentImageUrls;
		  
		});
   });
      
   
   function extractImageUrls(html) {
	    const div = document.createElement('div');
	    div.innerHTML = html;

	    return Array.from(div.querySelectorAll('img')).map(img => img.src);
	}

	/**
	 * 서버로 이미지 삭제 요청
	 */
	function deleteImageOnServer(filename) {
		
		$.ajax({
			url			:	"/ckeditorImageDelete.do",
			data		:	{"filename": filename },
			dataType	:	"json",
			success		:	function(res_data){
				
				// res_data = { "result" : true}
				console.log(res_data.result ? "삭제성공" : "삭제실패");
				
			},
			error		:	function(err){
				alert(err.responseText);
			}
		});
	}
</script>



</head>
<body>

 <form>
	<div id="box">
	<input type="hidden" name="b_idx" value="${ vo.b_idx }">
  	<!-- 삭제한 뒤 있던 페이지로 돌아가도록 param.page 값 트래킹 -->
  	<input type="hidden" name="page" value="${ param.page }">
		<!-- Bootstrap 3.x Panel -->
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>수정하기</h4></div>
				<div class="panel-body">
			
				<!-- 1line -->
				<div class="table">
					<label>제목</label>
					<input class="form-control" name="b_subject" value="${ vo.b_subject }">
				</div>
				
				<!-- 2line -->
				<div class="table">
					<label>내용</label>
					<textarea class="form-control" rows="6" cols="" name="b_content">
						${ vo.b_content }
					</textarea>
					
					<!-- CK에디터 적용 -->
					<script>
						// Replace the <textarea id="editor1"> with a CKEditor
						// instance, using default configuration.
						CKEDITOR.replace( 'b_content', {
						versionCheck: false,
						filebrowserUploadUrl: '${pageContext.request.contextPath}/ckeditorImageUpload.do',
						enterMode:CKEDITOR.ENTER_BR,
						shiftEnterMode:CKEDITOR.ENTER_P,
						toolbarGroups : [
							{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
							/* { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
							{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ] },
							{ name: 'forms' },
							'/', */
							/* { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
							{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] }, */
							{ name: 'links' },
							{ name: 'insert' },
							'/',
							{ name: 'styles' },
							{ name: 'colors' },
							{ name: 'tools' },
							{ name: 'others' },
							{ name: 'about' }
							]
						});
						
						//이미지 업로드	
						CKEDITOR.on('dialogDefinition', function( ev ){
						   var dialogName = ev.data.name;
						   var dialogDefinition = ev.data.definition;
						 
						   switch (dialogName) {
						       case 'image': //Image Properties dialog
							   //dialogDefinition.removeContents('info');
							   dialogDefinition.removeContents('Link');
							   dialogDefinition.removeContents('advanced');
							   break;
						   }
					       });
					</script>
					
				</div>
				
				<!-- 3line -->
				<div class="table" align="center">
					<input class="btn btn-success" type="button" value="메인화면"
							onclick="location.href='list.do'">
					<input class="btn btn-primary" type="button" value="수정하기"
							onclick="send(this.form);">
				</div>
				
			</div>
		</div>
	</div>
 </form>

</body>
</html>