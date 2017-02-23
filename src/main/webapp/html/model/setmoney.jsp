<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8">设置餐费</h2>
			
		</div>
	</div>
</div>
 
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<div class="control-group"></div> 
<div class="control-group">


<label class="control-label" for="">月份:</label>
<div class="controls">
<input  type="text" id="year_set" style="width:50px;">年
<input  type="text" id="month_set" style="width:50px;">月
</div><br>
<label class="control-label" for="totalmoney">总餐费:</label>
<div class="controls">
<input  type="text" id="totalmoney" >
</div>
<hr>
</div>
<div class="modal-footer" id="bandwx-footer">  
    <button class="btn btn-primary" id="saveset">保存</button>
 </div>  
 <hr>
 
<script>

/* $.ajax({
	url: Q.url+"/model/querywxband.action",
	data:{},
	success: function(data){
		if( typeof(data) == 'object'  ){
			if(data.op=='timeout' ){
				location.reload();
				return;
			}
			
			if(data.total==0){
				$('#url').val(data.url);
				$('#token').val(data.token);
			}else{
				var groupproperty = data.rows[0].groupPropperty;
				$('#groupwxconfId').val(groupproperty.id);
				$('#url').val(groupproperty.url);
				$('#token').val(groupproperty.token);
				$('#appid').val(groupproperty.appid);
				$('#appsecret').val(groupproperty.appsecret);
				$('#sorce_id').val(groupproperty.sorceid);
			}
		}
	}
});
 */
var now = new Date();
var year = now.getFullYear();
var month = now.getMonth()+1;

//$('#batchno_prefix').val(year+""+month);
 
$('#saveset').die('click').live('click',function(){
	var o = {};
	
	var year = $('#year_set').val();
	if(year==null||$.trim(year).length==0){
		Q.alert("提示","请输入年份");
		return;
	}
	o.year = $.trim(year);
	
	
	var month = $('#month_set').val();
	if(month==null||$.trim(month).length==0){
		Q.alert("提示","请输入年份");
		return;
	}
	o.month = $.trim(month);
	
	var totalmoney = $('#totalmoney').val();
	if(totalmoney==null||$.trim(totalmoney).length==0){
		Q.alert("提示","填写金额");
		return;
	}
	o.totalmoney = totalmoney;
	
	
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/addset.action",
		data:o,
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



</script>