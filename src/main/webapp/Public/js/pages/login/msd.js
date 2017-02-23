$(function(){
	/*背景全屏*/
	bgimg();
		
	/*div居中*/
	landCenter(".login");
	landCenter(".register");
	landCenter(".find-password");
	
	/*inpt框内提示*/
	promptInpt()
	
	login.init();
	regist.submit();
	login.submit();
	findPassword.submit();
});

var regist = regist || {};
var login = login || {};
var findPassword = findPassword || {};

// 注册提交
regist.submit = function(){
	// 点击注册
	$('#btn-regist').click(function(){
		regist._proc();
	});
	
	// 按回车
	$('#regist-form').bind('keyup', function(event) {   
		if (event.keyCode == 13) {
			regist._proc();
		}  
	}); 
}

// 注册
regist._proc = function() {
	var params = {};
	params.email  = $('.reg-email').val();
	params.pwd    = $('.reg-pwd').val();
	params.repwd  = $('.reg-repwd').val();
	params.mobile = $('.reg-mobile').val();
	params.qq     = $('.reg-qq').val();
//	params.code   = $('.reg-code').val();
//	params.invite_code = $('.reg-invite').val();
	
	if (!params.email) {
		regist.showError('请输入用户名');
		$('.reg-email').focus();
		return false;
	}
	if (!/^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/.test(params.email)) {
		regist.showError('用户名格式错误，请输入邮箱');
		$('.reg-email').focus();
		return false;
	}
	if (!params.pwd) {
		regist.showError('请输入密码');
		$('.reg-pwd').focus();
		return false;
	}
	if (!params.repwd) {
		regist.showError('请输入重复密码');
		$('.reg-repwd').focus();
		return false;
	}
	if (params.pwd != params.repwd) {
		regist.showError('两次输入的密码不一致');
		$('.reg-repwd').focus();
		return false;
	}
	if (!params.mobile) {
		regist.showError('请输入手机号');
		$('.reg-mobile').focus();
		return false;
	}
//	if (!params.invite_code) {
//		regist.showError('请输入邀请码');
//		$('.reg-invite').focus();
//		return false;
//	}
/*	if (!params.code) {
		regist.showError('请输入验证码');
		$('.reg-code').focus();
		return false;
	}*/
//	if(!$('#agree').is(":checked")){regist.showError('坚持不同意使用协议就无法使用读心系统');return false;}
	regist.hideError();
	
	// 提交数据
	$.ajax({
		url : 'isw/procRegist.action',
		type: 'post',
		dataType: 'json',
		data: params,
		async: false,
		success: function(json) {
			if (json.status == 1) {
				alert("注册成功，请登录");
				// 清空表单
				$('#regist-form').get(0).reset();
				$('#login-form').get(0).reset();
				login.init();
				// 切换登录界面
				switching('.register','.login');
			} else {
				regist.showError(json.info);
			}
		}
	});
}

regist.showError = function(msg){
	$('#regist-form .prompt').show();
	$('#regist-form .prompt-error').html(msg);
}

regist.hideError = function() {
	$('#regist-form .prompt').hide();
	$('#regist-form .prompt-error').html('');
}

//登陆提交
login.submit = function(){
	// 点击注册
	$('#btn-login').click(function(){
		login._proc();
	});
	
	// 按回车
	$('#login-form').bind('keyup', function(event) {   
		if (event.keyCode == 13) {
			login._proc();
		}  
	}); 
}

//登陆
login._proc = function() {
	/*var params = {};
	params.username  = $('.login-email').val();
	params.password    = $('.login-pwd').val();
	//params.wxid   = $('.login-wxid').val();
	params.code_id = 'login';*/
	
	
	/*if (!params.wxid) {
		login.showError('请输入微信号');
		$('.login-email').focus();
		return false;
	}*/
/*	if (!params.username) {
		login.showError('请输入用户名');
		$('.login-email').focus();
		return false;
	}
	if (!params.password) {
		login.showError('请输入密码');
		$('.login-pwd').focus();
		return false;
	}*/
	/*if (!params.code) {
		login.showError('请输入验证码');
		$('.login-code').focus();
		return false;
	}*/
	
	//login.hideError();
	
	// 提交数据
/*	$.ajax({
		url : '../isw/wdoLogin.action',
		type: 'post',
		dataType: 'json',
		data: params,
		async: false,
		success: function(json) {
			if (json.status == 1) {
				// 清空表单
				location.reload();
			} else {
				login.showError(json.info);
			}
		}
	});*/
	$('#btn-login').val('下      载     中....');
	$('#btn-login').attr("disabled","disabled");
	$.ajax({
		url: "../isw/outportretireinfo.action",
		type: 'post',
		dataType: 'json',
		data: {},
		async: false,
		success: function(data){
			
				
			if(data.op=='success'){
				$('#openexcel').attr('href',"/excel/data_excel.xls");//.css({"display":"block"}).text("点我").click();
				//window.open(Q.url+"/excel/cus_excel.xls");
				$('#exporttext').click();
			}else if(data.op=='noexist'){
				alert("今日数据还未生成");
			}
			$('#btn-login').removeAttr("disabled");
			$('#btn-login').val("下      载");
		}
	})
}

login.showError = function(msg){
	$('#login-form .prompt').show();
	$('#login-form .prompt-error').html(msg);
}

login.hideError = function() {
	$('#login-form .prompt').hide();
	$('#login-form .prompt-error').html('');
}

//防止后退到该页面时，输入框内有数据，但仍显示提示的问题。
login.init = function(){
	$('.inptText').each(function(index, value){
		if ($(this).val() == '') {
			$(this).prev('.promptInpt').children('.promptTxt').show();
		} else {
			$(this).prev('.promptInpt').children('.promptTxt').hide();
		}
	});
}

//找回密码
findPassword.submit = function(){
	// 点击找回密码
	$('#btn-find-password').click(function(){
		findPassword._proc();
	});
	
	// 按回车
	$('#find-password-form').bind('keyup', function(event) {   
		if (event.keyCode == 13) {
			findPassword._proc();
		}
	}); 
}

//发起找回密码请求
findPassword._proc = function() {
	var params = {};
	params.email  = $('.find-password-email').val();
	params.code   = $('.find-password-code').val();
	params.code_id = 'find_password';
	
	if (!params.email) {
		findPassword.showError('请输入用户名');
		$('.find-password-email').focus();
		return false;
	}
	if (!params.code) {
		findPassword.showError('请输入验证码');
		$('.find-password-code').focus();
		return false;
	}
	
	// 提交数据
	$.ajax({
		url : '/login/procFindPassword',
		type: 'post',
		dataType: 'json',
		data: params,
		async: false,
		success: function(json) {
			if (json.status == 1) {
				// 显示提示信息
				findPassword.showSuccess(json.info);
			} else {
				findPassword.showError(json.info);
			}
		}
	});
}

//找回密码的错误提示
findPassword.showError = function(msg){
	$('#find-password-form .prompt-success').hide();
	$('#find-password-form .prompt-success').html('');
	
	$('#find-password-form .prompt-error').html(msg);
	$('#find-password-form .prompt-error').show();
	$('#find-password-form .prompt').show();
	
}

//找回密码的成功提示
findPassword.showSuccess = function(msg){
	$('#find-password-form .prompt-error').hide();
	$('#find-password-form .prompt-error').html('');
	
	$('#find-password-form .prompt-success').html(msg);
	$('#find-password-form .prompt-success').show();
	$('#find-password-form .prompt').show();
}