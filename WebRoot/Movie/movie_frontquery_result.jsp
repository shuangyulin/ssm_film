<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Movie" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Movie> movieList = (List<Movie>)request.getAttribute("movieList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String movieName = (String)request.getAttribute("movieName"); //影片名称查询关键字
    String movieType = (String)request.getAttribute("movieType"); //影片类型查询关键字
    String director = (String)request.getAttribute("director"); //导演查询关键字
    String area = (String)request.getAttribute("area"); //地区查询关键字
    String releaseDate = (String)request.getAttribute("releaseDate"); //上映日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>影片查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Movie/frontlist">影片信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Movie/movie_frontAdd.jsp" style="display:none;">添加影片</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<movieList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Movie movie = movieList.get(i); //获取到影片对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Movie/<%=movie.getMovieId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=movie.getMoviePhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		影片id:<%=movie.getMovieId() %>
			     	</div>
			     	<div class="field">
	            		影片名称:<%=movie.getMovieName() %>
			     	</div>
			     	<div class="field">
	            		影片类型:<%=movie.getMovieType() %>
			     	</div>
			     	<div class="field">
	            		导演:<%=movie.getDirector() %>
			     	</div>
			     	<div class="field">
	            		主演:<%=movie.getMainPerformer() %>
			     	</div>
			     	<div class="field">
	            		时长:<%=movie.getDuration() %>
			     	</div>
			     	<div class="field">
	            		地区:<%=movie.getArea() %>
			     	</div>
			     	<div class="field">
	            		上映日期:<%=movie.getReleaseDate() %>
			     	</div>
			     	<div class="field">
	            		票价:<%=movie.getPrice() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Movie/<%=movie.getMovieId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="movieEdit('<%=movie.getMovieId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="movieDelete('<%=movie.getMovieId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>影片查询</h1>
		</div>
		<form name="movieQueryForm" id="movieQueryForm" action="<%=basePath %>Movie/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="movieName">影片名称:</label>
				<input type="text" id="movieName" name="movieName" value="<%=movieName %>" class="form-control" placeholder="请输入影片名称">
			</div>
			<div class="form-group">
				<label for="movieType">影片类型:</label>
				<input type="text" id="movieType" name="movieType" value="<%=movieType %>" class="form-control" placeholder="请输入影片类型">
			</div>
			<div class="form-group">
				<label for="director">导演:</label>
				<input type="text" id="director" name="director" value="<%=director %>" class="form-control" placeholder="请输入导演">
			</div>
			<div class="form-group">
				<label for="area">地区:</label>
				<input type="text" id="area" name="area" value="<%=area %>" class="form-control" placeholder="请输入地区">
			</div>
			<div class="form-group">
				<label for="releaseDate">上映日期:</label>
				<input type="text" id="releaseDate" name="releaseDate" class="form-control"  placeholder="请选择上映日期" value="<%=releaseDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="movieEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;影片信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#movieEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxMovieModify();">提交</button>
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
    document.movieQueryForm.currentPage.value = currentPage;
    document.movieQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.movieQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.movieQueryForm.currentPage.value = pageValue;
    documentmovieQueryForm.submit();
}

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
				$('#movieEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除影片信息*/
function movieDelete(movieId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Movie/deletes",
			data : {
				movieIds : movieId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#movieQueryForm").submit();
					//location.href= basePath + "Movie/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

