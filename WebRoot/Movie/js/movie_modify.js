$(function () {
	$.ajax({
		url : "Movie/" + $("#movie_movieId_edit").val() + "/update",
		type : "get",
		data : {
			//movieId : $("#movie_movieId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (movie, response, status) {
			$.messager.progress("close");
			if (movie) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#movieModifyButton").click(function(){ 
		if ($("#movieEditForm").form("validate")) {
			$("#movieEditForm").form({
			    url:"Movie/" +  $("#movie_movieId_edit").val() + "/update",
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
			$("#movieEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
