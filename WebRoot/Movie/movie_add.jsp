<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movie.css" />
<div id="movieAddDiv">
	<form id="movieAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影片名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieName" name="movie.movieName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">影片类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieType" name="movie.movieType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">影片图片:</span>
			<span class="inputControl">
				<input id="moviePhotoFile" name="moviePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">导演:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_director" name="movie.director" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">主演:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_mainPerformer" name="movie.mainPerformer" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">时长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_duration" name="movie.duration" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地区:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_area" name="movie.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上映日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_releaseDate" name="movie.releaseDate" />

			</span>

		</div>
		<div>
			<span class="label">票价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_price" name="movie.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">剧情:</span>
			<span class="inputControl">
				<textarea id="movie_opera" name="movie.opera" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="movieAddButton" class="easyui-linkbutton">添加</a>
			<a id="movieClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Movie/js/movie_add.js"></script> 
