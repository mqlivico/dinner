/**
 * jqgrid格式化JSON日期
 * 调用formatDate详见date.js
 */
function gridDateFormat(cellValue){
	var newdate = "&nbsp;";
	if(cellValue)
		var newdate = formatDate(new Date(cellValue.time),"yyyy-MM-dd");
	return newdate;
}

function gridDateFormatUI(cellValue){
	
	var newdate = "&nbsp;";
	if(cellValue)
		var newdate = formatDate(Date.parseString(cellValue),"yyyy-MM-dd");
	return newdate;
}


function gridDatetimeFormat(cellValue){
	var newdate = "&nbsp;";
	if(cellValue)
		var newdate = formatDate(new Date(cellValue.time),"yyyy-MM-dd HH:mm:ss");
	return newdate;
}

function gridDateMonthFormat(cellValue){
	var newdate = "&nbsp;";
	if(cellValue)
		var newdate = formatDate(new Date(cellValue.time),"yyyy-MM");
	return newdate;
}

/**
 * 重置表单（此方法需jquery.form.js）
 * @param formId
 */
function reset(formId) {
  	$("#" + formId).resetForm();
}

/**
 * 清除表单（此方法需jquery.form.js）
 * @param formId
 */
function myClear(formId){
	$("#" + formId).clearForm();
}

function iniDatepicker(id){
	$('#' + id).datepicker({
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
		selectOtherMonths: true,
		rangeSelect: true
	});
}

/*  
 * 恒兴缘支付方式的格式化
 * */
function payMentWay(info){
	var payMentWay ="";
	if(info == 'AJ'){
		payMentWay = "按揭";
	}
	if(info == 'FQ'){
		payMentWay = "分期";
	}
	if(info == 'OT'){
		payMentWay = "一次性";
	}
	return payMentWay;
}

function state(info){
	
	var state ="";
	if(info == 'JH'){
		state = "激活";
	}
	if(info == 'HY'){
		state = "毁约";
	}
	if(info == 'ZF'){
		state = "作废";
	}
	if(info == 'FKWC'){
		state = "付款完成";
	}
	if(info == 'Expired'){
		state = "过期";
	}
	return state;
}

function checkState(info){
	
	var checkState ="";
	if(info == 'DSH'){
		checkState = "待审核";
	}
	if(info == 'TY'){
		checkState = "同意";
	}
	if(info == 'BTY'){
		checkState = "不同意";
	}
	if(info == 'CHECKINGADDED'){
		checkState = "新增待审核";
	}
	
	if(info == 'CHECKINGHY'){
		checkState = "毁约待审核";
	}
	if(info == 'JH'){
		checkState = "认筹退订待审核";
	}
	if(info == 'CHECKINCANCEL'){
		checkState = "认筹退订待审核";
	}
	if(info == 'CHECKINGTD'){
		checkState = "定购退定待审核";
	}
	if(info == 'CHECKINGADDFAIL'){
		checkState = "新增审核失败";
	}
	if(info == 'CHECKINGMODIFIED'){
		checkState = "修改待审核";
	}
	if(info == 'ZC'){
		checkState = "正常";
	}
	if(info == 'SHBTG'){
		checkState = "审核不通过";
	}
	if(info == 'YHP'){
		checkState = "已换票";
	}
	if(info == 'YSH'){
		checkState = "已审核";
	}
	if(info == 'SHSB'){
		checkState = "审核失败";
	}
	if(info == 'CHECKINGZHT'){
		checkState = "转合同待审核";
	}

	return checkState;
}


