<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8"><font id="newbatchname"></font>订单详情<font id="stateinfo" size="3"></font></h2>
			
		</div>
	</div>
</div>
 
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<!-- <div class="control-group" id="bfandaf"></div> <hr> -->
<div class="control-group">
<input type="hidden" id="orderinfoId" value="0">
<label class="control-label" for="customername">姓名:</label>
<div class="controls">
<input  type="text" id="customername" readonly>
</div><br>

<label class="control-label" for="mobile">手机:</label>
<div class="controls">
<input  type="text" id="mobile" readonly>
</div><br>




<label class="control-label" for="address">地址:</label>
<div class="controls">
<textArea  id="address" readonly></textArea>
</div><br>
<div id="imgmodel" style="display: none;">
<div  id="imageurl_div" style=""><img id="imgurl" src='' width="150px" height="150px"></div>
  <div style="position: absolute; top: 15%; left: 50%; z-index:1"><img id="model" src='' width="300px"></div>
</div>
<hr>
<label class="control-label" for="sendno">运单号:</label>
<div class="controls">
<input  type="text" id="sendno" >
</div><br>

<label class="control-label" for="server">跟踪客服:</label>
<div class="controls">
<input  type="text" id="server" >
</div><br>




<label class="control-label" for="remark">备注:</label>
<div class="controls">
<textArea  id="remark"></textArea>
</div><br>
<hr>
</div>

</div>

<div class="modal-footer" id="editretire-footer">  
<button class="btn btn-primary" id="addremark">更新备注</button>
<button class="btn btn-primary" id="invalided">无效订单</button>
<button class="btn btn-primary" id="over">已完成</button>
<button class="btn btn-primary" id="sended">已发货</button>
<button class="btn btn-primary" id="box">已包装</button>
<button class="btn btn-primary" id="printed">已打印</button>
    <button class="btn btn-primary" id="istodo">已确认</button>
    <button class="btn btn-primary" id="todoing">正在沟通</button>
     <button class="btn btn-green" id="returnbef">返回</button>
 </div> 
 <div id="select_batch_div"></div>

<script>
//0未处理 1正在沟通 2已确认 3已打印 4已包装 5已发货  6已完成  7无效订单

var rid = '<%=request.getParameter("rid")%>';

 var thispage = '<%=request.getParameter("thispage")%>';
/*
if(f=='w'){
	$('#editretire-footer').html('<button class="btn btn-primary" id="editretireinfo">修改</button><button class="btn btn-primary" id="delretireinfo">删除</button><button class="btn btn-primary" id="changebatch">转入</button><button class="btn btn-green" id="returnbef">返回</button>');
}*/
var stateinfo = ["<font color='red'>未处理</font>","正在沟通","已确认","已打印","已包装","<font color='blue'>已发货</font>","<font color='green'>已完成</font>","<font color='gray'>无效订单</font>"];
$('#content').smsLoading();
$.ajax({
	url: Q.url+"/model/queryorderById.action",
	data:{"rid":rid},
	success: function(data){
		if( typeof(data) == 'object'  ){
			if(data.op=='timeout' ){
				location.reload();
				return;
			}
			if(data.total>0){
				data = data.rows[0].yycusinfo;
				
				$('#orderinfoId').val(rid);
				$('#customername').val(data.customername);
				$('#mobile').val(data.mobile);
				$('#address').html(data.address)
				
				$('#sendno').val(data.sendno==null?"":data.sendno);
				$('#server').val(data.server==null?"":data.server);
				$('#remark').html(data.remark==null?"":data.remark)
				
				/* if(data.state==1){
					$('#istodo').attr('style','display:none;');
					$('#todoing').attr('style','display:none;');
				}else if(data.state==2){
					$('#todoing').attr('style','display:none;');
				} */
				
				$('#stateinfo').html("(当前状态为"+stateinfo[data.state]+")");
				
				$('#model').attr('src','../../forImg/images/'+data.model+'.png');
				if(data.model==1){
					$('#imageurl_div').attr('style','position: absolute; top: 16%; left: 54.8%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','196px;');
					$('#imgurl').attr('height','196px;');
				}else if(data.model==2){
					$('#imageurl_div').attr('style','position: absolute; top: 46%; left: 54.8%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','196px;');
					$('#imgurl').attr('height','196px;');
				}else if(data.model==3){
					$('#imageurl_div').attr('style','position: absolute; top: 22.2%; left: 55.5%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','180px;');
					$('#imgurl').attr('height','180px;');
				}else if(data.model==4){
					$('#imageurl_div').attr('style','position: absolute; top: 49.8%; left: 56.4%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','157px;');
					$('#imgurl').attr('height','157px;');
				}else if(data.model==5){
					$('#imageurl_div').attr('style','position: absolute; top: 41.9%; left: 56.3%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','157px;');
					$('#imgurl').attr('height','157px;');
				}else if(data.model==6){
					$('#imageurl_div').attr('style','position: absolute; top: 38.4%; left: 56.9%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','152px;');
					$('#imgurl').attr('height','152px;');
				}else if(data.model==7){
					$('#imageurl_div').attr('style','position: absolute; top: 37.1%; left: 57.6%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','122px;');
					$('#imgurl').attr('height','122px;');
				}else if(data.model==8){
					$('#imageurl_div').attr('style','position: absolute; top: 24.2%; left: 55.2%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','175px;');
					$('#imgurl').attr('height','175px;');
				}else if(data.model==9){
					$('#imageurl_div').attr('style','position: absolute; top: 41.2%; left: 57.9%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','122px;');
					$('#imgurl').attr('height','122px;');
				}else if(data.model==10){
					$('#imageurl_div').attr('style','position: absolute; top: 51.7%; left: 58.2%; z-index:2');
					$('#imgurl').attr('src','../../forImg/userimg/'+data.imageurl);
					$('#imgurl').attr('width','118px;');
					$('#imgurl').attr('height','118px;');
				}
				
				$('#imgmodel').attr('style','display:block');
			}
			
		}
		$('#content').smsLoaded();
	}
});
 
