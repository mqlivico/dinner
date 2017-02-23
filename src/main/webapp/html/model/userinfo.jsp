<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="index" class="row title">
	<div class="span12">
		<div class="row">
			<h2 class="span8" id="h2_html">员工信息</h2>
			
		</div>
	</div>
</div>
<div id="index_content" >

<div class="row" id="table_status_row">

	<div class="span12">
		<h3 id="hqd">员工列表</h3>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>姓名</th>
					<th>操作</th>
				
					
				</tr>
			</thead>
			<tbody  id= "tbody">
			</tbody>
			
		</table>
	</div><hr>
	<div class="modal-footer" id="bandwx-footer">  
    <button class="btn btn-primary" id="adduser">新增</button>
 </div>
</div>
</div>
<script>
queryuser();
function queryuser(){
	$('#content').smsLoading();
	$.ajax({
		url: Q.url+"/model/queryuser.action",
//		data:{"page":thispage,"rows":pagerows},
		data:{},
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
						
						var userInfo = data.rows[c].userInfo;
						
						tr+='<tr xc="en" rid="'+userInfo.id+'"  >'+
						    '<td>'+userInfo.name+'</td><td><button uid="'+userInfo.id+'" class="btn btn-primary" onclick="deluser(this)">删除</button></td></tr>';
//						
					}
					//tr+="<tr ><td></td><td>共"+pages+"页，"+data.total+"条数据。。。</td><td><button class='btn btn-highlight' id='pre_page'>上一页</button><font color='red' id = 'thispage'>"+thispage+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-highlight' id='next_page'>下一页</button></td>";
					$('#tbody').html(tr);
					
				}
			}
			$('#content').smsLoaded();
		}
	});
}

$('#adduser').die('click').live('click',function(){
	 $.ajax({
			url:Q.url+"/html/model/adduser.jsp",
			dataType:'text',
			success:function(html){
				$("#content").attr("style","display:block;");
				$("#content").html(html);
			}
		}) 
})


/* function edituser(o){
	 var oid = $(o).attr("oid");
	$.ajax({
		url:Q.url+"/html/model/edituser.jsp?userId="+oid,
		dataType:'text',
		success:function(html){
			$("#content").attr("style","display:block;");
			$("#content").html(html);
		}
	}) 
} */

function deluser(o){
	var uid = $(o).attr("uid");
	$.messager.confirm('提示', '确认要删除此账号？', function(r){
		if (r){
			$.ajax({
				url: Q.url+"/model/deluser.action",
				data:{"uid":uid},
				success: function(data){
					if(data.op=='success'){
						Q.alert('提示','操作成功');
						queryuser();
					}else{
						Q.alert('提示','操作失败');
					}
					
				}
			});
		}
	})
}
</script>