<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-2.1.0.min.js" ></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
$(function() {
	/* 우편번호 검색 */
	$('#searchAddress').click(function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;

	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('post').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('address').value = fullAddr;

	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('addressDetail').focus();
	            document.getElementById('addressDetail').select();
	        }
	    }).open();
	});
	
	/* 아이디 중복체크 */
	$('#dupIdCheck').click(function() {
		var form = document.registerForm;
		var id = form.id.value;
		//아이디 입력여부 검사
		if (id == "") {
			alert("아이디를 입력하지 않았습니다.");
			form.userId.focus();
			form.userId.select();
			return false;
		}
	 	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
		for (i = 0; i < id.length; i++) {
			ch = form.id.value.charAt(i)
			if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
				alert("아이디는 대소문자, 숫자만 입력가능합니다.");
				form.id.focus();
				form.id.select();
				return false;
			}
		}
		//아이디에 공백 사용하지 않기
		if (id.indexOf(" ") >= 0) {
			alert("아이디에 공백을 사용할 수 없습니다.");
			form.id.focus();
			form.id.select();
			return false;
		}
		//아이디 길이 체크 (4~12자)
		if (id.length<4 || id.length>20) {
			alert("아이디를 영문, 숫자로 4자이상 20자이내로 입력해주세요.");
			form.id.focus();
			form.id.select();
			return false;
		}
		$.ajax({
			type:'POST',
			url:'dupIdCheck',
			dataType : 'json',
			data : {'id':id},
			success:function(result){
				if (result.check == 'success') { //중복ID 없을 시
					$('#idDupFlag').val('idCheck');
					alert('사용 가능한 아이디입니다.');
				} else if(result.check == 'fail'){ //중복ID 있을 시 
					$('#idDupFlag').val('idUnCheck');
					alert('이미 사용중인 아이디입니다.');
				}
			}
		});
	});
	
	/* 아이디 입력시 중복체크를 다시 하게 한다. */
	$('#id').keyup(function() {
		$('#idDupFlag').val('idUnCheck');
	});
	
	/* 비밀번호 일치여부 체크 */
	$('#pw').keyup(function() {
		if($('#pw').val() != $('#confirmPw').val()){
			$('#check').text('');
			$('#check').css('color', 'red');
			$('#check').html("비밀번호가 일치하지 않습니다.");
		} else {
			$('#check').text('');
			$('#check').css('color', 'green');
			$('#check').html("비밀번호가 일치합니다.");
		}
	});
	
	$('#confirmPw').keyup(function() {
		if($('#pw').val() != $('#confirmPw').val()){
			$('#check').text('');
			$('#check').css('color', 'red');
			$('#check').html("비밀번호가 일치하지 않습니다.");
		} else {
			$('#check').text('');
			$('#check').css('color', 'green');
			$('#check').html("비밀번호가 일치합니다.");
		}
	});
	
	if('${regResult}' == '0') {
		alert('회원가입에 실패했습니다.');
	}
});

/* 회원가입 버튼 클릭 시 유효성검사 실시*/
function register() {
	var reg_pw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //비밀번호 정규식(특수문자/문자/숫자 포함 8~15자리)
	var reg_email = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; //이메일 정규식
	var form = document.registerForm;
	var id = form.id.value;
	var pw = form.pw.value;
	var dupIdCheck = form.idDupFlag.value;
	var email = form.email.value;
	
	if(dupIdCheck == 'idUnCheck') {
		alert('아이디 중복확인 버튼을 눌러주세요.');
		form.id.focus();
		form.id.select();
		return false;
	}
	
/* 	//아이디 입력여부 검사
	if (id == "") {
		alert("아이디를 입력하지 않았습니다.");
		form.id.select();
		return false;
	}
	
 	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
	for (i = 0; i < id.length; i++) {
		ch = form.id.value.charAt(i)
		if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
			alert("아이디는 대소문자, 숫자만 입력가능합니다.");
			form.id.select();
			return false;
		}
	}
	
	//아이디에 공백 사용하지 않기
	if (id.indexOf(" ") >= 0) {
		alert("아이디에 공백을 사용할 수 없습니다.");
		form.id.select();
		return false;
	}
	
	//아이디 길이 체크 (4~12자)
	if (id.length<4 || id.length>20) {
		alert("아이디를 영문, 숫자로 4자이상 20자이내로 입력해주세요.");
		form.id.select();
		return false;
	} */
	
	//비밀번호 입력여부 체크
	if (pw == "") {
		alert("비밀번호를 입력하지 않았습니다.");
		form.pw.focus();
		form.pw.select();
		return false;
	}
	
	if (pw == id) {
		alert("아이디와 비밀번호가 같습니다.");
		form.pw.focus();
		form.pw.select();
		return false;
	}
	
	if(!reg_pw.test(pw)) {
		alert("비밀번호를 특수문자/문자/숫자 포함 8~15자 이내로 입력해주세요.");
		form.pw.focus();
		form.pw.select();
		return false;
	}
	
	//비밀번호와 비밀번호 확인 일치여부 체크
	if (pw != form.confirmPw.value) {
		alert("비밀번호가 일치하지 않습니다");
		form.confirmPw.value = "";
		form.confirmPw.focus();
		form.confirmPw.select();
		return false;
	}
	
	//이름 형식 2글자 이상
	if (form.name.value == "") {
		alert("이름을 입력하지 않았습니다.")
		form.name.focus();
		form.name.select();
		return false;
	}
	if(form.name.value.length<2){
		alert("이름을 2자 이상 입력해주십시오.")
		form.name.focus();
		form.name.select();
		return false;
	}
	
	//핸드폰 번호 체크
	if (form.tel1.value == "") {
		alert("핸드폰을 입력하지 않았습니다.")
		form.tel1.focus();
		form.tel1.select();
		return false;
	}
	if (form.tel2.value == "") {
		alert("핸드폰을 입력하지 않았습니다.");
		form.tel2.focus();
		form.tel2.select();
		return false;
	}
	if (form.tel3.value == "") {
		alert("핸드폰을 입력하지 않았습니다.");
		form.tel3.focus();
		form.tel3.select();
		return false;
	}
	if(form.tel1.value.length<3){
		alert("핸드폰1을 3자 이상 입력해주십시오.")
		form.tel1.focus();
		form.tel1.select();
		return false;
	}
	if(form.tel2.value.length<3){
		alert("핸드폰2를 3자 이상 입력해주십시오.")
		form.tel2.focus();
		form.tel2.select();
		return false;
	}
	if(form.tel3.value.length<3){
		alert("핸드폰3을 3자 이상 입력해주십시오.")
		form.tel3.focus();
		form.tel3.select();
		return false;
	}
	
	//동물원 이름 형식 2글자 이상
	if (form.zooName.value == "") {
		alert("동물원 이름을 입력하지 않았습니다.")
		form.zooName.focus();
		form.zooName.select();
		return false;
	}
	if(form.zooName.value.length<2){
		alert("동물원 이름을 2자 이상 입력해주십시오.")
		form.zooName.focus();
		form.zooName.select();
		return false;
	}
	
	//근무지 우편번호 및 주소체크
	if (form.post.value == "") {
		alert("우편번호를 입력하지 않았습니다.")
		form.post.focus();
		form.post.select();
		return false;
	}
	if (form.address.value == "") {
		alert("주소를 입력하지 않았습니다.")
		form.address.focus();
		form.address.select();
		return false;
	}
	
	//이메일 형식 체크
	if (form.email.value == "") {
		alert("이메일을 입력하지 않았습니다.")
		form.email.focus();
		form.email.select();
		
		return false;
	}
	if (reg_email.test(email) == false) {
		alert("잘못된 이메일 형식입니다.");
		form.email.value=""
		form.email.focus();
		form.email.select();
		return false;
	}
	
	
	form.submit();
}