$('#addremark').die('click').live('click',function(){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/addremark.action",
		data:{"rid":rid,"sendno":$('#sendno').val(),"server":$('#server').val(),"remark":$('#remark').val()},
		success: function(data){
			if( typeof(data) == 'object'  ){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.op=='success' ){
					Q.alert("提示","操作成功");
				}else{
					Q.alert("提示","操作失败");
				}
			}else{
				Q.alert("提示","操作失败");
			}
			
			$('#content').smsLoaded();
		}
	});
})

$('#returnbef').die('click').live('click',function(){

	$.ajax({
		url:Q.url+"/html2/model/retireinfo.jsp",
		data:{'thispage':thispage},
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
	
})
 

$('#todoing').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为正在沟通吗？', function(r){
			if (r){
				changestate(1);
			}
		})
	})

 
 $('#istodo').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为已确认吗？', function(r){
			if (r){
				changestate(2);
			}
		})
	})
 
	
	
$('#printed').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为已打印吗？', function(r){
			if (r){
				changestate(3);
			}
		})
	})
	
$('#box').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为已包装吗？', function(r){
			if (r){
				changestate(4);
			}
		})
	})
	
$('#sended').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为已发货吗？', function(r){
			if (r){
				changestate(5);
			}
		})
	})
	
$('#over').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为已完成吗？', function(r){
			if (r){
				changestate(6);
			}
		})
	})

	

$('#invalided').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要将此订单标记为无效吗？', function(r){
			if (r){
				changestate(7);
			}
		})
	})
	
function changestate(s){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/istodo.action",
		data:{"id":rid,"state":s},
		success: function(data){
			if( typeof(data) == 'object'  ){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.op=='success' ){
					Q.alert("提示","操作成功");
					$('#stateinfo').html("(当前状态为"+stateinfo[s]+")");
				}else{
					Q.alert("提示","操作失败");
				}
			}else{
				Q.alert("提示","操作失败");
			}
			
			$('#content').smsLoaded();
		}
	});
}
	
	

		
//监控日期的键盘事件   开始-----------------------
$('#birthday_year').keyup(function(e){
	var k = e.keyCode;   //48-57是大键盘的数字键，96-105是小键盘的数字键，8是退格符←
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#birthday_year').val();
    	v = v.substring(0,v.length-1);
    	$('#birthday_year').val(v);
    }
   
    var v = $('#birthday_year').val();
    if(v.length>=4) {
    	if(v.length>4){
    		v = v.substring(0,4);
        	$('#birthday_year').val(v);
    	}
    	
    	$('#birthday_year').blur();
    	$('#birthday_month').focus();
    }
}) 


$('#birthday_month').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#birthday_month').val();
    	v = v.substring(0,v.length-1);
    	$('#birthday_month').val(v);
    }
   
    var v = $('#birthday_month').val();
    if(v.length>=2) {
    	if(v.length>2){
    		v = v.substring(0,2);
        	$('#birthday_month').val(v);
    	}
    	
    	$('#birthday_month').blur();
    	$('#jobtime_year').focus();
    }
}) 
 
