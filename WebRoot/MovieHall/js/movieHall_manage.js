var movieHall_manage_tool = null; 
$(function () { 
	initMovieHallManageTool(); //建立MovieHall管理对象
	movieHall_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#movieHall_manage").datagrid({
		url : 'MovieHall/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "movieHallId",
		sortOrder : "desc",
		toolbar : "#movieHall_manage_tool",
		columns : [[
			{
				field : "movieHallId",
				title : "影厅id",
				width : 70,
			},
			{
				field : "movieHallName",
				title : "影厅名称",
				width : 140,
			},
			{
				field : "rows",
				title : "座位排数",
				width : 70,
			},
			{
				field : "cols",
				title : "座位列数",
				width : 70,
			},
		]],
	});

	$("#movieHallEditDiv").dialog({
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
				if ($("#movieHallEditForm").form("validate")) {
					//验证表单 
					if(!$("#movieHallEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#movieHallEditForm").form({
						    url:"MovieHall/" + $("#movieHall_movieHallId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#movieHallEditForm").form("validate"))  {
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
			                        $("#movieHallEditDiv").dialog("close");
			                        movieHall_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#movieHallEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#movieHallEditDiv").dialog("close");
				$("#movieHallEditForm").form("reset"); 
			},
		}],
	});
});

function initMovieHallManageTool() {
	movieHall_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#movieHall_manage").datagrid("reload");
		},
		redo : function () {
			$("#movieHall_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#movieHall_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#movieHallQueryForm").form({
			    url:"MovieHall/OutToExcel",
			});
			//提交表单
			$("#movieHallQueryForm").submit();
		},
		remove : function () {
			var rows = $("#movieHall_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var movieHallIds = [];
						for (var i = 0; i < rows.length; i ++) {
							movieHallIds.push(rows[i].movieHallId);
						}
						$.ajax({
							type : "POST",
							url : "MovieHall/deletes",
							data : {
								movieHallIds : movieHallIds.join(","),
							},
							beforeSend : function () {
								$("#movieHall_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#movieHall_manage").datagrid("loaded");
									$("#movieHall_manage").datagrid("load");
									$("#movieHall_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#movieHall_manage").datagrid("loaded");
									$("#movieHall_manage").datagrid("load");
									$("#movieHall_manage").datagrid("unselectAll");
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
			var rows = $("#movieHall_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "MovieHall/" + rows[0].movieHallId +  "/update",
					type : "get",
					data : {
						//movieHallId : rows[0].movieHallId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (movieHall, response, status) {
						$.messager.progress("close");
						if (movieHall) { 
							$("#movieHallEditDiv").dialog("open");
							$("#movieHall_movieHallId_edit").val(movieHall.movieHallId);
							$("#movieHall_movieHallId_edit").validatebox({
								required : true,
								missingMessage : "请输入影厅id",
								editable: false
							});
							$("#movieHall_movieHallName_edit").val(movieHall.movieHallName);
							$("#movieHall_movieHallName_edit").validatebox({
								required : true,
								missingMessage : "请输入影厅名称",
							});
							$("#movieHall_rows_edit").val(movieHall.rows);
							$("#movieHall_rows_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入座位排数",
								invalidMessage : "座位排数输入不对",
							});
							$("#movieHall_cols_edit").val(movieHall.cols);
							$("#movieHall_cols_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入座位列数",
								invalidMessage : "座位列数输入不对",
							});
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
