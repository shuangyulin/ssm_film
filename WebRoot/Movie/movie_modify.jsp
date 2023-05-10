<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movie.css" />
<div id="movie_editDiv">
	<form id="movieEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影片id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movie_movieId_edit" name="movie.movieId" value="<%=request.getParameter("movieId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="movieModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Movie/js/movie_modify.js"></script> 
