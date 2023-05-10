<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieHall.css" /> 

<div id="movieHall_manage"></div>
<div id="movieHall_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="movieHall_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="movieHall_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="movieHall_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="movieHall_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="movieHall_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="movieHallQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="movieHallEditDiv">
	<form id="movieHallEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">影厅id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieHall_movieHallId_edit" name="movieHall.movieHallId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="MovieHall/js/movieHall_manage.js"></script> 
