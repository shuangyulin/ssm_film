<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css" /> 

<div id="schedule_manage"></div>
<div id="schedule_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="schedule_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="schedule_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="schedule_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="schedule_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="schedule_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="scheduleQueryForm" method="post">
			电影：<input class="textbox" type="text" id="movieObj_movieId_query" name="movieObj.movieId" style="width: auto"/>
			播放影厅：<input class="textbox" type="text" id="hallObj_movieHallId_query" name="hallObj.movieHallId" style="width: auto"/>
			放映日期：<input type="text" id="scheduleDate" name="scheduleDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="schedule_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="scheduleEditDiv">
	<form id="scheduleEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">档期id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleId_edit" name="schedule.scheduleId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">电影:</span>
			<span class="inputControl">
				<input class="textbox"  id="schedule_movieObj_movieId_edit" name="schedule.movieObj.movieId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">播放影厅:</span>
			<span class="inputControl">
				<input class="textbox"  id="schedule_hallObj_movieHallId_edit" name="schedule.hallObj.movieHallId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">放映日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleDate_edit" name="schedule.scheduleDate" />

			</span>

		</div>
		<div>
			<span class="label">放映时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleTime_edit" name="schedule.scheduleTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Schedule/js/schedule_manage.js"></script> 
