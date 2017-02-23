<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8" id="h2_html">订餐</h2>
			
		</div>
	</div>
</div>
<div id="index_content" >
日期：<input type="text" id="time_start" class="span2" style="height:20px;width:80px;" data-date-format="yyyy-mm-dd" readonly>
 &nbsp;&nbsp;&nbsp;<select id="timetype"><option value="1" selected>午餐</option><option value="2">晚餐</option></select>
	 &nbsp;&nbsp;&nbsp;<button class="btn btn-primary" id = "querydataparse">确定</button>&nbsp;&nbsp; 
    				
<div class="row" id="table_status_row">

	<div class="span12">
		<h3 id="hqd"></h3>
		<table class="table table-hover">
			<thead>
				<tr>
				<th>员工</th>
					<th>操作</th>
					
				</tr>
			</thead>
			<tbody  id= "tbody">
			</tbody>
			
		</table>
		<div class="modal-footer" id="bandwx-footer">  
    <button class="btn btn-primary" id="savehottopic">确定</button>
 </div> 
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
$("#time_start").val(enddate.getFullYear()+"-"+mm+"-"+dd);

function condition(){
	var o = {};
	o.time = $("#time_start").val();
	o.type = $('#timetype').val();
	
	if(o.type==1)$('#hqd').html('<font color="blue">'+o.time+'</font>'+'<font color="red">午餐</font>订餐列表');
	else if(o.type==2)$('#hqd').html('<font color="blue">'+o.time+'</font>'+'<font color="red">晚餐</font>订餐列表');
	
	return o;
}

queryuser(condition());
function queryuser(x){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/queryuser4dinner.action",
//		data:{"page":thispage,"rows":pagerows},
		data:x,
		success: function(data){
			if(typeof(data)=='object'){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.total==0){
					$('#tbody').html("");
					
				}else{
					$('#tbody').html("");
					var tr = '';
					
					for(var c = 0;c <data.rows.length;c++){
						
						var dinner = data.rows[c];
						if(dinner.dinner==0){
							tr+='<tr xc="en" rid="'+dinner.userinfoid+'"  >'+
						    '<td>'+dinner.name+'</td><td><input type="checkbox" name="dinner" value="'+dinner.userinfoid+'" /></td></tr>';
						}else if(dinner.dinner==1){
							tr+='<tr xc="en" rid="'+dinner.userinfoid+'"  >'+
						    '<td>'+dinner.name+'</td><td><input type="checkbox" name="dinner" value="'+dinner.userinfoid+'" checked="checked"  /></td></tr>';
						}
						
					}
					//tr+="<tr ><td></td><td>共"+pages+"页，"+data.total+"条数据。。。</td><td><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage'>"+thispage+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-highlight' id='next_page'>下一页</button></td>";
					$('#tbody').html(tr);
					
				}
			}
			$('#content').smsLoaded();
		}
	});
}

$('#querydataparse').die('click').live('click',function(){
	queryuser(condition());
});



$('#savehottopic').die('click').live('click',function(){
	var userinfoids = "";
	$('input:checkbox[name="dinner"]:checked').each(function() { 
	    //if ($(this).attr('checked')) { 
	    	userinfoids += $(this).val()+","; 
	    //} 
	}); 
	//alert(userinfoids);
	userinfoids = userinfoids.substring(0,userinfoids.length-1);
	
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/saveuserinfo4dinner.action",
		data:{"type":$('#timetype').val(),"time":$("#time_start").val(),"userinfoids":userinfoids},
		success: function(data){
			if(data.op=='success'){
				Q.alert('提示','操作成功');
			}else{
				Q.alert('提示','操作失败');
			}
			$('#content').smsLoaded();
		}
	})
})



</script>