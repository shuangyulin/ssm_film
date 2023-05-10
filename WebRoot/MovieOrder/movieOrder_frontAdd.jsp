<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Schedule" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
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
<title>订票添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>MovieOrder/frontlist">订票列表</a></li>
			    	<li role="presentation" class="active"><a href="#movieOrderAdd" aria-controls="movieOrderAdd" role="tab" data-toggle="tab">添加订票</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="movieOrderList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="movieOrderAdd"> 
				      	<form class="form-horizontal" name="movieOrderAddForm" id="movieOrderAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="movieOrder_scheduleObj_scheduleId" class="col-md-2 text-right">档期:</label>
						  	 <div class="col-md-8">
							    <select id="movieOrder_scheduleObj_scheduleId" name="movieOrder.scheduleObj.scheduleId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieOrder_rowsIndex" class="col-md-2 text-right">座位行号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieOrder_rowsIndex" name="movieOrder.rowsIndex" class="form-control" placeholder="请输入座位行号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieOrder_cols" class="col-md-2 text-right">座位列号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieOrder_cols" name="movieOrder.cols" class="form-control" placeholder="请输入座位列号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieOrder_price" class="col-md-2 text-right">票价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieOrder_price" name="movieOrder.price" class="form-control" placeholder="请输入票价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieOrder_userObj_user_name" class="col-md-2 text-right">用户:</label>
						  	 <div class="col-md-8">
							    <select id="movieOrder_userObj_user_name" name="movieOrder.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="movieOrder_orderTime" class="col-md-2 text-right">预定时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="movieOrder_orderTime" name="movieOrder.orderTime" class="form-control" placeholder="请输入预定时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxMovieOrderAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#movieOrderAddForm .form-group {margin:10px;}  </style>
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
	//提交添加订票信息
	function ajaxMovieOrderAdd() { 
		//提交之前先验证表单
		$("#movieOrderAddForm").data('bootstrapValidator').validate();
		if(!$("#movieOrderAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "MovieOrder/add",
			dataType : "json" , 
			data: new FormData($("#movieOrderAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#movieOrderAddForm").find("input").val("");
					$("#movieOrderAddForm").find("textarea").val("");
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
	//验证订票添加表单字段
	$('#movieOrderAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"movieOrder.rowsIndex": {
				validators: {
					notEmpty: {
						message: "座位行号不能为空",
					},
					integer: {
						message: "座位行号不正确"
					}
				}
			},
			"movieOrder.cols": {
				validators: {
					notEmpty: {
						message: "座位列号不能为空",
					},
					integer: {
						message: "座位列号不正确"
					}
				}
			},
			"movieOrder.price": {
				validators: {
					notEmpty: {
						message: "票价不能为空",
					},
					numeric: {
						message: "票价不正确"
					}
				}
			},
		}
	}); 
	//初始化档期下拉框值 
	$.ajax({
		url: basePath + "Schedule/listAll",
		type: "get",
		success: function(schedules,response,status) { 
			$("#movieOrder_scheduleObj_scheduleId").empty();
			var html="";
    		$(schedules).each(function(i,schedule){
    			html += "<option value='" + schedule.scheduleId + "'>" + schedule.scheduleId + "</option>";
    		});
    		$("#movieOrder_scheduleObj_scheduleId").html(html);
    	}
	});
	//初始化用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#movieOrder_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#movieOrder_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
