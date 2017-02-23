<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8"><font id="newbatchname"></font>退休申报信息<font id="stateinfo" size="3"></font></h2>
			
		</div>
	</div>
</div>
 
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<div class="control-group" id="bfandaf"></div> <hr>
<div class="control-group">
<input type="hidden" id="batchinfoId" value="0">
<input type="hidden" id="retireinfoId" value="0">
<label class="control-label" for="fileno">档案号:</label>
<div class="controls">
<input  type="text" id="fileno" >
</div><br>

<label class="control-label" for="name">姓名:</label>
<div class="controls">
<input  type="text" id="name" >
</div><br>

<label class="control-label" for="appid">性别:</label>
<div class="controls">
<input type="radio" name="optionsRadios" id="sex1" value="1" checked="checked">男
<input type="radio" name="optionsRadios" id="sex2" value="2">女
</div><br>

<label class="control-label" for="workspace">单位:</label>
<div class="controls">
<input  type="text" id="workspace" >
</div><br>

<label class="control-label" for="birthday">出生日期:</label>
<div class="controls">
<!-- <input type="text" id="birthday" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="birthday_year" style="width:50px;">年<input style="width:50px;" type="text" id="birthday_month">月
</div><br>

<label class="control-label" for="jobtime">参加工作时间:</label>
<div class="controls">
<!-- <input type="text" id="jobtime" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="jobtime_year" style="width:50px;">年<input style="width:50px;" type="text" id="jobtime_month">月
</div><br>

<label class="control-label" for="insurancetime">参保时间:</label>
<div class="controls">
<!-- <input type="text" id="insurancetime" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="insurancetime_year" style="width:50px;">年<input style="width:50px;" type="text" id="insurancetime_month">月
</div><br>

<label class="control-label" for="paymentendtime">缴费截止时间:</label>
<div class="controls">
<!-- <input type="text" id="paymentendtime" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="paymentendtime_year" style="width:50px;">年<input style="width:50px;" type="text" id="paymentendtime_month">月
</div><br>

<label class="control-label" for="retiretime">退休时间:</label>
<div class="controls">
<!-- <input type="text" id="retiretime" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="retiretime_year" style="width:50px;">年<input style="width:50px;" type="text" id="retiretime_month">月
</div><br>

<label class="control-label" for="retireno">社保编号:</label>
<div class="controls">
<input  type="text" id="retireno" >
</div><br>

<label class="control-label" for="paperno">身份证号:</label>
<div class="controls">
<input  type="text" id="paperno" >
</div><br>

<label class="control-label" for="peopletype">人员类别:</label>
<div class="controls">
<select  type="text" id="peopletype" >
<!-- 1正常退休 2特殊工种退休 3因病退休 4退职 5军转干部退休 6农工 7民师 8城镇集体 -->
<option value="1" selected="selected">正常退休 </option>
<option value="2">特殊工种退休  </option>
<option value="3">因病退休 </option>
<option value="4">退职 </option>
<option value="5">军转干部退休 </option>
<option value="6">农工 </option>
<option value="7">民师</option>
<option value="8">城镇集体 </option>
</select>
</div>
<hr>
参加工作后的主要工作经历<br><br>
<label class="control-label" for="workhistory"></label>
<div class="controls">
<!-- <input type="text" id="starttime1" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="starttime1_year" style="width:50px;">年<input style="width:50px;" type="text" id="starttime1_month">月到
<!-- <input type="text" id="endtime1" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="endtime1_year" style="width:50px;">年<input style="width:50px;" type="text" id="endtime1_month">月在
<input  type="text" id="workdesc1" ></div><br>
<label class="control-label" for="workhistory"></label>
<div class="controls">
<!-- <input type="text" id="starttime2" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="starttime2_year" style="width:50px;">年<input style="width:50px;" type="text" id="starttime2_month">月到
<!-- <input type="text" id="endtime2" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="endtime2_year" style="width:50px;">年<input style="width:50px;" type="text" id="endtime2_month">月在
<input  type="text" id="workdesc2" ></div><br>
<label class="control-label" for="workhistory"></label>
<div class="controls">
<!-- <input type="text" id="starttime3" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="starttime3_year" style="width:50px;">年<input style="width:50px;" type="text" id="starttime3_month">月到
<!-- <input type="text" id="endtime3" class="span2" style="height:20px;" data-date-format="yyyy-mm-dd" readonly> -->
<input  type="text" id="endtime3_year" style="width:50px;">年<input style="width:50px;" type="text" id="endtime3_month">月在
<input  type="text" id="workdesc3" ></div><br>
<hr>
<label class="control-label" for="mobileno">联系电话:</label>
<div class="controls">
<input  type="text" id="mobileno" >
</div><br>

