var movie_manage_tool = null; 
$(function () { 
	initMovieManageTool(); //建立Movie管理对象
	movie_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#movie_manage").datagrid({
		url : 'Movie/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "movieId",
		sortOrder : "desc",
		toolbar : "#movie_manage_tool",
		columns : [[
			{
				field : "movieId",
				title : "影片id",
				width : 70,
			},
			{
				field : "movieName",
				title : "影片名称",
				width : 140,
			},
			{
				field : "movieType",
				title : "影片类型",
				width : 140,
			},
			{
				field : "moviePhoto",
				title : "影片图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "director",
				title : "导演",
				width : 140,
			},
			{
				field : "mainPerformer",
				title : "主演",
				width : 140,
			},
			{
				field : "duration",
				title : "时长",
				width : 140,
			},
			{
				field : "area",
				title : "地区",
				width : 140,
			},
			{
				field : "releaseDate",
				title : "上映日期",
				width : 140,
			},
			{
				field : "price",
				title : "票价",
				width : 70,
			},
		]],
	});

	$("#movieEditDiv").dialog({
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
				if ($("#movieEditForm").form("validate")) {
					//验证表单 
					if(!$("#movieEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#movieEditForm").form({
						    url:"Movie/" + $("#movie_movieId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#movieEditForm").form("validate"))  {
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
			                        $("#movieEditDiv").dialog("close");
			                        movie_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#movieEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#movieEditDiv").dialog("close");
				$("#movieEditForm").form("reset"); 
			},
		}],
	});
});

function initMovieManageTool() {
	movie_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#movie_manage").datagrid("reload");
		},
		redo : function () {
			$("#movie_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#movie_manage").datagrid("options").queryParams;
			queryParams["movieName"] = $("#movieName").val();
			queryParams["movieType"] = $("#movieType").val();
			queryParams["director"] = $("#director").val();
			queryParams["area"] = $("#area").val();
			queryParams["releaseDate"] = $("#releaseDate").datebox("getValue"); 
			$("#movie_manage").datagrid("options").queryParams=queryParams; 
			$("#movie_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#movieQueryForm").form({
			    url:"Movie/OutToExcel",
			});
			//提交表单
			$("#movieQueryForm").submit();
		},
		remove : function () {
			var rows = $("#movie_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var movieIds = [];
						for (var i = 0; i < rows.length; i ++) {
							movieIds.push(rows[i].movieId);
						}
						$.ajax({
							type : "POST",
							url : "Movie/deletes",
							data : {
								movieIds : movieIds.join(","),
							},
							beforeSend : function () {
								$("#movie_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#movie_manage").datagrid("loaded");
									$("#movie_manage").datagrid("load");
									$("#movie_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#movie_manage").datagrid("loaded");
									$("#movie_manage").datagrid("load");
									$("#movie_manage").datagrid("unselectAll");
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
			var rows = $("#movie_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Movie/" + rows[0].movieId +  "/update",
					type : "get",
					data : {
						//movieId : rows[0].movieId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (movie, response, status) {
						$.messager.progress("close");
						if (movie) { 
							$("#movieEditDiv").dialog("open");
							$("#movie_movieId_edit").val(movie.movieId);
							$("#movie_movieId_edit").validatebox({
								required : true,
								missingMessage : "请输入影片id",
								editable: false
							});
							$("#movie_movieName_edit").val(movie.movieName);
							$("#movie_movieName_edit").validatebox({
								required : true,
								missingMessage : "请输入影片名称",
							});
							$("#movie_movieType_edit").val(movie.movieType);
							$("#movie_movieType_edit").validatebox({
								required : true,
								missingMessage : "请输入影片类型",
							});
							$("#movie_moviePhoto").val(movie.moviePhoto);
							$("#movie_moviePhotoImg").attr("src", movie.moviePhoto);
							$("#movie_director_edit").val(movie.director);
							$("#movie_director_edit").validatebox({
								required : true,
								missingMessage : "请输入导演",
							});
							$("#movie_mainPerformer_edit").val(movie.mainPerformer);
							$("#movie_mainPerformer_edit").validatebox({
								required : true,
								missingMessage : "请输入主演",
							});
							$("#movie_duration_edit").val(movie.duration);
							$("#movie_duration_edit").validatebox({
								required : true,
								missingMessage : "请输入时长",
							});
							$("#movie_area_edit").val(movie.area);
							$("#movie_area_edit").validatebox({
								required : true,
								missingMessage : "请输入地区",
							});
							$("#movie_releaseDate_edit").datebox({
								value: movie.releaseDate,
							    required: true,
							    showSeconds: true,
							});
							$("#movie_price_edit").val(movie.price);
							$("#movie_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入票价",
								invalidMessage : "票价输入不对",
							});
							$("#movie_opera_edit").val(movie.opera);
							$("#movie_opera_edit").validatebox({
								required : true,
								missingMessage : "请输入剧情",
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
