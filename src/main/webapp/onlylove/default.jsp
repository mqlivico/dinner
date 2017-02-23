<%@ page import="com.hxy.isw.util.ConstantUtil" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>
<%@ page import="com.hxy.isw.thread.ReflushAccessToken" %>
<%@ page import="com.hxy.isw.util.HttpConnectionUtil" %>
<%@ page import="com.hxy.isw.util.JsonUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="app"><%= request.getContextPath() %></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>唯爱九九</title>
<base  />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link href="index/css/iscroll.css" rel="stylesheet" type="text/css" />
<link href="index/css/cate/cate16_3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="index/css/plugmenu.css">
<style>
 
 .themeStyle{background:#E83407 !important; background-color:#E83407 !important; }  
</style>

 <%
String code = request.getParameter("code");
String state = request.getParameter("state");
//System.out.println("code..."+code+"...state..."+state);

if(code!=null&&state!=null){
	String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+ConstantUtil.APPID+"&secret="+ConstantUtil.SECRET+"&code="+code+"&grant_type=authorization_code";
	String result =  HttpConnectionUtil.get(url);
	System.out.println(result);
	JsonObject json = (JsonObject) new JsonParser().parse(result);
	if(json.get("errcode")==null){
		String openid = json.get("openid").getAsString();
		System.out.println("openid:"+openid);
		session.setAttribute("openid", openid);
	}
}
%>

<script src="index/js/iscroll.js" type="text/javascript"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">


var myScroll;

function loaded() {
myScroll = new iScroll('wrapper', {
snap: true,
momentum: false,
hScrollbar: false,
onScrollEnd: function () {
document.querySelector('#indicator > li.active').className = '';
document.querySelector('#indicator > li:nth-child(' + (this.currPageX+1) + ')').className = 'active';
}
 });
 
 
}

document.addEventListener('DOMContentLoaded', loaded, false);
</script>
</head>

<body id="cate16">
<iframe src="@ac=cookie&c=fromUsername" width="0" height="0" frameborder="0" ></iframe>
<div class="mainbg"><img src="weixin/index.jpg"></div>

<div class="mainmenu">
<ul>
   
<!-- <li>
<div class="menubtn"><a href="default.htm">
            <div class="menuimg"><img src="weixin/home.png" /></div>
<div class="menutitle">首页</div></a>
</div>

</li>
 
<li>
<div class="menubtn"><a href="jieshao.htm">
            <div class="menuimg"><img src="weixin/about.png" /></div>
<div class="menutitle">公司简介</div></a>
</div>

</li> -->
 
<!-- <li>
<div class="menubtn"><a href="wxapi.php@ac=news1&w=2&tid=11151">
            <div class="menuimg"><img src="weixin/brand.png" /></div>
<div class="menutitle">品牌诠释</div></a>
</div>

</li>
 
<li>
<div class="menubtn"><a href="wxapi.php@ac=photo&tid=569&w=1">
            <div class="menuimg"><img src="weixin/product.png" /></div>
<div class="menutitle">产品相册</div></a>
</div>

</li> -->
 
<li>
<div class="menubtn"><a href="jaimeng.htm">
            <div class="menuimg"><img src="weixin/join.png" /></div>
<div class="menutitle">我有房</div></a>
</div>

</li>
 
<li>
<div class="menubtn"><a href="lianxi.htm">
            <div class="menuimg"><img src="weixin/contact.png" /></div>
<div class="menutitle">我要房</div></a>
</div>

</li>
 	
<div class="clr"></div>
        
       
</ul>
</div>


<div class="plug-div">
        <div class="plug-phone">
            <div class="plug-menu themeStyle"><span class="close"></span></div> 
               
                        <div class="themeStyle plug-btn plug-btn1 close"><a  href="tel:15071438685"><span style="background-image: url(index/images/plugmenu/plugmenu1.png);" ></span></a></div>
                  
                        <div class="themeStyle plug-btn plug-btn2 close"><a  href="@ac=fans&c=fromUsername&tid=569"><span style="background-image: url(index/images/plugmenu/plugmenu2.png);" ></span></a></div>
                  
                        <div class="themeStyle plug-btn plug-btn3 close"><a  href="../comment.duapp.com/@openid=fromUsername&wxid=041dea8184944dbe512144f5307a67b4"><span style="background-image: url(index/images/plugmenu/plugmenu4.png);" ></span></a></div>
                  
                        <div class="themeStyle plug-btn plug-btn4 close"><a  href="@ac=cardunion&tid=569&c=fromUsername"><span style="background-image: url(index/images/plugmenu/plugmenu10.png);" ></span></a></div>
                         
<div class="plug-btn plug-btn5 close"></div>
                    </div>
</div>
<script src="index/js/zepto.min.js" type="text/javascript"></script>
<script src="index/js/plugmenu.js" type="text/javascript"></script>



  <div class="copyright"  >




</div> <div style="display:none"> </div>

<script>
var count = document.getElementById("thelist").getElementsByTagName("img").length;	

var count2 = document.getElementsByClassName("menuimg").length;
for(i=0;i<count;i++){
 document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";

}
document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";

 setInterval(function(){
myScroll.scrollToPage('next', 0,400,count);
},3500 );
window.onresize = function(){ 
for(i=0;i<count;i++){
document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";

}
 document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";
} 


</script>
 
 	<script src="jquery.min.js"></script>
 <script type="text/javascript">
//获取JS-SDK权限配置参数
 $.ajax({
 	url: "/model/find.action",
 	dataType:'json',
 	type:'get',
 	data:{"url":location.href},
// 	data:{"url":"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx44f90f8d53c3c9be&redirect_uri=http://lcc.so/html/mpnews.jsp&response_type=code&scope=snsapi_base&state=STATE"},
 	success: function(data){
 		if(data.op=="timeout"){
 			alert("等待超时，请先返回，再重新进入");
 			return;
 		}
 		
 		perData(data);
 		
 	}
 })


 //配置JS-SDK权限
 function perData(data){
  	/*alert(data.appId);
 	alert(data.timestamp);
 	alert(data.nonceStr);
 	alert(data.signature);  */
 	wx.config({
 	      debug: false,
 	      appId: data.appId+'',
 	      timestamp: parseInt(data.timestamp),
 	      nonceStr: data.nonceStr+'',
 	      signature: data.signature+'',
 	      jsApiList: [
 	        'checkJsApi',
 	        'onMenuShareTimeline',
 	        'onMenuShareAppMessage',
 	        'onMenuShareQQ',
 	        'onMenuShareWeibo',
 	        'hideMenuItems',
 	        'showMenuItems',
 	        'hideAllNonBaseMenuItem',
 	        'showAllNonBaseMenuItem',
 	        'translateVoice',
 	        'startRecord',
 	        'stopRecord',
 	        'onRecordEnd',
 	        'playVoice',
 	        'pauseVoice',
 	        'stopVoice',
 	        'uploadVoice',
 	        'downloadVoice',
 	        'chooseImage',
 	        'previewImage',
 	        'uploadImage',
 	        'downloadImage',
 	        'getNetworkType',
 	        'openLocation',
 	        'getLocation',
 	        'hideOptionMenu',
 	        'showOptionMenu',
 	        'closeWindow',
 	        'scanQRCode',
 	        'chooseWXPay',
 	        'openProductSpecificView',
 	        'addCard',
 	        'chooseCard',
 	        'openCard'
 	      ]
 	  });
 }



 //隐藏右上角菜单
   wx.ready(function(){
 	 
 	  wx.hideAllNonBaseMenuItem();
 	   
   })
    </script>

</body>
</html> 