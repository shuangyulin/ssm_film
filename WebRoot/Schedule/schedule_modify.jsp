<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css" />
<div id="schedule_editDiv">
	<form id="scheduleEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">档期id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleId_edit" name="schedule.scheduleId" value="<%=request.getParameter("scheduleId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="scheduleModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Schedule/js/schedule_modify.js"></script> 