$('#jobtime_year').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#jobtime_year').val();
    	v = v.substring(0,v.length-1);
    	$('#jobtime_year').val(v);
    }
   
    var v = $('#jobtime_year').val();
    if(v.length>=4) {
    	if(v.length>4){
    		v = v.substring(0,4);
        	$('#jobtime_year').val(v);
    	}
    	
    	$('#jobtime_year').blur();
    	$('#jobtime_month').focus();
    }
})  
 
$('#jobtime_month').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#jobtime_month').val();
    	v = v.substring(0,v.length-1);
    	$('#jobtime_month').val(v);
    }
   
    var v = $('#jobtime_month').val();
    if(v.length>=2) {
    	if(v.length>2){
    		v = v.substring(0,2);
        	$('#jobtime_month').val(v);
    	}
    	
    	$('#jobtime_month').blur();
    	$('#insurancetime_year').focus();
    }
}) 


$('#insurancetime_year').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#insurancetime_year').val();
    	v = v.substring(0,v.length-1);
    	$('#insurancetime_year').val(v);
    }
   
    var v = $('#insurancetime_year').val();
    if(v.length>=4) {
    	if(v.length>4){
    		v = v.substring(0,4);
        	$('#insurancetime_year').val(v);
    	}
    	
    	$('#insurancetime_year').blur();
    	$('#insurancetime_month').focus();
    }
}) 


$('#insurancetime_month').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#insurancetime_month').val();
    	v = v.substring(0,v.length-1);
    	$('#insurancetime_month').val(v);
    }
   
    var v = $('#insurancetime_month').val();
    if(v.length>=2) {
    	if(v.length>2){
    		v = v.substring(0,2);
        	$('#insurancetime_month').val(v);
    	}
    	
    	$('#insurancetime_month').blur();
    	$('#paymentendtime_year').focus();
    }
}) 

$('#paymentendtime_year').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#paymentendtime_year').val();
    	v = v.substring(0,v.length-1);
    	$('#paymentendtime_year').val(v);
    }
   
    var v = $('#paymentendtime_year').val();
    if(v.length>=4) {
    	if(v.length>4){
    		v = v.substring(0,4);
        	$('#paymentendtime_year').val(v);
    	}
    	
    	$('#paymentendtime_year').blur();
    	$('#paymentendtime_month').focus();
    }
}) 

$('#paymentendtime_month').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#paymentendtime_month').val();
    	v = v.substring(0,v.length-1);
    	$('#paymentendtime_month').val(v);
    }
   
    var v = $('#paymentendtime_month').val();
    if(v.length>=2) {
    	if(v.length>2){
    		v = v.substring(0,2);
        	$('#paymentendtime_month').val(v);
    	}
    	
    	$('#paymentendtime_month').blur();
    	$('#retiretime_year').focus();
    }
}) 


$('#retiretime_year').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#retiretime_year').val();
    	v = v.substring(0,v.length-1);
    	$('#retiretime_year').val(v);
    }
   
    var v = $('#retiretime_year').val();
    if(v.length>=4) {
    	if(v.length>4){
    		v = v.substring(0,4);
        	$('#retiretime_year').val(v);
    	}
    	
    	$('#retiretime_year').blur();
    	$('#retiretime_month').focus();
    }
}) 

$('#retiretime_month').keyup(function(e){
	var k = e.keyCode;   
    if ((k <= 57 && k >= 48) || (k <= 105 && k >= 96) || (k== 8)){
    	
    } else{
    	var v = $('#retiretime_month').val();
    	v = v.substring(0,v.length-1);
    	$('#retiretime_month').val(v);
    }
   
    var v = $('#retiretime_month').val();
    if(v.length>=2) {
    	if(v.length>2){
    		v = v.substring(0,2);
        	$('#retiretime_month').val(v);
    	}
    	
    	$('#retiretime_month').blur();
    	$('#retireno').focus();
    }
}) 
//监控日期的键盘事件   结束----------------------- 		
		
