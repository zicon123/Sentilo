<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/taglibs.jsp"%>

<c:set var="permissionTable" value="permissionTable"/>

<c:if test="${not empty applicationId}">
	<spring:url value="/permissions/application/${applicationId}" var="sAjaxSource" />
	<spring:url value="/permissions/application/${applicationId}/add" var="addPermissionURL" />
	<spring:url value="/permissions/application/${applicationId}/remove" var="removePermissionURL" />
	<spring:url value="/provider/" var="detailPrefix" />
	<c:set value="${applicationId}" var="entityId" />
	<c:set value="providers" var="modelAttribute" />
	<spring:url value="/admin/application/list?nameTableRecover=applicationTable&fromBack=true" var="backURL" />
	<spring:url value="/permissions/application/${applicationId}/excel?tableName=${permissionTable}" var="excelSource" />
</c:if>
<c:if test="${not empty providerId}">
	<spring:url value="/permissions/provider/${providerId}" var="sAjaxSource" />
	<spring:url value="/permissions/provider/${providerId}/add" var="addPermissionURL" />
	<spring:url value="/permissions/provider/${providerId}/remove" var="removePermissionURL" />
	<spring:url value="/sensor/" var="detailPrefix" />
	<c:set value="${providerId}" var="entityId" />
	<c:set value="sensors" var="modelAttribute" />
	<spring:url value="/admin/provider/list?nameTableRecover=providerTable&fromBack=true" var="backURL" />
<%-- <spring:url value="/permissions/list/excel?tableName=${permissionTable}" var="excelSource" /> --%>
</c:if>



<%@include file="/WEB-INF/jsp/common/include_script_tables.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var firstColumnRenderDelegate = function (data, type, row) {
		if ('${entityId}' === row[1]) {
			return '';
		}
		return '<input type="checkbox" name="selectedIds" value="' + data +'" onclick="check(event);"/>';
		}; 
		
		var table =	makeTableAsync('${permissionTable}', '${sAjaxSource}', false, firstColumnRenderDelegate);
		/* if(table.fnSettings().aoData.length === 0) {
		    $('#excel_'+'${permissionTable}').css("display", "none");
		} */
});
</script>

<form:form method="post" onkeypress="return preventEnterSubmit(event);" modelAttribute="${modelAttribute}" action="${removePermissionURL}">

	<c:if test="${not empty applicationId}">
		<input type="hidden" name="applicationId" value="${applicationId}" />
	</c:if>
	<c:if test="${not empty providerId}">
		<input type="hidden" name="providerId" value="${providerId}" />
	</c:if>

	<table class="table table-striped" id="${permissionTable}">
		<thead>
			<tr>
				<td>&nbsp;</td>
				<td><strong><spring:message code="permission.target" /> </strong></td>
				<td><strong><spring:message code="permission.type" /> </strong></td>
			</tr>
		</thead>
		<tbody />
	</table>
	<br />
	<div class="control-group pull-left" id="excel_${permissionTable}">
		<a href="#" type="button" onclick="window.location.href='${excelSource}';" class="btn"> 
			<spring:message code="button.excel" /> 
		</a>
	</div>	
	<div class="control-group pull-right">
		<%@include file="/WEB-INF/jsp/common/include_input_back.jsp"%>
		<a href="#" onclick="unassignSelected('${modelAttribute}');" class="btn btn-danger"> 
			<spring:message code="permission.remove" /> 
		</a> 
		<a href="#" onclick="window.location.href='${addPermissionURL}';" class="btn"> 
			<spring:message code="permission.add" /> 
		</a>
	</div>
</form:form>
