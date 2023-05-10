<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.MovieHall" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    MovieHall movieHall = (MovieHall)request.getAttribute("movieHall");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改影厅信息</TITLE>
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
  		<li class="active">影厅信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="movieHallEditForm" id="movieHallEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="movieHall_movieHallId_edit" class="col-md-3 text-right">影厅id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="movieHall_movieHallId_edit" name="movieHall.movieHallId" class="form-control" placeholder="请输入影厅id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="movieHall_movieHallName_edit" class="col-md-3 text-right">影厅名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieHall_movieHallName_edit" name="movieHall.movieHallName" class="form-control" placeholder="请输入影厅名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieHall_rows_edit" class="col-md-3 text-right">座位排数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieHall_rows_edit" name="movieHall.rows" class="form-control" placeholder="请输入座位排数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movieHall_cols_edit" class="col-md-3 text-right">座位列数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movieHall_cols_edit" name="movieHall.cols" class="form-control" placeholder="请输入座位列数">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxMovieHallModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#movieHallEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改影厅界面并初始化数据*/
function movieHallEdit(movieHallId) {
	$.ajax({
		url :  basePath + "MovieHall/" + movieHallId + "/update",
		type : "get",
		dataType: "json",
		success : function (movieHall, response, status) {
			if (movieHall) {
				$("#movieHall_movieHallId_edit").val(movieHall.movieHallId);
				$("#movieHall_movieHallName_edit").val(movieHall.movieHallName);
				$("#movieHall_rows_edit").val(movieHall.rows);
				$("#movieHall_cols_edit").val(movieHall.cols);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交影厅信息表单给服务器端修改*/
function ajaxMovieHallModify() {
	$.ajax({
		url :  basePath + "MovieHall/" + $("#movieHall_movieHallId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#movieHallEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "MovieHall/frontlist";
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
    movieHallEdit("<%=request.getParameter("movieHallId")%>");
 })
 </script> 
</body>
</html>