$('#editretireinfo').die('click').live('click',function(){
	var retireinfo = {};
	retireinfo.id = rid;
	var batchinfoId = $('#batchinfoId').val();
	if(batchinfoId==0||batchinfoId=="0"){
		Q.alert("提示","请先创建一个批次再进行信息录入");
		return;
	}
	
	var fileno = $('#fileno').val();
	if(fileno==null||$.trim(fileno).length==0){
		Q.alert("提示","请输入档案号");
		return;
	}
	retireinfo.fileno = fileno;
	
	var name = $('#name').val();
	if(name==null||$.trim(name).length==0){
		Q.alert("提示","请输入姓名");
		return;
	}
	retireinfo.name = name;
	
	
	var workspace = $('#workspace').val();
	if(workspace==null||$.trim(workspace).length==0){
		Q.alert("提示","请填写工作单位");
		return;
	}
	retireinfo.workspace = workspace;
	
	//出生日期
	var birthday_year = $('#birthday_year').val();
	
	var birthday_month = $('#birthday_month').val();
	
	var birthday = check4time(birthday_year,birthday_month,"出生日期");
	
	if(birthday=='')return;
	
	retireinfo.birthday = birthday;
	
	//参加工作时间
	var jobtime_year = $('#jobtime_year').val();
	
	var jobtime_month = $('#jobtime_month').val();
	
	var jobtime = check4time(jobtime_year,jobtime_month,"参加工作时间");
	
	if(jobtime=='')return;
	
	retireinfo.jobtime = jobtime;
	
	//参保时间
	var insurancetime_year = $('#insurancetime_year').val();
	var insurancetime_month = $('#insurancetime_month').val();
	
	var insurancetime = check4time(insurancetime_year,insurancetime_month,"参保时间");
	
	if(insurancetime=='')return;
	
	retireinfo.insurancetime = insurancetime;
	
	//缴费截止时间
	var paymentendtime_year = $('#paymentendtime_year').val();
	var paymentendtime_month = $('#paymentendtime_month').val();
	var paymentendtime = check4time(paymentendtime_year,paymentendtime_month,"缴费截止时间");
	
	if(paymentendtime=='')return;
	
	retireinfo.paymentendtime = paymentendtime;
	
	//退休时间
	var retiretime_year = $('#retiretime_year').val();
	var retiretime_month = $('#retiretime_month').val();
	var retiretime = check4time(retiretime_year,retiretime_month,"缴费截止时间");
	
	if(retiretime=='')return;
	
	retireinfo.retiretime = retiretime;
	
	
	var retireno = $('#retireno').val();
	if(retireno==null||$.trim(retireno).length==0){
		Q.alert("提示","请输入社保编号");
		return;
	}
	retireinfo.retireno = retireno;
	
	var paperno = $('#paperno').val();
	if(paperno==null||$.trim(paperno).length==0){
		Q.alert("提示","请输入身份证号");
		return;
	}
	
	var flag = checkpno(paperno);
	if(!flag)return;
	
	retireinfo.paperno = paperno;
	
	
	var mobileno = $('#mobileno').val();
	if(mobileno==null||$.trim(mobileno).length==0){
		Q.alert("提示","请输入联系电话");
		return;
	}
	
	retireinfo.mobileno = mobileno;
	
	
	var address = $('#address').val();
	if(address==null||$.trim(address).length==0){
		Q.alert("提示","请输入离休后的住址");
		return;
	}
	retireinfo.address = address;
	
	var remark = $('#remark').val();
	retireinfo.remark = remark;
	
	var optionsRadios = $("input[name='optionsRadios']:checked").val();
	retireinfo.sex = optionsRadios;
	retireinfo.peopletype = $('#peopletype').val();
	
	var arr = [];
	var workdesc1 =$('#workdesc1').val();
	var workdesc2 =$('#workdesc2').val();
	var workdesc3 =$('#workdesc3').val();
	if($.trim(workdesc1).length==0&&$.trim(workdesc2).length==0&&$.trim(workdesc3).length==0){
		Q.alert("提示","请至少填写一次工作经历");
		return;
	}
	
	if($.trim(workdesc1).length>0){
		/* if($('#starttime1').val()==''){
			Q.alert("提示","请为第一次工作经历选择起始时间");
			return;
		}
		if($('#endtime1').val()==''){
			Q.alert("提示","请为第一次工作经历选择截止时间");
			return;
		} */
		
		var xo = {};
		xo.workdesc = workdesc1;
		xo.starttime_year = $('#starttime1_year').val();
		xo.starttime_month = $('#starttime1_month').val();
		xo.endtime_year = $('#endtime1_year').val();
		xo.endtime_month = $('#endtime1_month').val();
		arr[arr.length] = xo;
	}
	
	if($.trim(workdesc2).length>0){
		/* if($('#starttime2').val()==''){
			Q.alert("提示","请为第二次工作经历选择起始时间");
			return;
		}
		if($('#endtime2').val()==''){
			Q.alert("提示","请为第二次工作经历选择截止时间");
			return;
		} */
		
		var xo = {};
		xo.workdesc = workdesc2;
		xo.starttime_year = $('#starttime2_year').val();
		xo.starttime_month = $('#starttime2_month').val();
		xo.endtime_year = $('#endtime2_year').val();
		xo.endtime_month = $('#endtime2_month').val();
		arr[arr.length] = xo;
	}
	
	if($.trim(workdesc3).length>0){
		/* if($('#starttime3').val()==''){
			Q.alert("提示","请为第三次工作经历选择起始时间");
			return;
		}
		if($('#endtime3').val()==''){
			Q.alert("提示","请为第三次工作经历选择截止时间");
			return;
		} */
		
		var xo = {};
		xo.workdesc = workdesc3;
		xo.starttime_year = $('#starttime3_year').val();
		xo.starttime_month = $('#starttime3_month').val();
		xo.endtime_year = $('#endtime3_year').val();
		xo.endtime_month = $('#endtime3_month').val();
		arr[arr.length] = xo;
	}
	
	retireinfo.workhistory = $.toJSON(arr);
	retireinfo.batchinfoId = batchinfoId;
	
	$.messager.confirm('提示', '确定要提交此修改的信息吗？', function(r){
		if (r){
			$('#content').smsLoading();
			$.ajax({
				url: Q.url+"/model/editretireinfo.action",
				data:retireinfo,
				success: function(data){
					if( typeof(data) == 'object'  ){
						if(data.op=='timeout' ){
							location.reload();
							return;
						}
						
						if(data.op=='success' ){
							Q.alert("提示","操作成功");
						}else if(data.op=='-4003' ){
							Q.alert("提示","档案号已存在，请重新输入");
						}else if(data.op=='-4004' ){
							Q.alert("提示","社保编号已存在，请重新输入");
						}else{
							Q.alert("提示","操作失败");
						}
					}else{
						Q.alert("提示","操作失败");
					}
					$('#content').smsLoaded();
				}
			});
		}
	})
})

