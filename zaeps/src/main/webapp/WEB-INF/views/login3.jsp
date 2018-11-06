<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Home</title>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-2.1.0.min.js" ></script>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- RSA -->
<script src="resources/js/RSA/rsa.js"></script>
<script src="resources/js/RSA/jsbn.js"></script>
<script src="resources/js/RSA/prng4.js"></script>
<script src="resources/js/RSA/rng.js"></script>

<!-- 로그인창 -->
<script src="resources/js/login.js"></script>
<link rel="stylesheet" href="resources/css/login.css">

<script>
if('${regResult}' == 1) {
	alert('회원가입이 완료되었습니다.');
}
	
function doLogin() {
	var id = $('#id');
	var pw = $('#password');
	
	// 아이디 미입력시
	if (id.val() == "") {
		alert("아이디를 입력하지 않았습니다.");
		id.focus();
		id.select();
		return false;
	}
	
	//비밀번호 입력여부 체크
	if (pw.val() == "") {
		alert("비밀번호를 입력하지 않았습니다.");
		pw.focus();
		pw.select();
		return false;
	}
	
    // rsa 암호화
    var rsa = new RSAKey();
    rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    
    id = $("#user_id").val(rsa.encrypt(id.val()));
    pw = $("#user_pw").val(rsa.encrypt(pw.val()));
    
	$.ajax({
		type:'POST',
		url:'login.do',
		dataType : 'json',
		data : {'id':id.val(), 'pw':pw.val()},
		success:function(result){
			if (result.check == 'success') { // 로그인 성공시 
				alert('로그인 성공');
				location.href='result';
			} else if(result.check == 'fail') { //로그인 실패시 
				alert('아이디와 비밀번호가 일치하지 않습니다.');
				location.href='login';
			} else if(result.check == 'rsa_fail') {
				alert('암호화 인증에 실패하였습니다.');
				location.href='login';
			}
		}
	});
}


</script>
</head>
<body>
	<div id="formWrapper">
		<div id="form">
			<div class="logo">
			<h1 class="text-center head">Log In</h1>
			</div>
			<div class="form-item">
				<p class="formLabel">Id</p>
				<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
				<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
				<input type="email" name="id" id="id" class="form-style" autocomplete="off"/>
			</div>
			
			<div class="form-item">
				<p class="formLabel">Password</p>
				<input type="password" name="password" id="password" class="form-style" />
				<!-- <div class="pw-view"><i class="fa fa-eye"></i></div> -->
				<p><a href="forgotPassword" ><small>Forgot Password ?</small></a></p>	
			</div>
			
			<div class="form-item">
			<p class="pull-left"><a href="register"><small>Register</small></a></p>
			<input type="hidden" id="user_id" name="user_id">
			<input type="hidden" id="user_pw" name="user_pw">
			<input type="button" class="login pull-right" value="Log In" onclick="doLogin()">
			<div class="clear-fix"></div>
			</div>
		</div>
	</div> 
</body>
</html>
