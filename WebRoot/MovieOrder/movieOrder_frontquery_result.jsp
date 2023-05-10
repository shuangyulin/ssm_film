<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.MovieOrder" %>
<%@ page import="com.chengxusheji.po.Schedule" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<MovieOrder> movieOrderList = (List<MovieOrder>)request.getAttribute("movieOrderList");
    //获取所有的scheduleObj信息
    List<Schedule> scheduleList = (List<Schedule>)request.getAttribute("scheduleList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Schedule scheduleObj = (Schedule)request.getAttribute("scheduleObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String orderTime = (String)request.getAttribute("orderTime"); //预定时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订票查询</title>
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
			    	<li role="presentation" class="active"><a href="#movieOrderListPanel" aria-controls="movieOrderListPanel" role="tab" data-toggle="tab">订票列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>MovieOrder/movieOrder_frontAdd.jsp" style="display:none;">添加订票</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="movieOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订票id</td><td>档期</td><td>座位行号</td><td>座位列号</td><td>票价</td><td>用户</td><td>预定时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<movieOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		MovieOrder movieOrder = movieOrderList.get(i); //获取到订票对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=movieOrder.getOrderId() %></td>
 											<td><%=movieOrder.getScheduleObj().getScheduleId() %></td>
 											<td><%=movieOrder.getRowsIndex() %></td>
 											<td><%=movieOrder.getCols() %></td>
 											<td><%=movieOrder.getPrice() %></td>
 											<td><%=movieOrder.getUserObj().getName() %></td>
 											<td><%=movieOrder.getOrderTime() %></td>
 											<td>
 												<a href="<%=basePath  %>MovieOrder/<%=movieOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="movieOrderEdit('<%=movieOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="movieOrderDelete('<%=movieOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>订票查询</h1>
		</div>
		<form name="movieOrderQueryForm" id="movieOrderQueryForm" action="<%=basePath %>MovieOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="scheduleObj_scheduleId">档期：</label>
                <select id="scheduleObj_scheduleId" name="scheduleObj.scheduleId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Schedule scheduleTemp:scheduleList) {
	 					String selected = "";
 					if(scheduleObj!=null && scheduleObj.getScheduleId()!=null && scheduleObj.getScheduleId().intValue()==scheduleTemp.getScheduleId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=scheduleTemp.getScheduleId() %>" <%=selected %>><%=scheduleTemp.getScheduleId() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="orderTime">预定时间:</label>
				<input type="text" id="orderTime" name="orderTime" value="<%=orderTime %>" class="form-control" placeholder="请输入预定时间">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="movieOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;订票信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#movieOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxMovieOrderModify();">提交</button>
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
    document.movieOrderQueryForm.currentPage.value = currentPage;
    document.movieOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.movieOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.movieOrderQueryForm.currentPage.value = pageValue;
    documentmovieOrderQueryForm.submit();
}

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
				$('#movieOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除订票信息*/
function movieOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "MovieOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#movieOrderQueryForm").submit();
					//location.href= basePath + "MovieOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

