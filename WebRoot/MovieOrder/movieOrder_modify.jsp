<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieOrder.css" />
<div id="movieOrder_editDiv">
	<form id="movieOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订票id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_orderId_edit" name="movieOrder.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">档期:</span>
			<span class="inputControl">
				<input class="textbox"  id="movieOrder_scheduleObj_scheduleId_edit" name="movieOrder.scheduleObj.scheduleId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">座位行号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_rowsIndex_edit" name="movieOrder.rowsIndex" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">座位列号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_cols_edit" name="movieOrder.cols" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">票价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_price_edit" name="movieOrder.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="movieOrder_userObj_user_name_edit" name="movieOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预定时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_orderTime_edit" name="movieOrder.orderTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="movieOrderModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/MovieOrder/js/movieOrder_modify.js"></script> 
