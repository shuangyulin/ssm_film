var movieOrder_manage_tool = null; 
$(function () { 
	initMovieOrderManageTool(); //建立MovieOrder管理对象
	movieOrder_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#movieOrder_manage").datagrid({
		url : 'MovieOrder/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "orderId",
		sortOrder : "desc",
		toolbar : "#movieOrder_manage_tool",
		columns : [[
			{
				field : "orderId",
				title : "订票id",
				width : 70,
			},
			{
				field : "scheduleObj",
				title : "档期",
				width : 140,
			},
			{
				field : "rowsIndex",
				title : "座位行号",
				width : 70,
			},
			{
				field : "cols",
				title : "座位列号",
				width : 70,
			},
			{
				field : "price",
				title : "票价",
				width : 70,
			},
			{
				field : "userObj",
				title : "用户",
				width : 140,
			},
			{
				field : "orderTime",
				title : "预定时间",
				width : 140,
			},
		]],
	});

	$("#movieOrderEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#movieOrderEditForm").form("validate")) {
					//验证表单 
					if(!$("#movieOrderEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#movieOrderEditForm").form({
						    url:"MovieOrder/" + $("#movieOrder_orderId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#movieOrderEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#movieOrderEditDiv").dialog("close");
			                        movieOrder_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#movieOrderEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#movieOrderEditDiv").dialog("close");
				$("#movieOrderEditForm").form("reset"); 
			},
		}],
	});
});

function initMovieOrderManageTool() {
	movieOrder_manage_tool = {
		init: function() {
			$.ajax({
				url : "Schedule/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#scheduleObj_scheduleId_query").combobox({ 
					    valueField:"scheduleId",
					    textField:"scheduleId",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{scheduleId:0,scheduleId:"不限制"});
					$("#scheduleObj_scheduleId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#movieOrder_manage").datagrid("reload");
		},
		redo : function () {
			$("#movieOrder_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#movieOrder_manage").datagrid("options").queryParams;
			queryParams["scheduleObj.scheduleId"] = $("#scheduleObj_scheduleId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["orderTime"] = $("#orderTime").val();
			$("#movieOrder_manage").datagrid("options").queryParams=queryParams; 
			$("#movieOrder_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#movieOrderQueryForm").form({
			    url:"MovieOrder/OutToExcel",
			});
			//提交表单
			$("#movieOrderQueryForm").submit();
		},
		remove : function () {
			var rows = $("#movieOrder_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var orderIds = [];
						for (var i = 0; i < rows.length; i ++) {
							orderIds.push(rows[i].orderId);
						}
						$.ajax({
							type : "POST",
							url : "MovieOrder/deletes",
							data : {
								orderIds : orderIds.join(","),
							},
							beforeSend : function () {
								$("#movieOrder_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#movieOrder_manage").datagrid("loaded");
									$("#movieOrder_manage").datagrid("load");
									$("#movieOrder_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#movieOrder_manage").datagrid("loaded");
									$("#movieOrder_manage").datagrid("load");
									$("#movieOrder_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#movieOrder_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "MovieOrder/" + rows[0].orderId +  "/update",
					type : "get",
					data : {
						//orderId : rows[0].orderId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (movieOrder, response, status) {
						$.messager.progress("close");
						if (movieOrder) { 
							$("#movieOrderEditDiv").dialog("open");
							$("#movieOrder_orderId_edit").val(movieOrder.orderId);
							$("#movieOrder_orderId_edit").validatebox({
								required : true,
								missingMessage : "请输入订票id",
								editable: false
							});
							$("#movieOrder_scheduleObj_scheduleId_edit").combobox({
								url:"Schedule/listAll",
							    valueField:"scheduleId",
							    textField:"scheduleId",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#movieOrder_scheduleObj_scheduleId_edit").combobox("select", movieOrder.scheduleObjPri);
									//var data = $("#movieOrder_scheduleObj_scheduleId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#movieOrder_scheduleObj_scheduleId_edit").combobox("select", data[0].scheduleId);
						            //}
								}
							});
							$("#movieOrder_rowsIndex_edit").val(movieOrder.rowsIndex);
							$("#movieOrder_rowsIndex_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入座位行号",
								invalidMessage : "座位行号输入不对",
							});
							$("#movieOrder_cols_edit").val(movieOrder.cols);
							$("#movieOrder_cols_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入座位列号",
								invalidMessage : "座位列号输入不对",
							});
							$("#movieOrder_price_edit").val(movieOrder.price);
							$("#movieOrder_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入票价",
								invalidMessage : "票价输入不对",
							});
							$("#movieOrder_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#movieOrder_userObj_user_name_edit").combobox("select", movieOrder.userObjPri);
									//var data = $("#movieOrder_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#movieOrder_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#movieOrder_orderTime_edit").val(movieOrder.orderTime);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
