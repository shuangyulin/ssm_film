$(function () {
	$("#movie_movieName").validatebox({
		required : true, 
		missingMessage : '请输入影片名称',
	});

	$("#movie_movieType").validatebox({
		required : true, 
		missingMessage : '请输入影片类型',
	});

	$("#movie_director").validatebox({
		required : true, 
		missingMessage : '请输入导演',
	});

	$("#movie_mainPerformer").validatebox({
		required : true, 
		missingMessage : '请输入主演',
	});

	$("#movie_duration").validatebox({
		required : true, 
		missingMessage : '请输入时长',
	});

	$("#movie_area").validatebox({
		required : true, 
		missingMessage : '请输入地区',
	});

	$("#movie_releaseDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#movie_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入票价',
		invalidMessage : '票价输入不对',
	});

	$("#movie_opera").validatebox({
		required : true, 
		missingMessage : '请输入剧情',
	});

	//单击添加按钮
	$("#movieAddButton").click(function () {
		//验证表单 
		if(!$("#movieAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#movieAddForm").form({
			    url:"Movie/add",
			    onSubmit: function(){
					if($("#movieAddForm").form("validate"))  { 
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
                        $("#movieAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#movieAddForm").submit();
		}
	});

	//单击清空按钮
	$("#movieClearButton").click(function () { 
		$("#movieAddForm").form("clear"); 
	});
});
