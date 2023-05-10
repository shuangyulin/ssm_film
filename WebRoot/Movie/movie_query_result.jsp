<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movie.css" /> 

<div id="movie_manage"></div>
<div id="movie_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="movie_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="movie_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="movie_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="movie_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="movie_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="movieQueryForm" method="post">
			影片名称：<input type="text" class="textbox" id="movieName" name="movieName" style="width:110px" />
			影片类型：<input type="text" class="textbox" id="movieType" name="movieType" style="width:110px" />
			导演：<input type="text" class="textbox" id="director" name="director" style="width:110px" />
			地区：<input type="text" class="textbox" id="area" name="area" style="width:110px" />
			上映日期：<input type="text" id="releaseDate" name="releaseDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="movie_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="movieEditDiv">
	<form id="movieEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影片id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieId_edit" name="movie.movieId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">影片名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieName_edit" name="movie.movieName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">影片类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieType_edit" name="movie.movieType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">影片图片:</span>
			<span class="inputControl">
				<img id="movie_moviePhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="movie_moviePhoto" name="movie.moviePhoto"/>
				<input id="moviePhotoFile" name="moviePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">导演:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_director_edit" name="movie.director" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">主演:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_mainPerformer_edit" name="movie.mainPerformer" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">时长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_duration_edit" name="movie.duration" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地区:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_area_edit" name="movie.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上映日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_releaseDate_edit" name="movie.releaseDate" />

			</span>

		</div>
		<div>
			<span class="label">票价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_price_edit" name="movie.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">剧情:</span>
			<span class="inputControl">
				<textarea id="movie_opera_edit" name="movie.opera" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Movie/js/movie_manage.js"></script> 
