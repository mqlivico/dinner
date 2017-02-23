<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="pub_import_excel_win">
<div class="form-horizontal" id="form_sp_model1" name="form_sp_model1"  method="POST"  enctype="multipart/form-data">
<br>
<label class="control-label" for="upload_excel_form">选择文件:</label>

<form id="upload_excel_form"  method="POST"  enctype="multipart/form-data"> 
<input class="" id="excel_file" type="file" name="filePath">
<input type = "submit"  id="import_excel_ok" value="导入" class="btn">
</form>



</div>
</div>
<script>
var bid = '<%=request.getParameter("bid")%>';

$('#upload_excel_form').form({
	url : Q.url + '/model/uploadexcel.action?bid='+bid,
	type:'post',
	dataType:'text',
    onSubmit: function(){  
    	return Ok_("#excel_file");
    },  
    success:function(data){
//    	if(typeof(data)=='object'){
//			if(data.op=='timeout' ){
//				location.reload();
//				return;
//			}
	    	Q.alert("提示","上传成功");
	    	$('#pub_import_excel_win').window('destroy');
	    	queryretireinfo(getCondition());
//    	}
	//	if($('#bussmodelID1').val()=="")$('#add_bussmodel_1').removeAttr("disabled");
    }  
});

function Ok_(input_sp_modelID) {
	//验证都不为空
	cansubmit = true;

	if ($.trim($(input_sp_modelID).val()) == "") {
		msger("提示","请选择文件！");
		cansubmit = false;
	}
	
 	if ($.trim($(input_sp_modelID).val()) != "") {
		var file=$.trim($(input_sp_modelID).val());
		var filename=file.replace(/.*(\/|\\)/, "");
		var fileExt=(/[.]/.exec(filename)) ? /[^.]+$/.exec(filename.toLowerCase()) : '';
		if(fileExt!="xls"&&fileExt!="xlsx"){
			msger("提示","请选择xls、xlsx格式的文件");
			cansubmit = false;
		}
	}
 	
	return cansubmit;

}


$('#pub_import_excel_win').window({
	title:'导入excel',
	width:500,
	height:120,
	onClose:function(){
		$('#pub_import_excel_win').window('destroy');
	}
});
</script>