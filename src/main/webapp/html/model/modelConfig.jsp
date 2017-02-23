<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<form action="" style=""></form>
	<table id="modelConfigTable"></table>
</div>
<!-- 
1、列出所有表的表名

2、选择一个表再选择该表的一个列 加入到显示列

3、确定进入下一步

4、选择一个表作为主表

5、设置该表的列显示类型

6、确定进入下一步

7、选择要作为查询的字段

8、确定结束
 -->
<script>
$('#modelConfigTable').grid({
	title:'表名列表',
	onClick:function(row){
		console.log(row);
	},
	cols:[{field:"name",text:"表名"}
		],
	btns:[{text:"新增",click:function(){
		console.log($('#modelConfigTable').getSelected());
	}}]
});

$.ajax({
	url:Q.url+"/model/findTables.action",
	success:function(data){
		$('#modelConfigTable').loadData(data);
	}
});
</script>