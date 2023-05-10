<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>影片添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Movie/frontlist">影片管理</a></li>
  			<li class="active">添加影片</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="movieAddForm" id="movieAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="movie_movieName" class="col-md-2 text-right">影片名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_movieName" name="movie.movieName" class="form-control" placeholder="请输入影片名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_movieType" class="col-md-2 text-right">影片类型:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_movieType" name="movie.movieType" class="form-control" placeholder="请输入影片类型">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_moviePhoto" class="col-md-2 text-right">影片图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="movie_moviePhotoImg" border="0px"/><br/>
					    <input type="hidden" id="movie_moviePhoto" name="movie.moviePhoto"/>
					    <input id="moviePhotoFile" name="moviePhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_director" class="col-md-2 text-right">导演:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_director" name="movie.director" class="form-control" placeholder="请输入导演">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_mainPerformer" class="col-md-2 text-right">主演:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_mainPerformer" name="movie.mainPerformer" class="form-control" placeholder="请输入主演">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_duration" class="col-md-2 text-right">时长:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_duration" name="movie.duration" class="form-control" placeholder="请输入时长">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_area" class="col-md-2 text-right">地区:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_area" name="movie.area" class="form-control" placeholder="请输入地区">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_releaseDateDiv" class="col-md-2 text-right">上映日期:</label>
				  	 <div class="col-md-8">
		                <div id="movie_releaseDateDiv" class="input-group date movie_releaseDate col-md-12" data-link-field="movie_releaseDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="movie_releaseDate" name="movie.releaseDate" size="16" type="text" value="" placeholder="请选择上映日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_price" class="col-md-2 text-right">票价:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="movie_price" name="movie.price" class="form-control" placeholder="请输入票价">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="movie_opera" class="col-md-2 text-right">剧情:</label>
				  	 <div class="col-md-8">
					    <textarea id="movie_opera" name="movie.opera" rows="8" class="form-control" placeholder="请输入剧情"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxMovieAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#movieAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加影片信息
	function ajaxMovieAdd() { 
		//提交之前先验证表单
		$("#movieAddForm").data('bootstrapValidator').validate();
		if(!$("#movieAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Movie/add",
			dataType : "json" , 
			data: new FormData($("#movieAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#movieAddForm").find("input").val("");
					$("#movieAddForm").find("textarea").val("");
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
	//验证影片添加表单字段
	$('#movieAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"movie.movieName": {
				validators: {
					notEmpty: {
						message: "影片名称不能为空",
					}
				}
			},
			"movie.movieType": {
				validators: {
					notEmpty: {
						message: "影片类型不能为空",
					}
				}
			},
			"movie.director": {
				validators: {
					notEmpty: {
						message: "导演不能为空",
					}
				}
			},
			"movie.mainPerformer": {
				validators: {
					notEmpty: {
						message: "主演不能为空",
					}
				}
			},
			"movie.duration": {
				validators: {
					notEmpty: {
						message: "时长不能为空",
					}
				}
			},
			"movie.area": {
				validators: {
					notEmpty: {
						message: "地区不能为空",
					}
				}
			},
			"movie.releaseDate": {
				validators: {
					notEmpty: {
						message: "上映日期不能为空",
					}
				}
			},
			"movie.price": {
				validators: {
					notEmpty: {
						message: "票价不能为空",
					},
					numeric: {
						message: "票价不正确"
					}
				}
			},
			"movie.opera": {
				validators: {
					notEmpty: {
						message: "剧情不能为空",
					}
				}
			},
		}
	}); 
	//上映日期组件
	$('#movie_releaseDateDiv').datetimepicker({
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
		$('#movieAddForm').data('bootstrapValidator').updateStatus('movie.releaseDate', 'NOT_VALIDATED',null).validateField('movie.releaseDate');
	});
})
</script>
</body>
</html>
