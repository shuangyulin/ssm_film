$(function () {
	$.ajax({
		url : "MovieOrder/" + $("#movieOrder_orderId_edit").val() + "/update",
		type : "get",
		data : {
			//orderId : $("#movieOrder_orderId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (movieOrder, response, status) {
			$.messager.progress("close");
			if (movieOrder) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#movieOrderModifyButton").click(function(){ 
		if ($("#movieOrderEditForm").form("validate")) {
			$("#movieOrderEditForm").form({
			    url:"MovieOrder/" +  $("#movieOrder_orderId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#movieOrderEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
