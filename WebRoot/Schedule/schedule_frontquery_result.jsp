<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Schedule" %>
<%@ page import="com.chengxusheji.po.Movie" %>
<%@ page import="com.chengxusheji.po.MovieHall" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Schedule> scheduleList = (List<Schedule>)request.getAttribute("scheduleList");
    //获取所有的movieObj信息
    List<Movie> movieList = (List<Movie>)request.getAttribute("movieList");
    //获取所有的hallObj信息
    List<MovieHall> movieHallList = (List<MovieHall>)request.getAttribute("movieHallList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Movie movieObj = (Movie)request.getAttribute("movieObj");
    MovieHall hallObj = (MovieHall)request.getAttribute("hallObj");
    String scheduleDate = (String)request.getAttribute("scheduleDate"); //放映日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>档期计划查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#scheduleListPanel" aria-controls="scheduleListPanel" role="tab" data-toggle="tab">档期计划列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Schedule/schedule_frontAdd.jsp" style="display:none;">添加档期计划</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="scheduleListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>档期id</td><td>电影</td><td>播放影厅</td><td>放映日期</td><td>放映时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<scheduleList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Schedule schedule = scheduleList.get(i); //获取到档期计划对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=schedule.getScheduleId() %></td>
 											<td><%=schedule.getMovieObj().getMovieName() %></td>
 											<td><%=schedule.getHallObj().getMovieHallName() %></td>
 											<td><%=schedule.getScheduleDate() %></td>
 											<td><%=schedule.getScheduleTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Schedule/<%=schedule.getScheduleId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="scheduleEdit('<%=schedule.getScheduleId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="scheduleDelete('<%=schedule.getScheduleId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>档期计划查询</h1>
		</div>
		<form name="scheduleQueryForm" id="scheduleQueryForm" action="<%=basePath %>Schedule/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="movieObj_movieId">电影：</label>
                <select id="movieObj_movieId" name="movieObj.movieId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Movie movieTemp:movieList) {
	 					String selected = "";
 					if(movieObj!=null && movieObj.getMovieId()!=null && movieObj.getMovieId().intValue()==movieTemp.getMovieId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=movieTemp.getMovieId() %>" <%=selected %>><%=movieTemp.getMovieName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="hallObj_movieHallId">播放影厅：</label>
                <select id="hallObj_movieHallId" name="hallObj.movieHallId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(MovieHall movieHallTemp:movieHallList) {
	 					String selected = "";
 					if(hallObj!=null && hallObj.getMovieHallId()!=null && hallObj.getMovieHallId().intValue()==movieHallTemp.getMovieHallId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=movieHallTemp.getMovieHallId() %>" <%=selected %>><%=movieHallTemp.getMovieHallName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="scheduleDate">放映日期:</label>
				<input type="text" id="scheduleDate" name="scheduleDate" class="form-control"  placeholder="请选择放映日期" value="<%=scheduleDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="scheduleEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;档期计划信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date schedule_scheduleDate_edit col-md-12" data-link-field="schedule_scheduleDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#scheduleEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxScheduleModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.scheduleQueryForm.currentPage.value = currentPage;
    document.scheduleQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.scheduleQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.scheduleQueryForm.currentPage.value = pageValue;
    documentscheduleQueryForm.submit();
}

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
				$('#scheduleEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除档期计划信息*/
function scheduleDelete(scheduleId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Schedule/deletes",
			data : {
				scheduleIds : scheduleId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#scheduleQueryForm").submit();
					//location.href= basePath + "Schedule/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

