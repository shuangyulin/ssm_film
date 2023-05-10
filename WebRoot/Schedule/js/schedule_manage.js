var schedule_manage_tool = null; 
$(function () { 
	initScheduleManageTool(); //建立Schedule管理对象
	schedule_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#schedule_manage").datagrid({
		url : 'Schedule/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "scheduleId",
		sortOrder : "desc",
		toolbar : "#schedule_manage_tool",
		columns : [[
			{
				field : "scheduleId",
				title : "档期id",
				width : 70,
			},
			{
				field : "movieObj",
				title : "电影",
				width : 140,
			},
			{
				field : "hallObj",
				title : "播放影厅",
				width : 140,
			},
			{
				field : "scheduleDate",
				title : "放映日期",
				width : 140,
			},
			{
				field : "scheduleTime",
				title : "放映时间",
				width : 140,
			},
		]],
	});

	$("#scheduleEditDiv").dialog({
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
				if ($("#scheduleEditForm").form("validate")) {
					//验证表单 
					if(!$("#scheduleEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#scheduleEditForm").form({
						    url:"Schedule/" + $("#schedule_scheduleId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#scheduleEditForm").form("validate"))  {
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
			                        $("#scheduleEditDiv").dialog("close");
			                        schedule_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#scheduleEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#scheduleEditDiv").dialog("close");
				$("#scheduleEditForm").form("reset"); 
			},
		}],
	});
});

function initScheduleManageTool() {
	schedule_manage_tool = {
		init: function() {
			$.ajax({
				url : "Movie/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#movieObj_movieId_query").combobox({ 
					    valueField:"movieId",
					    textField:"movieName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{movieId:0,movieName:"不限制"});
					$("#movieObj_movieId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "MovieHall/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#hallObj_movieHallId_query").combobox({ 
					    valueField:"movieHallId",
					    textField:"movieHallName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{movieHallId:0,movieHallName:"不限制"});
					$("#hallObj_movieHallId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#schedule_manage").datagrid("reload");
		},
		redo : function () {
			$("#schedule_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#schedule_manage").datagrid("options").queryParams;
			queryParams["movieObj.movieId"] = $("#movieObj_movieId_query").combobox("getValue");
			queryParams["hallObj.movieHallId"] = $("#hallObj_movieHallId_query").combobox("getValue");
			queryParams["scheduleDate"] = $("#scheduleDate").datebox("getValue"); 
			$("#schedule_manage").datagrid("options").queryParams=queryParams; 
			$("#schedule_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#scheduleQueryForm").form({
			    url:"Schedule/OutToExcel",
			});
			//提交表单
			$("#scheduleQueryForm").submit();
		},
		remove : function () {
			var rows = $("#schedule_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var scheduleIds = [];
						for (var i = 0; i < rows.length; i ++) {
							scheduleIds.push(rows[i].scheduleId);
						}
						$.ajax({
							type : "POST",
							url : "Schedule/deletes",
							data : {
								scheduleIds : scheduleIds.join(","),
							},
							beforeSend : function () {
								$("#schedule_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#schedule_manage").datagrid("loaded");
									$("#schedule_manage").datagrid("load");
									$("#schedule_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#schedule_manage").datagrid("loaded");
									$("#schedule_manage").datagrid("load");
									$("#schedule_manage").datagrid("unselectAll");
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
			var rows = $("#schedule_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Schedule/" + rows[0].scheduleId +  "/update",
					type : "get",
					data : {
						//scheduleId : rows[0].scheduleId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (schedule, response, status) {
						$.messager.progress("close");
						if (schedule) { 
							$("#scheduleEditDiv").dialog("open");
							$("#schedule_scheduleId_edit").val(schedule.scheduleId);
							$("#schedule_scheduleId_edit").validatebox({
								required : true,
								missingMessage : "请输入档期id",
								editable: false
							});
							$("#schedule_movieObj_movieId_edit").combobox({
								url:"Movie/listAll",
							    valueField:"movieId",
							    textField:"movieName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#schedule_movieObj_movieId_edit").combobox("select", schedule.movieObjPri);
									//var data = $("#schedule_movieObj_movieId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#schedule_movieObj_movieId_edit").combobox("select", data[0].movieId);
						            //}
								}
							});
							$("#schedule_hallObj_movieHallId_edit").combobox({
								url:"MovieHall/listAll",
							    valueField:"movieHallId",
							    textField:"movieHallName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#schedule_hallObj_movieHallId_edit").combobox("select", schedule.hallObjPri);
									//var data = $("#schedule_hallObj_movieHallId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#schedule_hallObj_movieHallId_edit").combobox("select", data[0].movieHallId);
						            //}
								}
							});
							$("#schedule_scheduleDate_edit").datebox({
								value: schedule.scheduleDate,
							    required: true,
							    showSeconds: true,
							});
							$("#schedule_scheduleTime_edit").val(schedule.scheduleTime);
							$("#schedule_scheduleTime_edit").validatebox({
								required : true,
								missingMessage : "请输入放映时间",
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
