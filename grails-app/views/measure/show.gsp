
<%@ page import="chia.Measure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'measure.label', default: 'Measure')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left"><i class="fa icon-measure"></i> <g:message code="default.show.label" args="[entityName]" /></h2>

        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
        	<a class="home" href="${createLink(uri: '/')}"><i class="fa fa-home"></i> <g:message code="default.home.label"/></a>
        	<span class="divider">/</span> 
			<g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
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
            	<div id="show-measure" class="widget content scaffold-show" role="main">
            		<div class="widget-head">
            			<g:fieldValue bean="${measureInstance}" field="name"/>
            			<g:form class="widget-icons pull-right" url="[resource:measureInstance, action:'delete']" method="DELETE">
							<g:link class="run" action="run" resource="${measureInstance}"><i class="fa fa-play"></i></g:link>
							<sec:ifAnyGranted roles="ROLE_EDITOR,ROLE_ADMIN">
								<g:link class="edit" action="edit" resource="${measureInstance}"><i class="fa fa-pencil"></i></g:link>
								<g:link class="delete" action="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><i class="fa fa-trash"></i></g:link>
							</sec:ifAnyGranted>
						</g:form>
            		</div>
					<div class="widget-content">
						<div class="padd">
							<g:if test="${flash.message}">
							<div class="alert alert-${flash.success ? 'success' : 'danger' } alert-dismissable fade in" role="status">${flash.message}</div>
							</g:if>
							<g:if test="${measureInstance?.description}">
										<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${measureInstance}" field="description"/></span>
							</g:if>
						</div>
							
								
						<g:if test="${measureInstance?.runs}">
							<hr />
							<div class="padd">
								<div id="bar-chart" style="height:200px"></div>
							</div>
							<div class="table-responsive">
								<table class="table dataTable table-striped table-bordered table-hover" style="border-top: 1px solid #ccc">
									<thead>
										<tr>
											<g:sortableColumn property="runNumber" title="${message(code: 'measureRun.runNumber.label', default: 'Run Number')}" />
											<g:sortableColumn property="runtime" title="${message(code: 'measureRun.runtime.label', default: 'Runtime')}" />
											<g:sortableColumn property="totalErrors" title="Errors Found" />
											<g:sortableColumn property="fixedErrors" title="Errors Fixed" />
										</tr>
									</thead>
									<tbody>
									<g:each in="${measureInstance.runs}" status="i" var="result">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											<td><g:link action="show" id="${result.id}">${fieldValue(bean: result, field: "runNumber")}</g:link></td>
											<td><joda:format pattern="dd/MM/yyyy h:mma" value="${result.runtime}"/></td>
											<td>${result.getTotalErrors()}</td>
											<td>${result.fixedErrors}</td>
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
							
							<script type="text/javascript">
								$(document).ready(function() {
								    $.plot($("#bar-chart"), ${measureInstance.getRunData()}, {
							            series: {
							                stack: true,
							                bars: { show: true, barWidth: 0.8 }
							            },
							            grid: {
							                borderWidth: 0, hoverable: true, color: "#777"
							            },
							            colors: ["#ff6c24", "#ff2424", "#5eb2d9", "#4ac344"],
							            bars: {
							                  show: true,
							                  lineWidth: 0,
							                  fill: true,
							                  fillColor: { colors: [ { opacity: 0.9 }, { opacity: 0.8 } ] }
							            }
							        });
								});
							</script>
						</g:if>
					</div>
				</div>
			</div>
		  </div>
		</div>
	  </div>
	</body>
</html>
