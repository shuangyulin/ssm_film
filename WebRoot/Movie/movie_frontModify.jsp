<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Movie" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Movie movie = (Movie)request.getAttribute("movie");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改影片信息</TITLE>
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
  		<li class="active">影片信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="movieEditForm" id="movieEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="movie_movieId_edit" class="col-md-3 text-right">影片id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="movie_movieId_edit" name="movie.movieId" class="form-control" placeholder="请输入影片id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="movie_movieName_edit" class="col-md-3 text-right">影片名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_movieName_edit" name="movie.movieName" class="form-control" placeholder="请输入影片名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_movieType_edit" class="col-md-3 text-right">影片类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_movieType_edit" name="movie.movieType" class="form-control" placeholder="请输入影片类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_moviePhoto_edit" class="col-md-3 text-right">影片图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="movie_moviePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="movie_moviePhoto" name="movie.moviePhoto"/>
			    <input id="moviePhotoFile" name="moviePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_director_edit" class="col-md-3 text-right">导演:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_director_edit" name="movie.director" class="form-control" placeholder="请输入导演">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_mainPerformer_edit" class="col-md-3 text-right">主演:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_mainPerformer_edit" name="movie.mainPerformer" class="form-control" placeholder="请输入主演">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_duration_edit" class="col-md-3 text-right">时长:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_duration_edit" name="movie.duration" class="form-control" placeholder="请输入时长">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_area_edit" class="col-md-3 text-right">地区:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_area_edit" name="movie.area" class="form-control" placeholder="请输入地区">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_releaseDate_edit" class="col-md-3 text-right">上映日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date movie_releaseDate_edit col-md-12" data-link-field="movie_releaseDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="movie_releaseDate_edit" name="movie.releaseDate" size="16" type="text" value="" placeholder="请选择上映日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_price_edit" class="col-md-3 text-right">票价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="movie_price_edit" name="movie.price" class="form-control" placeholder="请输入票价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="movie_opera_edit" class="col-md-3 text-right">剧情:</label>
		  	 <div class="col-md-9">
			    <textarea id="movie_opera_edit" name="movie.opera" rows="8" class="form-control" placeholder="请输入剧情"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxMovieModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#movieEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改影片界面并初始化数据*/
function movieEdit(movieId) {
	$.ajax({
		url :  basePath + "Movie/" + movieId + "/update",
		type : "get",
		dataType: "json",
		success : function (movie, response, status) {
			if (movie) {
				$("#movie_movieId_edit").val(movie.movieId);
				$("#movie_movieName_edit").val(movie.movieName);
				$("#movie_movieType_edit").val(movie.movieType);
				$("#movie_moviePhoto").val(movie.moviePhoto);
				$("#movie_moviePhotoImg").attr("src", basePath +　movie.moviePhoto);
				$("#movie_director_edit").val(movie.director);
				$("#movie_mainPerformer_edit").val(movie.mainPerformer);
				$("#movie_duration_edit").val(movie.duration);
				$("#movie_area_edit").val(movie.area);
				$("#movie_releaseDate_edit").val(movie.releaseDate);
				$("#movie_price_edit").val(movie.price);
				$("#movie_opera_edit").val(movie.opera);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交影片信息表单给服务器端修改*/
function ajaxMovieModify() {
	$.ajax({
		url :  basePath + "Movie/" + $("#movie_movieId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#movieEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#movieQueryForm").submit();
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
    /*上映日期组件*/
    $('.movie_releaseDate_edit').datetimepicker({
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
    movieEdit("<%=request.getParameter("movieId")%>");
 })
 </script> 
</body>
</html>

