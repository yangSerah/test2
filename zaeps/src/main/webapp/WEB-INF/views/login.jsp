<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Login</title>

<!-- Bootstrap core CSS-->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="resources/css/sb-admin.css" rel="stylesheet">

</head>

  <body class="bg-dark">

    <div class="container">
      <div class="card card-login mx-auto mt-5">
        <div class="card-header">Login</div>
        <div class="card-body">
            <div class="form-group">
              <div class="form-label-group">
                <input type="email" id="inputEmail" name="inputEmail" class="form-control" placeholder="Email address" required="required" autofocus="autofocus">
                <label for="inputEmail">Email address</label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-label-group">
                <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required="required">
                <label for="inputPassword">Password</label>
              </div>
            </div>
            <div class="form-group">
              <div class="checkbox">
                <label>
                  <input type="checkbox" value="remember-me">
                  Remember Password
                </label>
              </div>
            </div>
            <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
			<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
			<input type="hidden" id="user_id" name="user_id">
			<input type="hidden" id="user_pw" name="user_pw">
            <a class="btn btn-primary btn-block" href="javascript:void(0)" onclick="doLogin()">Login</a>
          <div class="text-center">
            <a class="d-block small mt-3" href="register">Register an Account</a>
            <a class="d-block small" href="forgotPassword">Forgot Password?</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
    
    <!-- RSA -->
	<script src="resources/js/RSA/rsa.js"></script>
	<script src="resources/js/RSA/jsbn.js"></script>
	<script src="resources/js/RSA/prng4.js"></script>
	<script src="resources/js/RSA/rng.js"></script>
	
<script>
if('${regResult}' == 1) {
	alert('회원가입이 완료되었습니다.');
}

console.log('session check : ${_RSA_WEB_KEY}');

	
function doLogin() {
	var id = $('#inputEmail');
	var pw = $('#inputPassword');
	
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
				location.href='main';
			} else if(result.check == 'fail') { //로그인 실패시 
				alert('아이디와 비밀번호가 일치하지 않습니다.');
				location.href='login';
			} else if(result.check == 'rsa_fail') {
				alert('암호화 인증에 실패하였습니다.');
				location.href='login';
			} else {
				alert('오류');
			}
		}
	});
}
</script>

</body>

</html>
