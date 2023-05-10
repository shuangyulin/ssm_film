$(function () {
	$("#movieOrder_scheduleObj_scheduleId").combobox({
	    url:'Schedule/listAll',
	    valueField: "scheduleId",
	    textField: "scheduleId",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#movieOrder_scheduleObj_scheduleId").combobox("getData"); 
            if (data.length > 0) {
                $("#movieOrder_scheduleObj_scheduleId").combobox("select", data[0].scheduleId);
            }
        }
	});
	$("#movieOrder_rowsIndex").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入座位行号',
		invalidMessage : '座位行号输入不对',
	});

	$("#movieOrder_cols").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入座位列号',
		invalidMessage : '座位列号输入不对',
	});

	$("#movieOrder_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入票价',
		invalidMessage : '票价输入不对',
	});

	$("#movieOrder_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#movieOrder_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#movieOrder_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#movieOrderAddButton").click(function () {
		//验证表单 
		if(!$("#movieOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#movieOrderAddForm").form({
			    url:"MovieOrder/add",
			    onSubmit: function(){
					if($("#movieOrderAddForm").form("validate"))  { 
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
                        $("#movieOrderAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#movieOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#movieOrderClearButton").click(function () { 
		$("#movieOrderAddForm").form("clear"); 
	});
});
