<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Movie" %>
<%@ page import="com.chengxusheji.po.MovieHall" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>档期计划添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Schedule/frontlist">档期计划列表</a></li>
			    	<li role="presentation" class="active"><a href="#scheduleAdd" aria-controls="scheduleAdd" role="tab" data-toggle="tab">添加档期计划</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="scheduleList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="scheduleAdd"> 
				      	<form class="form-horizontal" name="scheduleAddForm" id="scheduleAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="schedule_movieObj_movieId" class="col-md-2 text-right">电影:</label>
						  	 <div class="col-md-8">
							    <select id="schedule_movieObj_movieId" name="schedule.movieObj.movieId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="schedule_hallObj_movieHallId" class="col-md-2 text-right">播放影厅:</label>
						  	 <div class="col-md-8">
							    <select id="schedule_hallObj_movieHallId" name="schedule.hallObj.movieHallId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="schedule_scheduleDateDiv" class="col-md-2 text-right">放映日期:</label>
						  	 <div class="col-md-8">
				                <div id="schedule_scheduleDateDiv" class="input-group date schedule_scheduleDate col-md-12" data-link-field="schedule_scheduleDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="schedule_scheduleDate" name="schedule.scheduleDate" size="16" type="text" value="" placeholder="请选择放映日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="schedule_scheduleTime" class="col-md-2 text-right">放映时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="schedule_scheduleTime" name="schedule.scheduleTime" class="form-control" placeholder="请输入放映时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxScheduleAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#scheduleAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加档期计划信息
	function ajaxScheduleAdd() { 
		//提交之前先验证表单
		$("#scheduleAddForm").data('bootstrapValidator').validate();
		if(!$("#scheduleAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Schedule/add",
			dataType : "json" , 
			data: new FormData($("#scheduleAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#scheduleAddForm").find("input").val("");
					$("#scheduleAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证档期计划添加表单字段
	$('#scheduleAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"schedule.scheduleDate": {
				validators: {
					notEmpty: {
						message: "放映日期不能为空",
					}
				}
			},
			"schedule.scheduleTime": {
				validators: {
					notEmpty: {
						message: "放映时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化电影下拉框值 
	$.ajax({
		url: basePath + "Movie/listAll",
		type: "get",
		success: function(movies,response,status) { 
			$("#schedule_movieObj_movieId").empty();
			var html="";
    		$(movies).each(function(i,movie){
    			html += "<option value='" + movie.movieId + "'>" + movie.movieName + "</option>";
    		});
    		$("#schedule_movieObj_movieId").html(html);
    	}
	});
	//初始化播放影厅下拉框值 
	$.ajax({
		url: basePath + "MovieHall/listAll",
		type: "get",
		success: function(movieHalls,response,status) { 
			$("#schedule_hallObj_movieHallId").empty();
			var html="";
    		$(movieHalls).each(function(i,movieHall){
    			html += "<option value='" + movieHall.movieHallId + "'>" + movieHall.movieHallName + "</option>";
    		});
    		$("#schedule_hallObj_movieHallId").html(html);
    	}
	});
	//放映日期组件
	$('#schedule_scheduleDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#scheduleAddForm').data('bootstrapValidator').updateStatus('schedule.scheduleDate', 'NOT_VALIDATED',null).validateField('schedule.scheduleDate');
	});
})
</script>
</body>
</html>
