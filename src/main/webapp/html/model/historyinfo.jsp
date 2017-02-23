<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8">历史批次的信息<font id="history_select" size="3"></font></h2>
		</div>
	</div>
</div>
<div id="index_content" >
<span>年份：</span><span id="history_year"></span><br><br>
<span>月份：</span><span id="history_month"></span><br><br>
<span>批次：</span><span id="history_batchinfo"></span><br><hr>
</div>
 <div class="row" id="table_history_ritire_row" style="display:none;">
	<div class="span12">
		<div class="modal-footer" >  
    		<button class="btn btn-primary" id="addnewretireinfo">新增</button>
    		<button class="btn btn-primary" id="outport">导出</button>
    		
    	</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>申报编号</th>
					<th>档案编号</th>
					<th>姓名 </th>
					<th>性别</th>
					<th>出生年月</th>
					<th>单位</th>
					<th>联系电话</th>
					<th>身份证号</th>
					<th>状态</th>
					<th>备注</th>
					
				</tr>
			</thead>
			<tbody  id= "trtbody">
			</tbody>
			<thead>
				<tr>
					<th id="hs_total_pages" ></th>
					<th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th>
					<th id="hs_button_page"></th>
				</tr>
			</thead>
		</table>
	</div>
</div>
 <a id="openexcel" href="#"><span id="exporttext"></span></a>
  
<script>
var hs_pagerows = 10;
var hs_thispage = 1;
var hs_pages = 1;

var history_data = null;
var batchinfo_id = 0;
var batchinfo_name = '';
$.ajax({
	url: Q.url+"/model/querynewbatch.action",
	data:{},
	async: false,
	success: function(data){
		if( typeof(data) == 'object'  ){
			if(data.op=='timeout' ){
				location.reload();
				return;
			}
			history_data = data;
			if(data.total==0){
				$('#history_year').html('(<font color="red">当前没有任何创建批次</font>)');
			}else{
				var years = [];
				var flag = false;
				for(var i = 0;i<data.total;i++){
					var batchInfo = data.rows[i].batchInfo;
					var create_year = batchInfo.createtime.split("-")[0];
					
					for(var j = 0;j<years.length;j++){
						if(create_year==years[j]){
							flag = true;
							break;
						}
					}
					
					if(!flag)years[years.length]=create_year;
				}
				var hl = "";
				for(var x = 0 ;x<years.length;x++){
					hl += "&nbsp;&nbsp;&nbsp;<button class='btn btn-primary' onclick='clickbyyear("+years[x]+")' >"+years[x]+"年</button>&nbsp;&nbsp;&nbsp;";
				}
				$('#history_year').html(hl);
			}
		}
	}
});


function clickbyyear(year){
	//alert(year);
	$('#history_select').html("("+year+"年)");
	var createtimes = [];
	for(var i = 0;i<history_data.total;i++){
		var batchInfo = history_data.rows[i].batchInfo;
		var create_year = batchInfo.createtime.split("-")[0];
		if(create_year==year)createtimes[createtimes.length]=batchInfo.createtime;
	}
	
	var motnhs = [];
	
	for(var j = 0;j<createtimes.length;j++){
		var flag = false;
		var create_month = createtimes[j].split("-")[1];
		
		for(var k = 0;k<motnhs.length;k++){
			if(create_month==motnhs[k]){
				flag = true;
				break;
			}
		}
		if(!flag)motnhs[motnhs.length]=create_month;
	}
	
	var hl = "&nbsp;&nbsp;&nbsp;";
	for(var x = 0 ;x<motnhs.length;x++){
		hl += "<button class='btn btn-primary' onclick='clickbyyearandmonth("+year+","+motnhs[x]+")' >"+year+"年"+parseInt(motnhs[x])+"月</button>&nbsp;";
	} 
	$('#history_month').html(hl);
	
}

function clickbyyearandmonth(year,month){
	$('#history_select').html("("+year+"年"+month+"月)");
	var bitchinfos = [];
	for(var i = 0;i<history_data.total;i++){
		var batchInfo = history_data.rows[i].batchInfo;
		var batch_year = batchInfo.createtime.split("-")[0];
		var batch_month = parseInt(batchInfo.createtime.split("-")[1]);
		if(batch_year==year&&batch_month==month){
			bitchinfos[bitchinfos.length] = batchInfo;
		}
	}
	var hl = "&nbsp;&nbsp;&nbsp;";
	for(var j = 0;j<bitchinfos.length;j++){
		var batchInfo = bitchinfos[j];
		hl += "<button class='btn btn-primary' onclick='clickbybitch("+batchInfo.id+",this)' t='"+batchInfo.createtime+"' n='"+batchInfo.batchname+"' >"+batchInfo.batchname+"</button>&nbsp;";
	}
	$('#history_batchinfo').html(hl);
}

