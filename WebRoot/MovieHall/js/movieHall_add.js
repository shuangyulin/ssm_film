$(function () {
	$("#movieHall_movieHallName").validatebox({
		required : true, 
		missingMessage : '请输入影厅名称',
	});

	$("#movieHall_rows").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入座位排数',
		invalidMessage : '座位排数输入不对',
	});

	$("#movieHall_cols").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入座位列数',
		invalidMessage : '座位列数输入不对',
	});

	//单击添加按钮
	$("#movieHallAddButton").click(function () {
		//验证表单 
		if(!$("#movieHallAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#movieHallAddForm").form({
			    url:"MovieHall/add",
			    onSubmit: function(){
					if($("#movieHallAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#movieHallAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#movieHallAddForm").submit();
		}
	});

	//单击清空按钮
	$("#movieHallClearButton").click(function () { 
		$("#movieHallAddForm").form("clear"); 
	});
});