</script>
</head>
<body>
<h2>회원가입</h2>
<form name="registerForm" action="register.do" method="post">
	<table class="table talble-borderd">
		<tr>
			<td style="font-size:10pt;">
				아이디
			</td>
			<td>
				<input type="text" name="id" id="id" size="25" maxlength="20" style="border:1px solid #A4A4A4">
				<input class="btn btn-default btn-xs" type="button" id="dupIdCheck" value="아이디 중복확인">
				<input type="hidden" id ="idDupFlag" name="idDupFlag" value="idUnCheck">
			</td>
		</tr>
		
		<tr>
			<td style="font-size:10pt;">
				비밀번호
			</td>
			<td>
				<input type="password" name="pw" id="pw" size="25" maxlength="20" style="border:1px solid #A4A4A4">
			</td>
		</tr>
		
		<tr>
			<td style="font-size:10pt;">
				비밀번호 확인
			</td>
			<td>
				<input type="password" name="confirmPw" id="confirmPw" size="25" maxlength="20" style="border:1px solid #A4A4A4">
				<font id="check" color="red"></font>
			</td>
		</tr>
		
		<tr>
			<td style="font-size:10pt;">
				담당자 이름
			</td>
			<td>
				<input type="text" name="name" id="name" size="25" maxlength="15" style="border:1px solid #A4A4A4">
			</td>
		</tr>
		
		<tr>
			<td style="font-size:10pt;">
				담당자 휴대폰
			</td>
			<td>
				<select name="tel1" id="tel1" style="border:1px solid #A4A4A4; font-size:10pt; height:25px">
					<option value="010" selected>010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="019">019</option>
				</select> -
				<input type="text" name="tel2" id="tel2" size="4" maxlength="4" style="border:1px solid #A4A4A4"> -
				<input type="text" name="tel3" id="tel3" size="4" maxlength="4" style="border:1px solid #A4A4A4">
			</td>
		</tr>
		
		<tr>
			<td style="font-size:10pt;">
				동물원 이름
			</td>
			<td>
				<input type="text" name="zooName" id="zooName" size="25" maxlength="15">
			</td>
		</tr>
		
		<tr>
			<td rowspan="3" style="font-size:10pt;">
				동물원 주소
			</td>
			<td>
				<input type="text" name="post" id="post" size="7" style="border:1px solid #A4A4A4" readonly>
				<input class="btn btn-default btn-xs" type="button" id="searchAddress" value="우편번호 검색">
			</td>
		</tr>
		
		<tr>
			<td><input type="text" name="address" id="address" size="60" style="border:1px solid #A4A4A4" readonly></td>
		</tr>
		
		<tr>
			<td><input type="text" name="addressDetail" id="addressDetail" size="60" style="border:1px solid #A4A4A4"></td>
		</tr>
		

		
		<tr>
			<td style="font-size:10pt;">
				이메일
			</td>
			<td>
				<input type="text" name="email" id="email" size="40" style="border:1px solid #A4A4A4">
			</td>
		</tr>
		
		<tr>
			<td>
				<button type="button" class="btn btn-success" onclick="register()">회원가입</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>