<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css" />
<div id="scheduleAddDiv">
	<form id="scheduleAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">电影:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_movieObj_movieId" name="schedule.movieObj.movieId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">播放影厅:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_hallObj_movieHallId" name="schedule.hallObj.movieHallId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">放映日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleDate" name="schedule.scheduleDate" />

			</span>

		</div>
		<div>
			<span class="label">放映时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schedule_scheduleTime" name="schedule.scheduleTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scheduleAddButton" class="easyui-linkbutton">添加</a>
			<a id="scheduleClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Schedule/js/schedule_add.js"></script> 
