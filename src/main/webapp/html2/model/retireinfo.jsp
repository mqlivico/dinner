<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8" id="h2_html">订单信息</h2>
			
		</div>
	</div>
</div>
<div id="index_content" >
 <span>&nbsp;&nbsp;&nbsp;姓名：<input type="text" id="retire_name" style="margin-bottom:10px;">&nbsp;&nbsp;&nbsp;
电话：<input type="text" id="retire_mobileno" style="margin-bottom:10px;">&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;
订单状态：<select id="retire_state">
<option value="-1" selected="selected">所有</option>
<option value="0">未处理</option>
<option value="1">正在沟通</option>
<option value="2">已确认</option>
<option value="3">已打印</option>
<option value="4">已包装</option>
<option value="5">已发货</option>
<option value="6">已完成</option>
<option value="7">无效订单</option>
</select>
&nbsp;&nbsp;&nbsp;
支付状态：<select id="pay_state">
<option value="-1" selected="selected">所有</option>
<option value="0">未支付</option>
<option value="1">已支付</option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" id = "queryretire">查询</button>&nbsp;&nbsp; 
 </span>
<div class="row" id="table_status_row">

	<div class="span12">
		<h3 id="hqd">信息列表</h3>

		<table class="table table-hover">
			<thead>
				<tr>
					<!-- <th>申报编号</th>
					<th>档案编号</th> -->
					<th>时间 </th>
					<th>照片 </th>
					<th>姓名 </th>
					<!-- <th>性别</th>
					<th>出生年月</th>
					<th>单位</th> -->
					<th>电话</th>
					<th>地址</th>
					<th>状态</th>
					<th>支付状态</th>
					<!-- <th>备注</th> -->
					
				</tr>
			</thead>
			<tbody  id= "tbody">
			</tbody>
			<thead>
				<tr>
					<th id="total_pages" ></th>
					<th></th><th></th><th></th><th></th><th></th>
					<th id="button_page"></th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<div class="modal-footer" id="import_div" style="display:none;">  
 <button class="btn btn-primary" id="import">导入</button>&nbsp;&nbsp;&nbsp;没有模板？<a href="html/retireinfo.xls">点击下载</a>
 </div>
 <div id="import_excel_div"></div>
</div>
<script>
var pagerows = 10;
var thispage = 1;
var pages = 1;

var thispageofbr = '<%=request.getParameter("thispage")%>';

if(thispageofbr!='null')thispage = thispageofbr;

queryretireinfo(getCondition());
function queryretireinfo(o){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/queryorder.action",
//		data:{"page":thispage,"rows":pagerows},
		data:o,
		success: function(data){
			if(typeof(data)=='object'){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.total==0){
					//$('#members_list').html("暂无成员");
					$('#tbody').html("");
					$('#button_page').html("<font color='red'>无符合条件的记录。。。</font>");
					$('#total_pages').html("");
				}else{
					$('#tbody').html("");
					var tr = '';
					//0未处理 1正在沟通 2已确认 3已打印 4已包装 5已发货  6已完成  7无效订单
					var state_info = ["<font color='red'>未处理</font>","正在沟通","已确认","已打印","已包装","<font color='blue'>已发货</font>","<font color='green'>已完成</font>","<font color='gray'>无效订单</font>"];
					var pay_state = ["<font color='gray'>未支付</font>","<font color='green'>已支付</font>"];
					for(var c = 0;c <data.rows.length;c++){
						
						var yycusinfo = data.rows[c].yycusinfo;
						
						
						tr+='<tr xc="en" rid="'+yycusinfo.id+'"  >'+
						    '<td>'+yycusinfo.time+'</td><td><img width="30px;" src="${app}/forImg/userimg/'+yycusinfo.imageurl+'"></td><td>'+yycusinfo.customername+'</td><td>'+yycusinfo.mobile+'</td><td>'+yycusinfo.address+'</td><td>'+state_info[yycusinfo.state]+'</td><td>'+pay_state[yycusinfo.paystate==null?0:yycusinfo.paystate]+'</td>';
//						
					}
					pages = (parseInt(data.total/pagerows))+(parseInt(data.total)%pagerows==0?0:1);
					//tr+="<tr ><td></td><td>共"+pages+"页，"+data.total+"条数据。。。</td><td><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage'>"+thispage+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-highlight' id='next_page'>下一页</button></td>";
					$('#tbody').html(tr);
					$('#total_pages').html("共"+pages+"页，"+data.total+"条数据。。。");
					$('#button_page').html("<button class='btn btn-highlight' id='fst_page'>首页</button><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage' style='padding:0 5px;'>"+thispage+"</font><button class='btn btn-highlight' id='next_page'>下一页</button><button class='btn btn-highlight' id='end_page'>末页</button>");
				}
			}
			$('#content').smsLoaded();
		}
	});
}

function getCondition(){
	var cus_condition = {};
	cus_condition.page = thispage;
	cus_condition.rows = pagerows;
	cus_condition.retire_name = $('#retire_name').val();
	cus_condition.retire_mobileno = $('#retire_mobileno').val();
	cus_condition.retire_state = $('#retire_state').val();
	cus_condition.pay_state = $('#pay_state').val();
	return cus_condition;
}

$('#queryretire').die('click').live('click',function(){
	thispage = 1;
	
	queryretireinfo(getCondition());
})

$('#pre_page').die('click').live('click',function(){
	if(thispage>1){
		thispage--;
		queryretireinfo(getCondition());
	}else{
		Q.alert("提示","当前已是第一页");
	}
})

$('#next_page').die('click').live('click',function(){
	if(thispage<pages){
		thispage++;
		queryretireinfo(getCondition());
	}else{
		Q.alert("提示","当前已是最后一页");
	}
})

$('#fst_page').die('click').live('click',function(){
	thispage=1;
	queryretireinfo(getCondition());
})

$('#end_page').die('click').live('click',function(){
	thispage=pages;
	queryretireinfo(getCondition());
})

$('#tbody tr[xc="en"]').die('dblclick').live('dblclick',function(){
	var rid = $(this).attr("rid");
	var dp = {};
	//if(st_f=='wwc')dp={"f":"w"};
	dp.thispage = thispage;
	$.ajax({
		url:Q.url+"/html2/model/orderinfo.jsp?rid="+rid,
		dataType:'text',
		data:dp,
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
})

$('#import').die('click').live('click',function(){
	if(batchinfo_id==0){
		Q.alert("提示","系统错误");
		return;
	}
	$('#import_excel_div').load(Q.url+'/html/dialog/importexcel.jsp?bid='+batchinfo_id);
})
</script>