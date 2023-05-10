<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieHall.css" />
<div id="movieHallAddDiv">
	<form id="movieHallAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影厅名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_movieHallName" name="movieHall.movieHallName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">座位排数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_rows" name="movieHall.rows" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">座位列数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_cols" name="movieHall.cols" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="movieHallAddButton" class="easyui-linkbutton">添加</a>
			<a id="movieHallClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/MovieHall/js/movieHall_add.js"></script> 
