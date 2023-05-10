<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.MovieHall" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<MovieHall> movieHallList = (List<MovieHall>)request.getAttribute("movieHallList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>影厅查询</title>
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
		<div class="col-md-12 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#movieHallListPanel" aria-controls="movieHallListPanel" role="tab" data-toggle="tab">影厅列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>MovieHall/movieHall_frontAdd.jsp" style="display:none;">添加影厅</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="movieHallListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>影厅id</td><td>影厅名称</td><td>座位排数</td><td>座位列数</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<movieHallList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		MovieHall movieHall = movieHallList.get(i); //获取到影厅对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=movieHall.getMovieHallId() %></td>
 											<td><%=movieHall.getMovieHallName() %></td>
 											<td><%=movieHall.getRows() %></td>
 											<td><%=movieHall.getCols() %></td>
 											<td>
 												<a href="<%=basePath  %>MovieHall/<%=movieHall.getMovieHallId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="movieHallEdit('<%=movieHall.getMovieHallId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="movieHallDelete('<%=movieHall.getMovieHallId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
	<div style="display:none;">
		<div class="page-header">
    		<h1>影厅查询</h1>
		</div>
		<form name="movieHallQueryForm" id="movieHallQueryForm" action="<%=basePath %>MovieHall/frontlist" class="mar_t15" method="post">
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="movieHallEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;影厅信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#movieHallEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxMovieHallModify();">提交</button>
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
    document.movieHallQueryForm.currentPage.value = currentPage;
    document.movieHallQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.movieHallQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.movieHallQueryForm.currentPage.value = pageValue;
    documentmovieHallQueryForm.submit();
}

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
				$('#movieHallEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除影厅信息*/
function movieHallDelete(movieHallId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "MovieHall/deletes",
			data : {
				movieHallIds : movieHallId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#movieHallQueryForm").submit();
					//location.href= basePath + "MovieHall/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