function clickbybitch(id,o){
	var time = $(o).attr("t");
	var name = $(o).attr("n");
	$('#history_select').html("("+time.split("-")[0]+"年"+time.split("-")[1]+"月:"+name+")");
	$('#table_history_ritire_row').attr('style','display:block;');
	
	batchinfo_id = id;
	batchinfo_name= name;
	var o={};
	o.page = hs_thispage;
	o.rows = hs_pagerows;
	o.batchinfo_id = id;
	queryretireinfo_hs(o);
}


function queryretireinfo_hs(o){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/queryretireinfo.action",
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
					$('#trtbody').html("");
					$('#hs_button_page').html("<font color='red'>无符合条件的记录。。。</font>");
					$('#hs_total_pages').html("");
				}else{
					$('#trtbody').html("");
					var tr = '';
					var state_info = ["<font color='grey'>激活</font>","<font color='green'>已完成</font>","<font color='red'>未完成</font>"];
					for(var c = 0;c <data.rows.length;c++){
						
						var retireInfo = data.rows[c].retireInfo;
						var sex = retireInfo.sex==1?"男":"女";
						
						tr+='<tr xc="hsen" rid="'+retireInfo.id+'"  >'+
						    '<td>'+(retireInfo.retirebatchno==null?'未分配':retireInfo.retirebatchno)+'</td><td>'+retireInfo.fileno+'</td><td>'+retireInfo.name+'</td><td>'+sex+'</td><td>'+(retireInfo.birthday.split(" ")[0].split("-")[0]+'年'+retireInfo.birthday.split(" ")[0].split("-")[1]+'月')+'</td><td>'+retireInfo.workspace+'</td><td>'+retireInfo.mobileno+'</td><td>'+retireInfo.paperno+'</td><td>'+state_info[retireInfo.state]+'</td><td>'+retireInfo.remark+'</td>';
//						
					}
					pages = (parseInt(data.total/pagerows))+(parseInt(data.total)%pagerows==0?0:1);
					//tr+="<tr ><td></td><td>共"+pages+"页，"+data.total+"条数据。。。</td><td><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage'>"+thispage+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-highlight' id='next_page'>下一页</button></td>";
					$('#trtbody').html(tr);
					$('#hs_total_pages').html("共"+pages+"页，"+data.total+"条数据。。。");
					$('#hs_button_page').html("<button class='btn btn-highlight' id='hs_pre_page'>上一页</button><font color='red' id = 'hs_thispage' style='padding:0 5px;'>"+hs_thispage+"</font><button class='btn btn-highlight' id='hs_next_page'>下一页</button>");
				}
			}
			$('#content').smsLoaded();
		}
	});
}

$('#addnewretireinfo').die('click').live('click',function(){
	$.ajax({
		url:Q.url+"/html/model/addretireinfo.jsp",
		dataType:'text',
		data:{"bitchinfo_id":batchinfo_id,"batchname":batchinfo_name},
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	})
})

$('#hs_pre_page').die('click').live('click',function(){
	if(hs_thispage>1){
		hs_thispage--;
		var o={};
		o.page = hs_thispage;
		o.rows = hs_pagerows;
		o.batchinfo_id = batchinfo_id;
		queryretireinfo_hs(o);
	}else{
		Q.alert("提示","当前已是第一页");
	}
})

$('#hs_next_page').die('click').live('click',function(){
	if(hs_thispage<pages){
		hs_thispage++;
		var o={};
		o.page = hs_thispage;
		o.rows = hs_pagerows;
		o.batchinfo_id = batchinfo_id;
		queryretireinfo_hs(o);
	}else{
		Q.alert("提示","当前已是最后一页");
	}
})

$('#trtbody tr[xc="hsen"]').die('dblclick').live('dblclick',function(){
	var rid = $(this).attr("rid");
	$.ajax({
		url:Q.url+"/html/model/editretireinfo.jsp?rid="+rid+"&f=h",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
})


$('#outport').die('click').live('click',function(){
	if(batchinfo_id==0){
		Q.alert("提示","请先新建一个批次");
		return;
	}
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/outportretireinfo.action",
		data:{"batchinfo_id":batchinfo_id},
		success: function(data){
			if(typeof(data)=='object'){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.op=='success'){
					$('#openexcel').attr('href',Q.url+"/excel/retireinfo_excel.xls");//.css({"display":"block"}).text("点我").click();
					//window.open(Q.url+"/excel/cus_excel.xls");
					$('#exporttext').click();
				}
			}
			$('#content').smsLoaded();
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