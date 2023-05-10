<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieOrder.css" />
<div id="movieOrderAddDiv">
	<form id="movieOrderAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">档期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_scheduleObj_scheduleId" name="movieOrder.scheduleObj.scheduleId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">座位行号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_rowsIndex" name="movieOrder.rowsIndex" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">座位列号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_cols" name="movieOrder.cols" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">票价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_price" name="movieOrder.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_userObj_user_name" name="movieOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预定时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_orderTime" name="movieOrder.orderTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="movieOrderAddButton" class="easyui-linkbutton">添加</a>
			<a id="movieOrderClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/MovieOrder/js/movieOrder_add.js"></script> 