function check4time(year,month,msg){
	if(year==null||$.trim(year).length==0){
		Q.alert("提示","请填写"+msg+"的年份");
		return '';
	}
	
	if(month==null||$.trim(month).length==0){
		Q.alert("提示","请填写"+msg+"的月份");
		return '';
	}
	
	var patt_n = /^\d+$/;
	
	if(year.length!=4||!patt_n.test(year)){
		Q.alert("提示",msg+"请填写正确的年份");
		return '';
	}
	
	
	if(month.length>2||month==0||month>12||month=="00"||!patt_n.test(month)){
		Q.alert("提示",msg+"请填写正确的月份");
		return '';
	}
	
	var xtime = $.trim(year)+"-"+($.trim(month).length==1?"0"+$.trim(month):$.trim(month))+"-01";
	//alert(xtime);
	return xtime;
}

/* $('#birthday').datepicker({
	startDate: "1900-01-01",
	endDate: "0d",
	language: "cn",
	showOtherMonths:false,
	autoclose: "true"
});

 
 $('#jobtime').datepicker({
		startDate: "1900-01-01",
		endDate: "0d", 
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});

 
 $('#insurancetime').datepicker({
		startDate: "1900-01-01",
		endDate: "0d", 
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#paymentendtime').datepicker({
		startDate: "1900-01-01",
		endDate: "0d", 
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 
 $('#retiretime').datepicker({
		startDate: "1900-01-01",
		endDate: "0d", 
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#starttime1').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#starttime2').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#starttime3').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#endtime1').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#endtime2').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
 
 $('#endtime3').datepicker({
		startDate: "1900-01-01",
		endDate: "0d",  
		language: "cn",
		showOtherMonths:false,
		autoclose: "true"
	});
  */
 
 function checkpno(valu){
		valu = valu.toUpperCase();
		if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(valu))) {    
			Q.alert("提示",'身份证号不正确');   
			flag=false;
			return false;        
		}
			var len, re; 
			len = valu.length; 
			if (len == 15) {
	        re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/);
	        var arrSplit = valu.match(re);  
	        var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]);
	        var bGoodDay; bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
	        if (!bGoodDay) {        
	            Q.alert("提示",'输入的身份证号里出生日期不对！');     
	            flag = false;
	            return false;
	        } 
	    }
	    if (len == 18) {
	        re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
	        var arrSplit = valu.match(re); 
	        var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]);
	        var bGoodDay; bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
	        if (!bGoodDay) {
	            Q.alert("提示",'输入的身份证号里出生日期不对！');
	            flag = false;
	            return false;
	        }
	    }
	    return true;
	}
</script>