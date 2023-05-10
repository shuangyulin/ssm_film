<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieHall.css" />
<div id="movieHall_editDiv">
	<form id="movieHallEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影厅id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_movieHallId_edit" name="movieHall.movieHallId" value="<%=request.getParameter("movieHallId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">影厅名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_movieHallName_edit" name="movieHall.movieHallName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">座位排数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_rows_edit" name="movieHall.rows" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">座位列数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_cols_edit" name="movieHall.cols" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="movieHallModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/MovieHall/js/movieHall_modify.js"></script> 
