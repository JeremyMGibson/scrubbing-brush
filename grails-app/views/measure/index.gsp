
<%@ page import="chia.Measure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'measure.label', default: 'Measure')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<!-- Page heading -->
	      <div class="page-head">
	        <h2 class="pull-left"><i class="fa icon-measure"></i> <g:message code="default.list.label" args="[entityName]" /></h2>
	
	        <!-- Breadcrumb -->
	        <div class="bread-crumb pull-right">
	        	<a class="home" href="${createLink(uri: '/')}"><i class="fa fa-home"></i> <g:message code="default.home.label"/></a>
	        	<span class="divider">/</span> 
				<g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
	        </div>
	
	        <div class="clearfix"></div>
	
	      </div>
	      <!-- Page heading ends -->
	
	
		  <!-- Matter -->
	
		  <div class="matter">
	        <div class="container">
	          <div class="row">
	            <div class="col-md-12">
					<div id="list-measure" class="widget scaffold-list" role="main">
						<div class="widget-content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div> 
							</g:if>
							<div class="table-responsive">
								<table class="table dataTable table-striped table-bordered table-hover">
								<thead>
										<tr>
										
											<g:sortableColumn property="name" title="${message(code: 'measure.name.label', default: 'Name')}" />
											<g:sortableColumn property="priority" title="${message(code: 'measure.priority.label', default: 'Priority')}" />
											<g:sortableColumn property="numErrors" title="${message(code: 'measure.numErrors.label', default: 'Errors Found')}" />
											
										</tr>
									</thead>
									<tbody>
									<g:each in="${measureInstanceList}" status="i" var="measureInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'} ${measureInstance.concern}">
										
											<td><g:link action="show" id="${measureInstance.id}">${fieldValue(bean: measureInstance, field: "name")}</g:link></td>
											<td>${fieldValue(bean: measureInstance, field: "priority")}</td>
											<td>${fieldValue(bean: measureInstance, field: "numErrors")}</td>																					
										</tr>
									</g:each>
									</tbody>
								</table>
							</div>
							<div class="widget-foot">
								<div class="pagination pagination-sm pull-right">
									<g:paginate total="${measureInstanceCount ?: 0}" />
								</div>
								
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	</body>
</html>
