<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8">添加员工</h2>
			
		</div>
	</div>
</div>
 
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<div class="control-group">

<label class="control-label" for="name">姓名:</label>
<div class="controls">
<input  type="text" id="name" >
</div>
<hr>
</div>
<div class="modal-footer" id="bandwx-footer">  
	<button class="btn" id="returnbf" onclick = "returnbef()">返回</button>
    <button class="btn btn-primary" id="savenewuser">保存</button>
 </div>  

<script>


$('#savenewuser').die('click').live('click',function(){
	var user = {};
	
	var name = $('#name').val();
	if(name==null||$.trim(name).length==0){
		Q.alert("提示","请输入姓名");
		return;
	}
	user.name = name;
	

	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/adduser.action",
		data:user,
		success: function(data){
			if( typeof(data) == 'object'  ){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.op=='success' ){
					Q.alert("提示","操作成功");
					
				}else if(data.op=='-4000' ){
					Q.alert("提示","员工已存在");
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

function returnbef(){
	$.ajax({
		url:Q.url+"/html/model/userinfo.jsp",
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
}


</script>