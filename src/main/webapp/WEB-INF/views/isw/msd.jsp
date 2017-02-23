<%@ page language="java" isErrorPage="true" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="app"><%= request.getContextPath() %></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<title>数据统计</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="description" content="数据统计" />
<meta name="viewport" content="width=device-width" />
<%-- <link rel="shortcut icon" href="${app}/ico/favicon.ico"> --%>
<link rel="stylesheet" href="${app}/Public/css/bootstrap-2.3.2.css?ver=1.3" />
<link rel="stylesheet" href="${app}/Public/css/flat-ui.css?ver=1.4" />
<link rel="stylesheet" href="${app}/Public/css/normalize.css" />
<link rel="stylesheet" href="${app}/Public/css/main.css?ver=1.8" />
<style type="text/css">	
	#bgimg{
			position:fixed;
			top:0px;
			left:0px;
			z-index:1;
			
			width:100%;
			height:100%; 
			 
			overflow:hidden;
	}
	#bgimg img{
			position:absolute;
			width:100%;
			height:100%;
	}
	
	.login, .register, .find-password{
	  position:absolute; 
	  top:30%;
	  left:30%;
	  z-index:5;
	  
	  padding: 30px;
	  
	  width:440px;
	  height:auto; 
	
	  background-color:rgba(0, 25, 41, 0.6);
	  
	background:transparent\9\0;  
	background:transparent\0;  
	*background:transparent; 
	_background:transparent; 
	
	  filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#7000101a,endColorstr=#7000101a); 
	  zoom: 1;
	  
	  
	  -webkit-border-radius: 15px;
		 -moz-border-radius: 15px;
			  border-radius: 15px;
	}
	
	.login form ,.register form,.find-password form{ display:block; width:248px;}
	.login input ,.register input,.find-password input{ 
	  display:block;
	  
	  margin-bottom:15px;
	  
	  padding-top:10px;
	  padding-bottom:10px; 
	  padding-right:10px; 
	  padding-left:40px; 
	
	  height:20px; 
	  line-height:20px;
	  
	  border-style:solid;
	  border-width:1px;
	  border-color:#fff;
	  
	  background-repeat:no-repeat;
	  background-position: 12px 8px;  
	  
	  -webkit-border-radius: 4px;
		 -moz-border-radius: 4px;
			  border-radius: 4px;
		  
	}
	
	.login input:-moz-placeholder,
	.register input:-moz-placeholder,
	.find-password input:-moz-placeholder {
	  color: #515567; font-weight:bold;
	}
	.login input::-moz-placeholder,
	.register input::-moz-placeholder,
	.find-password input::-moz-placeholder {
	  color: #515567; 
	  font-weight:bold;
	  opacity: 1;
	}
	.login input:-ms-input-placeholder,
	.register input:-ms-input-placeholder,
	.find-password input:-ms-input-placeholder
	 {
	  color: #515567;
	  font-weight:bold;
	}
	.login input::-webkit-input-placeholder,
	.register input::-webkit-input-placeholder,
	.find-password input::-webkit-input-placeholder {
	  color: #515567;
	  font-weight:bold;
	}
	.login input.placeholder,
	.register input.placeholder,
	.find-password input.placeholder {
	  color: #515567;
	  font-weight:bold;
	}
	
	input.error{
	  border-color:#ff8900;
	  -webkit-box-shadow: 0 0 5px #ff8900;
		 -moz-box-shadow: 0 0 5px #ff8900;
			  box-shadow: 0 0 5px #ff8900;
	}
	
	.login input.verification-code ,
	.register input.verification-code,
	.find-password input.verification-code{
		width:90px; padding-left:10px;
	}
	.verification-code-img{ 
	 display:block;
	 margin-left:10px;
	 
	 width:120px;
	 height: 42px; 
	 
	 text-align:center;
	 
	 background-color:#FFF;
	 
	   -webkit-border-radius: 4px;
		 -moz-border-radius: 4px;
			  border-radius: 4px;
	}
	.user , .pwd01 ,.pwd02,.phone,.QQ { display:block;  width:190px; padding-left:10px;}
	.user{ background-image:url(${app}/Public/images/land/ico01.png);}
	.pwd01{  background-image:url(${app}/Public/images/land/ico02.png);}
	.pwd02{  background-image:url(${app}/Public/images/land/ico03.png);}
	.phone{  background-image:url(${app}/Public/images/land/ico04.png);}
	.QQ{  background-image:url(${app}/Public/images/land/ico05.png);}
	
	
	.prompt{ min-height:26px;}
	.prompt-error{ color:#ff8900; padding-left:35px; min-height:30px; /* background:url(${app}/Public/images/land/ico100.png) no-repeat; */}
	.prompt-success{ color:#27ae60; padding-left:35px; min-height:30px; background:url(${app}/Public/images/land/ico101.png) no-repeat;}
	.prompt-success a{text-decoration:underline;color:white;}
	
	.login input.bntH40 ,.register input.bntH40, .find-password input.bntH40{ border:0px; padding:10px 0; width:248px; height:40px; line-height:20px;}
	
	.stat{ width:100%; text-align:center;}
	.stat a{ color:#FFF; font-size:0.75em;}
	.stat a:hover{ text-decoration:underline;}
	
	.verification-code-img img {border-radius:5px;}
	
	.promptInpt{display:block; width:200px; height:0; margin:0 auto; position:relative;  }
	.promptInpt p{display:block; width:180px; height:14px; position:absolute; color:#858585; height:20px; margin-top:0; margin-bottom:0;  top:8px; left:14px;}
</style>
</head>

<body>
<%-- <div style= "width:100%;z-index:2147483647;overflow:visible;position:fixed;float:right; right:0px;top:0px;_position: absolute;_top: expression(documentElement . scrollTop +   documentElement .clientHeight-this . offsetHeight);">
<img src = "${app}/img/qrcode_for_gh_a7e4ff0dd5f6_344.jpg" />
<div> --%>
  <div id="bgimg" class="clearfix">
	<img src="${app}/Public/images/land/lo.jpg"/>
  </div>
  
  <!--登陆-->
 <div class="login" >
<%-- <img class="logo-big fc" src="${app}/Public/images/land/logobig.png" /> --%>
<div class="H30"></div>
<form class="fc" id="login-form">

	
	
	<input class="btn-success bntH40" id="btn-login" name="" type="button" value="下      载" />
	
	
</form>


 </div>
  <a id="openexcel" href="#"><span id="exporttext"></span></a>
 <!--注册-end-->
 
 <!-- 密码找回 -->
 
  <!-- 密码找回-end -->
<script src="${app}/Public/js/core/jquery-1.8.3.min.js"></script>
<script src="${app}/Public/js/core/bootstrap-2.3.2.js?ver=2.3.1.1"></script>
<script src="${app}/Public/js/core/application.js?ver=1.1"></script>
<script src="${app}/Public/js/core/bootstrap-select.js?ver=1.1"></script>
<script src="${app}/Public/js/core/bootstrap-switch.js?ver=1.1"></script>
<script src="${app}/Public/js/core/flatui-checkbox.js"></script>
<script src="${app}/Public/js/core/flatui-radio.js"></script>
<script src="${app}/Public/js/core/jquery.tagsinput.js"></script>
<script src="${app}/Public/js/core/jquery.placeholder.js"></script>
<script src="${app}/Public/js/core/main.js?ver=2.3.1.3"></script>
<script src="${app}/Public/js/core/validate.js?ver=2.5.3"></script>
<script src="${app}/Public/js/core/jquery.easing.min.js"></script>
	

<script src="${app}/Public/js/pages/login/msd.js?ver=2.3.1.1"></script>
</body>
</html>