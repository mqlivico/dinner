<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="pub_batch_index_win">
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<br>
<label class="control-label" for="peopletype">批次:</label>
<div class="controls">
<select  type="text" id="batchinfo_sel" >
<!-- <option value="1" selected="selected">正常退休 </option>
<option value="2">特殊工种退休  </option> -->
</select>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" id="pub_batch_index_ok">确定</button>
</div>

</div>
<script>
var rid = '<%=request.getParameter("rid")%>';
var fm = '<%=request.getParameter("fm")%>';
$.ajax({
	url: Q.url+"/model/querynewbatch.action",
	data:{},
	success: function(data){
		if( typeof(data) == 'object'  ){
			if(data.op=='timeout' ){
				location.reload();
				return;
			}
			var options = '';
			if(data.total==0){
				
			}else{
				$('#batchinfo_sel').html(options);
				for(var i = 0;i<data.total;i++){
					var batchInfo = data.rows[i].batchInfo;
					if(i==0)
						options +='<option value="'+batchInfo.id+'" selected="selected">'+batchInfo.batchname+'</option>';
					else
						options +='<option value="'+batchInfo.id+'">'+batchInfo.batchname+' </option>';
				}
				
				$('#batchinfo_sel').html(options);
				
			}
		}
	}
});


$('#pub_batch_index_ok').die('click').live('click',function(){
	$.ajax({
		url: Q.url+"/model/changebatch.action",
		data:{"id":rid,"batchId":$('#batchinfo_sel').val()},
		success: function(data){
			if( typeof(data) == 'object'  ){
				if(data.op=='timeout' ){
					location.reload();
					return;
				}
				
				if(data.op=='success' ){
					Q.alert("提示","操作成功");
					if(fm=='add'){
						$('#rtbtno').html(data.retirebatchno);
						var bn = '<button class="btn btn-primary" onclick="printa('+rid+')">打印《退休条件审批表》</button>'+
				    	'<button class="btn btn-primary" onclick="printb('+rid+')">打印《随县离退休人员登记表》</button>'+
				    	'<button class="btn btn-primary" onclick="printc('+rid+')">打印《退休证领取凭条》</button>'+
				    	'<button class="btn btn-green" onclick="returnbef()">返回</button>';
						$('#addretiresucessed-footer').html(bn);
					}
					$('#pub_batch_index_win').window('destroy');
				}else{
					Q.alert("提示","操作失败");
				}
			}else{
				Q.alert("提示","操作失败");
			}
			
		}
	});
})

$('#pub_batch_index_win').window({
	title:'选择批次',
	width:450,
	height:120,
	onClose:function(){
		$('#pub_batch_index_win').window('destroy');
	}
});
</script>