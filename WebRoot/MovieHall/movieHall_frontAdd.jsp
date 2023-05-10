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
<title>影厅添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>MovieHall/frontlist">影厅列表</a></li>
			    	<li role="presentation" class="active"><a href="#movieHallAdd" aria-controls="movieHallAdd" role="tab" data-toggle="tab">添加影厅</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="movieHallList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="movieHallAdd"> 
				      	<form class="form-horizontal" name="movieHallAddForm" id="movieHallAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="movieHall_movieHallName" class="col-md-2 text-right">影厅名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieHall_movieHallName" name="movieHall.movieHallName" class="form-control" placeholder="请输入影厅名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieHall_rows" class="col-md-2 text-right">座位排数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieHall_rows" name="movieHall.rows" class="form-control" placeholder="请输入座位排数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieHall_cols" class="col-md-2 text-right">座位列数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieHall_cols" name="movieHall.cols" class="form-control" placeholder="请输入座位列数">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxMovieHallAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#movieHallAddForm .form-group {margin:10px;}  </style>
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
	//提交添加影厅信息
	function ajaxMovieHallAdd() { 
		//提交之前先验证表单
		$("#movieHallAddForm").data('bootstrapValidator').validate();
		if(!$("#movieHallAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "MovieHall/add",
			dataType : "json" , 
			data: new FormData($("#movieHallAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#movieHallAddForm").find("input").val("");
					$("#movieHallAddForm").find("textarea").val("");
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
	//验证影厅添加表单字段
	$('#movieHallAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"movieHall.movieHallName": {
				validators: {
					notEmpty: {
						message: "影厅名称不能为空",
					}
				}
			},
			"movieHall.rows": {
				validators: {
					notEmpty: {
						message: "座位排数不能为空",
					},
					integer: {
						message: "座位排数不正确"
					}
				}
			},
			"movieHall.cols": {
				validators: {
					notEmpty: {
						message: "座位列数不能为空",
					},
					integer: {
						message: "座位列数不正确"
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
