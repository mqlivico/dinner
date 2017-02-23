<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8" id="h2_html">统计信息</h2>
			
		</div>
	</div>
</div>
<div id="index_content" >
 <span>&nbsp;&nbsp;&nbsp;日期：<input type="text" id="time_start" class="span2" style="height:20px;width:80px;" data-date-format="yyyy-mm-dd" readonly>至
 <input type="text" id="time_end" class="span2" style="height:20px;width:80px;" data-date-format="yyyy-mm-dd" readonly>
 &nbsp; &nbsp;时段：<select id="timetype"><option value="0" selected>所有</option><option value="1" >午餐</option><option value="2">晚餐</option></select>
 &nbsp; &nbsp;员工：<input type="text" id="name" style="margin-bottom:10px;">&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" id = "querydinner">查询</button>&nbsp;&nbsp; 
 </span>
<div class="row" id="table_status_row">

	<div class="span12">
		<h3 id="hqd">新订单列表</h3>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>姓名</th>
					<th>时段 </th>
					<th>日期</th>
					
				</tr>
			</thead>
			<tbody  id= "tbody">
			</tbody>
			<thead>
				<tr>
					<th id="total_pages" ></th>
					<th id="money"></th>
					<th id="button_page"></th>
				</tr>
			</thead>
		</table>
	</div>
</div>

</div>
<script>
$('#time_start').datepicker({
	startDate: "1970-01-01",
	endDate: "0d",
	language: "cn",
	showOtherMonths:false,
	autoclose: "true"
});

 
 $('#time_end').datepicker({
		startDate: "1970-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 
 var mydate = new Date();

//var enddate = new Date(Date._parse(mydate)).addDays(-1);
var enddate = mydate;
var mm = "";
var dd = "";
if(enddate.getMonth()<9){
	 mm = 0+""+(enddate.getMonth()+1);
}else{
	 mm = (enddate.getMonth()+1);
}

if(enddate.getDate()<10){
	 dd = 0+""+enddate.getDate();
}else{
	 dd = enddate.getDate();
}



$("#time_end").val(enddate.getFullYear()+"-"+mm+"-"+dd);
$("#time_start").val(enddate.getFullYear()+"-"+mm+"-01");

$("#time_start").change(function(){
	var time_start = $("#time_start").val();
	var time_end = $("#time_end").val();
	
	if(time_end!=null&&time_end.length>0){
		if(time_start.split("-")[0]!=time_end.split("-")[0]||time_start.split("-")[1]!=time_end.split("-")[1]){
			if(time_start.split("-")[1]=='02')$("#time_end").val(time_start.split("-")[0]+"-"+time_start.split("-")[1]+"-28");
			else if(time_start.split("-")[1]=='04'||time_start.split("-")[1]=='06'||time_start.split("-")[1]=='09'||time_start.split("-")[1]=='11')$("#time_end").val(time_start.split("-")[0]+"-"+time_start.split("-")[1]+"-30");
			else $("#time_end").val(time_start.split("-")[0]+"-"+time_start.split("-")[1]+"-31");
		}
	}
})

$("#time_end").change(function(){
	var time_start = $("#time_start").val();
	var time_end = $("#time_end").val();
	
	if(time_end!=null&&time_end.length>0){
		if(time_start.split("-")[0]!=time_end.split("-")[0]||time_start.split("-")[1]!=time_end.split("-")[1]){
			$("#time_start").val(time_end.split("-")[0]+"-"+time_end.split("-")[1]+"-01");
		}
	}
})

var pagerows = 10;
var thispage = 1;
var pages = 1;

queryretireinfo(getCondition());
function queryretireinfo(o){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/querydinner.action",
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
					$('#money').html("");
				}else{
					$('#tbody').html("");
					var tr = '';
					
					for(var c = 0;c <data.rows.length;c++){
						
						var dinner = data.rows[c].dinner;
						
						tr+='<tr xc="len" rid="'+dinner.id+'"  >'+
						    '<td>'+dinner.name+'</td><td>'+(dinner.timetype==1?'午餐':'晚餐')+'</td><td>'+dinner.time+'</td></tr>';
//						
					}
					pages = (parseInt(data.total/pagerows))+(parseInt(data.total)%pagerows==0?0:1);
					//tr+="<tr ><td></td><td>共"+pages+"页，"+data.total+"条数据。。。</td><td><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage'>"+thispage+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-highlight' id='next_page'>下一页</button></td>";
					$('#tbody').html(tr);
					$('#total_pages').html("共"+pages+"页，"+data.total+"条数据。。。");
					if(data.svgm!=null&&data.svgm>0)$('#money').html("<font color='green'>此月餐费"+data.tm+"元，公司和员工各出一半，得到结果：平均"+data.svgm+"元/人。</font><font color='red'>"+data.total+"餐，共"+(data.total*data.svgm).toFixed(2)+"元。。。</font>");
					$('#button_page').html("<button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage' style='padding:0 5px;'>"+thispage+"</font><button class='btn btn-highlight' id='next_page'>下一页</button>");
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
	cus_condition.starttime = $('#time_start').val();
	cus_condition.endtime = $('#time_end').val();
	cus_condition.timetype = $('#timetype').val();
	cus_condition.name = $('#name').val();
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


$('#querydinner').die('click').live('click',function(){
	queryretireinfo(getCondition());
})
</script>