<label class="control-label" for="address">离休后住址:</label>
<div class="controls">
<input  type="text" id="address" >
</div><br>

<label class="control-label" for="remark">备注:</label>
<div class="controls">
<textArea  type="text" id="remark" ></textArea>
</div>
<hr>
</div>
<div class="modal-footer" id="editretire-footer">  
    <button class="btn btn-primary" id="editretireinfo">修改</button>
    <button class="btn btn-primary" id="delretireinfo">删除</button>
    <button class="btn btn-primary" id="overretireinfo">办理已完成</button>
    <button class="btn btn-primary" id="notoverretireinfo">办理未完成</button>
    <button class="btn btn-primary" id="printa">打印《退休条件审批表》</button>
    <button class="btn btn-primary" id="printb">打印《随县离退休人员登记表》</button>
    <button class="btn btn-primary" id="printc">打印《退休证领取凭条》</button>
     <button class="btn btn-green" id="returnbef">返回</button>
 </div> 
 <div id="select_batch_div"></div>
<script>
var rid = '<%=request.getParameter("rid")%>';

var f = '<%=request.getParameter("f")%>';

if(f=='w'){
	$('#editretire-footer').html('<button class="btn btn-primary" id="editretireinfo">修改</button><button class="btn btn-primary" id="delretireinfo">删除</button><button class="btn btn-primary" id="changebatch">转入</button><button class="btn btn-green" id="returnbef">返回</button>');
}

$('#content').smsLoading();
$.ajax({
	url: Q.url+"/model/queryretireById.action",
	data:{"rid":rid},
	success: function(data){
		if( typeof(data) == 'object'  ){
			if(data.op=='timeout' ){
				location.reload();
				return;
			}
			if(data.total>0){
				data = data.rows[0].retireInfo;
				$('#batchinfoId').val(data.batchinfoId);
				$('#retireinfoId').val(rid);
				$('#fileno').val(data.fileno);
				$('#name').val(data.name);
				$('#newbatchname').html(data.name+"的")
				$('#workspace').val(data.workspace);
				$('#birthday_year').val(data.birthday.split(" ")[0].split("-")[0]);
				$('#birthday_month').val(data.birthday.split(" ")[0].split("-")[1]);
				$('#jobtime_year').val(data.jobtime.split(" ")[0].split("-")[0]);
				$('#jobtime_month').val(data.jobtime.split(" ")[0].split("-")[1]);
				$('#insurancetime_year').val(data.insurancetime.split(" ")[0].split("-")[0]);
				$('#insurancetime_month').val(data.insurancetime.split(" ")[0].split("-")[1]);
				$('#paymentendtime_year').val(data.paymentendtime.split(" ")[0].split("-")[0]);
				$('#paymentendtime_month').val(data.paymentendtime.split(" ")[0].split("-")[1]);
				$('#retiretime_year').val(data.retiretime.split(" ")[0].split("-")[0]);
				$('#retiretime_month').val(data.retiretime.split(" ")[0].split("-")[1]);
				$('#retireno').val(data.retireno);
				$('#paperno').val(data.paperno);
				$('#mobileno').val(data.mobileno);
				$('#address').val(data.address);
				$('#remark').val(data.remark);
				$("input[name='optionsRadios'][value="+data.sex+"]").attr("checked",true);
				$('#peopletype').val(data.peopletype);
				
				var jobtime = data.jobtime;
				var insurancetime = data.insurancetime;
				var retiretime = data.retiretime;
				
				var before96 = 0;
				if(parseInt(jobtime.split(" ")[0].split("-")[0])<1996){//参加工作在96年之后的不计算
					var insurancetime_year = insurancetime.split(" ")[0].split("-")[0];
					var insurancetime_month = insurancetime.split(" ")[0].split("-")[1];
					before96 = (1996-insurancetime_year-1)*12+(12-parseInt(insurancetime_month)+1);
				}
				
				var after96 = 0;
				if(parseInt(retiretime.split(" ")[0].split("-")[0])>=1996){//退休在96年之前的不计算
					var retiretime_year = retiretime.split(" ")[0].split("-")[0];
					var retiretime_month = retiretime.split(" ")[0].split("-")[1];
					after96 = (retiretime_year-1996)*12+parseInt(retiretime_month);
				}
				
				$('#bfandaf').html('注:96年前应缴费'+before96+'个月,96年后应缴费'+after96+'个月');
				
				if(data.state==2){
					$('#stateinfo').html('(办理未完成)');
					$('#editretire-footer').html('<button class="btn btn-primary" id="editretireinfo">修改</button><button class="btn btn-primary" id="delretireinfo">删除</button><button class="btn btn-primary" id="changebatch">转入</button><button class="btn btn-green" id="returnbef">返回</button>');
				}else if(data.state==1){
					$('#stateinfo').html('(办理已完成)');
					$('#overretireinfo').attr('style','display:none');
					$('#notoverretireinfo').attr('style','display:none');
				}
				
				$.ajax({
					url: Q.url+"/model/queryworkhistoryById.action",
					data:{"rid":rid},
					success: function(d){
						for(var i= 1 ;i<=d.total;i++){
							var workHistory = d.rows[i-1].workHistory;
							$('#starttime'+i+'_year').val(workHistory.starttimeYear);
							$('#starttime'+i+'_month').val(workHistory.starttimeMonth);
							$('#endtime'+i+'_year').val(workHistory.endtimeYear);
							$('#endtime'+i+'_month').val(workHistory.endtimeMonth);
							$('#workdesc'+i).val(workHistory.workdesc);
						}
					}
				})
				
			}
			
		}
		$('#content').smsLoaded();
	}
});
 
 

