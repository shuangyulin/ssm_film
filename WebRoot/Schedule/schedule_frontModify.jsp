<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Schedule" %>
<%@ page import="com.chengxusheji.po.Movie" %>
<%@ page import="com.chengxusheji.po.MovieHall" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的movieObj信息
    List<Movie> movieList = (List<Movie>)request.getAttribute("movieList");
    //获取所有的hallObj信息
    List<MovieHall> movieHallList = (List<MovieHall>)request.getAttribute("movieHallList");
    Schedule schedule = (Schedule)request.getAttribute("schedule");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改档期计划信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">档期计划信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="scheduleEditForm" id="scheduleEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="schedule_scheduleId_edit" class="col-md-3 text-right">档期id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="schedule_scheduleId_edit" name="schedule.scheduleId" class="form-control" placeholder="请输入档期id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="schedule_movieObj_movieId_edit" class="col-md-3 text-right">电影:</label>
		  	 <div class="col-md-9">
			    <select id="schedule_movieObj_movieId_edit" name="schedule.movieObj.movieId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schedule_hallObj_movieHallId_edit" class="col-md-3 text-right">播放影厅:</label>
		  	 <div class="col-md-9">
			    <select id="schedule_hallObj_movieHallId_edit" name="schedule.hallObj.movieHallId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schedule_scheduleDate_edit" class="col-md-3 text-right">放映日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date schedule_scheduleDate_edit col-md-12" data-link-field="schedule_scheduleDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="schedule_scheduleDate_edit" name="schedule.scheduleDate" size="16" type="text" value="" placeholder="请选择放映日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schedule_scheduleTime_edit" class="col-md-3 text-right">放映时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="schedule_scheduleTime_edit" name="schedule.scheduleTime" class="form-control" placeholder="请输入放映时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxScheduleModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#scheduleEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改档期计划界面并初始化数据*/
function scheduleEdit(scheduleId) {
	$.ajax({
		url :  basePath + "Schedule/" + scheduleId + "/update",
		type : "get",
		dataType: "json",
		success : function (schedule, response, status) {
			if (schedule) {
				$("#schedule_scheduleId_edit").val(schedule.scheduleId);
				$.ajax({
					url: basePath + "Movie/listAll",
					type: "get",
					success: function(movies,response,status) { 
						$("#schedule_movieObj_movieId_edit").empty();
						var html="";
		        		$(movies).each(function(i,movie){
		        			html += "<option value='" + movie.movieId + "'>" + movie.movieName + "</option>";
		        		});
		        		$("#schedule_movieObj_movieId_edit").html(html);
		        		$("#schedule_movieObj_movieId_edit").val(schedule.movieObjPri);
					}
				});
				$.ajax({
					url: basePath + "MovieHall/listAll",
					type: "get",
					success: function(movieHalls,response,status) { 
						$("#schedule_hallObj_movieHallId_edit").empty();
						var html="";
		        		$(movieHalls).each(function(i,movieHall){
		        			html += "<option value='" + movieHall.movieHallId + "'>" + movieHall.movieHallName + "</option>";
		        		});
		        		$("#schedule_hallObj_movieHallId_edit").html(html);
		        		$("#schedule_hallObj_movieHallId_edit").val(schedule.hallObjPri);
					}
				});
				$("#schedule_scheduleDate_edit").val(schedule.scheduleDate);
				$("#schedule_scheduleTime_edit").val(schedule.scheduleTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交档期计划信息表单给服务器端修改*/
function ajaxScheduleModify() {
	$.ajax({
		url :  basePath + "Schedule/" + $("#schedule_scheduleId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scheduleEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#scheduleQueryForm").submit();
            }else{
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
    /*放映日期组件*/
    $('.schedule_scheduleDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    scheduleEdit("<%=request.getParameter("scheduleId")%>");
 })
 </script> 
</body>
</html>

