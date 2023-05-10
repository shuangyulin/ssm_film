$(function () {
	$.ajax({
		url : "Schedule/" + $("#schedule_scheduleId_edit").val() + "/update",
		type : "get",
		data : {
			//scheduleId : $("#schedule_scheduleId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (schedule, response, status) {
			$.messager.progress("close");
			if (schedule) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#scheduleModifyButton").click(function(){ 
		if ($("#scheduleEditForm").form("validate")) {
			$("#scheduleEditForm").form({
			    url:"Schedule/" +  $("#schedule_scheduleId_edit").val() + "/update",
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
			$("#scheduleEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
