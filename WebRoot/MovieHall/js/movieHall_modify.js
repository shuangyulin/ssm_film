$(function () {
	$.ajax({
		url : "MovieHall/" + $("#movieHall_movieHallId_edit").val() + "/update",
		type : "get",
		data : {
			//movieHallId : $("#movieHall_movieHallId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (movieHall, response, status) {
			$.messager.progress("close");
			if (movieHall) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#movieHallModifyButton").click(function(){ 
		if ($("#movieHallEditForm").form("validate")) {
			$("#movieHallEditForm").form({
			    url:"MovieHall/" +  $("#movieHall_movieHallId_edit").val() + "/update",
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
			$("#movieHallEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
