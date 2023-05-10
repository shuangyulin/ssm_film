$(function () {
	$("#comment_movieObj_movieId").combobox({
	    url:'Movie/listAll',
	    valueField: "movieId",
	    textField: "movieName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#comment_movieObj_movieId").combobox("getData"); 
            if (data.length > 0) {
                $("#comment_movieObj_movieId").combobox("select", data[0].movieId);
            }
        }
	});
	$("#comment_content").validatebox({
		required : true, 
		missingMessage : '请输入影评内容',
	});

	$("#comment_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#comment_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#comment_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#commentAddButton").click(function () {
		//验证表单 
		if(!$("#commentAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#commentAddForm").form({
			    url:"Comment/add",
			    onSubmit: function(){
					if($("#commentAddForm").form("validate"))  { 
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
                        $("#commentAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#commentAddForm").submit();
		}
	});

	//单击清空按钮
	$("#commentClearButton").click(function () { 
		$("#commentAddForm").form("clear"); 
	});
});
