$(function () {
	$("#schedule_movieObj_movieId").combobox({
	    url:'Movie/listAll',
	    valueField: "movieId",
	    textField: "movieName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#schedule_movieObj_movieId").combobox("getData"); 
            if (data.length > 0) {
                $("#schedule_movieObj_movieId").combobox("select", data[0].movieId);
            }
        }
	});
	$("#schedule_hallObj_movieHallId").combobox({
	    url:'MovieHall/listAll',
	    valueField: "movieHallId",
	    textField: "movieHallName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#schedule_hallObj_movieHallId").combobox("getData"); 
            if (data.length > 0) {
                $("#schedule_hallObj_movieHallId").combobox("select", data[0].movieHallId);
            }
        }
	});
	$("#schedule_scheduleDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#schedule_scheduleTime").validatebox({
		required : true, 
		missingMessage : '请输入放映时间',
	});

	//单击添加按钮
	$("#scheduleAddButton").click(function () {
		//验证表单 
		if(!$("#scheduleAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#scheduleAddForm").form({
			    url:"Schedule/add",
			    onSubmit: function(){
					if($("#scheduleAddForm").form("validate"))  { 
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
                        $("#scheduleAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#scheduleAddForm").submit();
		}
	});

	//单击清空按钮
	$("#scheduleClearButton").click(function () { 
		$("#scheduleAddForm").form("clear"); 
	});
});
