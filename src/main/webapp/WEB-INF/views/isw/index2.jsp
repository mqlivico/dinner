<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.hxy.isw.entity.Employee"%>
<c:set var="app"><%= request.getContextPath() %></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>-威欧斯后台管理-</title>
<%-- <link rel="shortcut icon" href="${app}/ico/favicon.ico"> --%>
<link rel="stylesheet" type="text/css" href="${app}/css/bootstrap-2.2.1.min.css" media="all">
<link rel="stylesheet" type="text/css" href="${app}/css/business/style.css" media="all">
<link type="text/css" rel="stylesheet" href="${app}/styles/index/index.css"/>
<link type="text/css" rel="stylesheet" href="${app}/styles/index/base.css"/>
<link type="text/css" rel="stylesheet" href="${app}/styles/index/sms.css"/>
<link type="text/css" rel="stylesheet" href="${app}/styles/index/menu.css"/>
<link rel="stylesheet" type="text/css" href="${app}/js/jquery/plugins/jquery-easyui-1.2.6/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${app}/js/jquery/plugins/jquery-easyui-1.2.6/themes/icon.css">
<link type="text/css" rel="stylesheet" href="${app}/styles/index/jquery_dialog.css" />
<link type="text/css" rel="stylesheet" href="${app}/styles/index/tabchange.css" />
<link type="text/css" rel="stylesheet" href="${app}/css/easyTree.css" />
<script type="text/javascript" language="javascript" src="${app}/js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/date.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/dater.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/plugins/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/plugins/jquery-easyui-1.2.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/plugins/json/jquery.json-2.2.min.js"></script>
<script type="text/javascript" language="javascript" src="${app}/js/jquery/plugins/highchars/highcharts.js"></script>

   <!--  <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=CgMUd8B45U7e8KVshQ8IfhNE"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerManager/1.2/src/MarkerManager.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/EventWrapper/1.2/src/EventWrapper.js"></script>
 -->
</head>
<body >

	<!-- <div style="float: left;width: 50%;" id="index_center"></div>  -->
	
		<div id="header">
		<div class="container style_select">
			<div class="row">
				<h1 class="span4">威欧斯后台管理</h1>
<!-- 				<select id="select_cl" class="span3">
										<option value="Sk0tMDA3NA">恒兴缘地产</option>
									</select> -->

			<!--	<div id="select_cl" class="dropdown span3">
				 	<a class="dropdown-toggle" data-toggle="dropdown" href="#"><div class="cl_name">恒兴缘地产</div><i class="icon-chevron-down icon-white"></i></a>
					<ul class="dropdown-menu span3" role="menu">
												<li>
							<a href="" data="Sk0tMDA3NA">恒兴缘地产</a>
						</li>
											</ul> 
				</div>-->

				<a href="javascript:;" id="sys_exit" class="btn_transparent right">退出</a>
				<a id="header_username" class="btn_transparent"><img src="${app}/image/ti.png" alt="" /></a>
			</div>
		</div>
	</div>
	
		<div id="nav">
		<div class="container">
			<ul class="row">
				<!-- <a  id="user_management_nav" class="span2">信息录入</a> -->
				<a  id="membership_management_nav" class="span2">订单</a>
				<a  id="index_nav" class="span2">待定</a>
				<a  id="router_admin_nav" class="span2">待定</a>
				<a  id="status_table_nav" class="span2">待定</a>

			</ul>
		</div>
	</div>
<div id="content" class="container" style="display: none;"></div>
	<script type="text/javascript">
	var Q = {};
	Q.url = '${app}';
	</script>
	<script type="text/javascript" language="javascript" src="${app}/js/index/init.js"></script>
</body>
<script>
var name = '<%=((Employee)session.getAttribute("loginEmp")).getName()%>';
$('#header_username').html('欢迎您，<font color="red">'+name+"</font>！");

querycusinfo();
function querycusinfo(){
	$.ajax({
		url:Q.url+"/html2/model/retireinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
}

//退休人员信息表
$('#header_username').die('click').live('click',function(){
	$.ajax({
		url:Q.url+"/html2/model/retireinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
});


//3
$('#router_admin_nav').die('click').live('click',function(){
	$.ajax({
		url:Q.url+"/html2/model/historyinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
});
//4
$('#status_table_nav').die('click').live('click',function(){
	$.ajax({
		url:Q.url+"/html2/model/historyinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
});
//2
$('#index_nav').die('click').live('click',function(){
	 $.ajax({
		url:Q.url+"/html2/model/addbatch.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
	//window.open(Q.url+'/html/model/index.html');
});

//1
$('#membership_management_nav').die('click').live('click',function(){
	/* $.ajax({
		url:Q.url+"/html2/model/addretireinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) */
	
	$.ajax({
		url:Q.url+"/html2/model/retireinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
});


$('#sys_exit').die('click').live('click',function(){
	$.messager.confirm('提示', '确定要退出吗？', function(r){
		if (r){
			$.ajax({
				url: Q.url+"/isw/exit.action",
				success: function(data){
					
						location.reload();
					
				}
			});
		}
	});
}); 
</script>
</html>