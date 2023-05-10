<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.MovieOrder" %>
<%@ page import="com.chengxusheji.po.Schedule" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的scheduleObj信息
    List<Schedule> scheduleList = (List<Schedule>)request.getAttribute("scheduleList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    MovieOrder movieOrder = (MovieOrder)request.getAttribute("movieOrder");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改订票信息</TITLE>
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
  		<li class="active">订票信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="movieOrderEditForm" id="movieOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="movieOrder_orderId_edit" class="col-md-3 text-right">订票id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="movieOrder_orderId_edit" name="movieOrder.orderId" class="form-control" placeholder="请输入订票id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="movieOrder_scheduleObj_scheduleId_edit" class="col-md-3 text-right">档期:</label>
		  	 <div class="col-md-9">
			    <select id="movieOrder_scheduleObj_scheduleId_edit" name="movieOrder.scheduleObj.scheduleId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieOrder_rowsIndex_edit" class="col-md-3 text-right">座位行号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieOrder_rowsIndex_edit" name="movieOrder.rowsIndex" class="form-control" placeholder="请输入座位行号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieOrder_cols_edit" class="col-md-3 text-right">座位列号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieOrder_cols_edit" name="movieOrder.cols" class="form-control" placeholder="请输入座位列号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieOrder_price_edit" class="col-md-3 text-right">票价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieOrder_price_edit" name="movieOrder.price" class="form-control" placeholder="请输入票价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieOrder_userObj_user_name_edit" class="col-md-3 text-right">用户:</label>
		  	 <div class="col-md-9">
			    <select id="movieOrder_userObj_user_name_edit" name="movieOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieOrder_orderTime_edit" class="col-md-3 text-right">预定时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieOrder_orderTime_edit" name="movieOrder.orderTime" class="form-control" placeholder="请输入预定时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxMovieOrderModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#movieOrderEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改订票界面并初始化数据*/
function movieOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "MovieOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (movieOrder, response, status) {
			if (movieOrder) {
				$("#movieOrder_orderId_edit").val(movieOrder.orderId);
				$.ajax({
					url: basePath + "Schedule/listAll",
					type: "get",
					success: function(schedules,response,status) { 
						$("#movieOrder_scheduleObj_scheduleId_edit").empty();
						var html="";
		        		$(schedules).each(function(i,schedule){
		        			html += "<option value='" + schedule.scheduleId + "'>" + schedule.scheduleId + "</option>";
		        		});
		        		$("#movieOrder_scheduleObj_scheduleId_edit").html(html);
		        		$("#movieOrder_scheduleObj_scheduleId_edit").val(movieOrder.scheduleObjPri);
					}
				});
				$("#movieOrder_rowsIndex_edit").val(movieOrder.rowsIndex);
				$("#movieOrder_cols_edit").val(movieOrder.cols);
				$("#movieOrder_price_edit").val(movieOrder.price);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#movieOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#movieOrder_userObj_user_name_edit").html(html);
		        		$("#movieOrder_userObj_user_name_edit").val(movieOrder.userObjPri);
					}
				});
				$("#movieOrder_orderTime_edit").val(movieOrder.orderTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交订票信息表单给服务器端修改*/
function ajaxMovieOrderModify() {
	$.ajax({
		url :  basePath + "MovieOrder/" + $("#movieOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#movieOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#movieOrderQueryForm").submit();
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
    movieOrderEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