$('#returnbef').die('click').live('click',function(){
	if(f=='h'){
		$.ajax({
			url:Q.url+"/html/model/historyinfo.jsp",
			dataType:'text',
			success:function(html){
				$("#content").attr("style","display:block;");
				$("#content").html(html);
			}
		}) 
	}else if(f=='w'){
		$.ajax({
			url:Q.url+"/html/model/retireinfo.jsp",
			dataType:'text',
			data:{"state":"wwc"},
			success:function(html){
				$("#content").attr("style","display:block;");
				$("#content").html(html);
			}
		}) 
	}else{
		$.ajax({
			url:Q.url+"/html/model/retireinfo.jsp",
			dataType:'text',
			success:function(html){
				$("#content").attr("style","display:block;");
				$("#content").html(html);
			}
		}) 
	}
})
 
 $('#changebatch').die('click').live('click',function(){
	 $('#select_batch_div').load(Q.url+'/html/dialog/changebatch.jsp?rid='+rid);
 })
 
 
 $('#printa').die('click').live('click',function(){
	 window.open(Q.url+'/html/tuixiushenhe.html?id='+rid);
 })
 
 $('#printb').die('click').live('click',function(){
	 window.open(Q.url+'/html/lituixixin.html?id='+rid);
 })
 

 $('#printc').die('click').live('click',function(){
	 window.open(Q.url+'/html/lingqupingtiao.html?id='+rid);
 })
 
 $('#delretireinfo').die('click').live('click',function(){
	 $.messager.confirm('提示', '确定要删除此人的信息吗？', function(r){
			if (r){
				$('#content').smsLoading();
				$.ajax({
					url: Q.url+"/model/deltretireinfo.action",
					data:{"id":rid,"state":-1},
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
			}
		})
	})
 
	
	$('#overretireinfo').die('click').live('click',function(){
		$.messager.confirm('提示', '确定此人信息已申报完成吗？', function(r){
			if (r){
				$('#content').smsLoading();
				$.ajax({
					url: Q.url+"/model/deltretireinfo.action",
					data:{"id":rid,"state":1},
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
			}
		})
	})
		
		$('#notoverretireinfo').die('click').live('click',function(){
			$.messager.confirm('提示', '确定将此人信息转为申报未完成吗？', function(r){
				if (r){
					$('#content').smsLoading();
					$.ajax({
						url: Q.url+"/model/deltretireinfo.action",
						data:{"id":rid,"state":2},
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
				}
			})
		})

		
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