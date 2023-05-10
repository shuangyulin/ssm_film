<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/movieOrder.css" /> 

<div id="movieOrder_manage"></div>
<div id="movieOrder_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="movieOrder_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="movieOrder_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="movieOrder_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="movieOrder_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="movieOrder_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="movieOrderQueryForm" method="post">
			档期：<input class="textbox" type="text" id="scheduleObj_scheduleId_query" name="scheduleObj.scheduleId" style="width: auto"/>
			用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			预定时间：<input type="text" class="textbox" id="orderTime" name="orderTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="movieOrder_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="movieOrderEditDiv">
	<form id="movieOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订票id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="movieOrder_orderId_edit" name="movieOrder.orderId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="MovieOrder/js/movieOrder_manage.js"></script> 
