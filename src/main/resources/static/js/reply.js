$(document).ready(function() {
	
	/*
		헤더의 
		<span id="loginid">${pinfo.username}</span>님(로그아웃)
		값을 글쓴이 값으로 설정합니다.
	*/
	$("#board_name").val($("#loginid").text());
	
	$("#upfile").change(function() {
		console.log($(this).val()); // c:\fakepath\upload.png
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length - 1]);	
	});
	
	// submit 버튼 클릭할 때 이벤트 구분
	$("form[name=replyform]").submit(function() {
		
		if ($.trim($("#board_pass").val()) == "") {
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
		
		if ($.trim($("#board_subject").val()) == "") {
			alert("제목을 입력하세요");
			$("#board_subject").focus();
			return false;
		}
		
		if ($.trim($("#board_content").val()) == "") {
			alert("내용을 입력하세요");
			$("#board_content").focus();
			return false;
		}
		
	}); // submit end
}); // ready() end