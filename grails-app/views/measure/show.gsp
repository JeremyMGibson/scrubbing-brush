
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
            				<a href="#" class="wminimize">
								<i class="fa fa-chevron-up"></i>
							</a>
							<g:link class="run" action="run" resource="${measureInstance}"><i class="fa fa-play"></i></g:link>
							<sec:ifAnyGranted roles="ROLE_EDITOR,ROLE_ADMIN">
								<g:link class="edit" action="edit" resource="${measureInstance}"><i class="fa fa-pencil"></i></g:link>
								<g:link class="delete" action="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><i class="fa fa-trash"></i></g:link>
							</sec:ifAnyGranted>
						</g:form>
						<div class="clearfix"></div>
            		</div>
					<div class="widget-content">
						<div class="padd">
							<g:if test="${flash.message}">
							<div class="alert alert-${flash.success ? 'success' : 'danger' } alert-dismissable fade in" role="status">${flash.message}</div>
							</g:if>
							<g:if test="${measureInstance?.description}">
										<div class="property-value" aria-labelledby="description-label">${raw(measureInstance.description)}</div>
							</g:if>
						</div>
					</div>
				</div>
							
				<g:if test="${measureInstance?.runs}">
					<div id="show-measure" class="widget content scaffold-show" role="main">
            			<div class="widget-head">
            				<div class="pull-left">Runs</div>
            				<div class="widget-icons pull-right">
								<a href="#" class="wminimize">
									<i class="fa fa-chevron-up"></i>
								</a>
							</div>
							<div class="clearfix"></div>
            			</div>
						<div class="widget-content">
							<div class="padd">
								<div id="bar-chart" style="height:500px"></div>
							</div>
							<div class="table-responsive container data-table-container">
								<table data-table="yes" data-table-sort='[[0, "desc"]]' class="table dataTable table-striped table-bordered table-hover" style="border-top: 1px solid #ccc">
									<thead>
										<tr>
											<th>Run Number</th>
											<th>Runtime</th>
											<th>Errors Identified</th>
											<th>Errors Fixed</th>
										</tr>
									</thead>
									<tbody>
									<g:each in="${measureInstance.runs}" status="i" var="result" >
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'} ${result.success ? 'completed' : 'failed'}">
											<td><g:link action="show" id="${result.id}">${fieldValue(bean: result, field: "runNumber")}</g:link></td>
											<td><joda:format pattern="dd/MM/yyyy h:mma" value="${result.runtime}"/></td>
											<td>${result.getTotalErrors()}</td>
											<td>${result.fixedErrors}</td>
										</tr>
									</g:each>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="widget content scaffold-show" role="main">
            			<div class="widget-head">
            				<div class="pull-left">Errors</div>
            				<div class="widget-icons pull-right">
         						<a href="#" class="copy-button" data-clipboard-target="error-table" title="Copy results to clipboard">
									<i class="fa fa-copy"></i>
								</a>
								<a href="#" class="wminimize">
									<i class="fa fa-chevron-up"></i>
								</a>
							</div>
							<div class="clearfix"></div>
            			</div>
						<div class="widget-content">
							<div class="table-responsive container data-table-container">
								<table id="error-table" data-table="yes" data-table-sort='[[1, "desc"]]' class="table dataTable table-striped table-bordered table-hover" style="border-top: 1px solid #ccc">
									<thead>
										<tr>
											<th>ID</th>
											<th>Found</th>
											<g:if test="${measureInstance.getResults().size() > 0}">
												<g:each in="${measureInstance.getResults()[0].getData().keys()}" var="key">
													<th>${key}</th>
												</g:each>
											</g:if>
										</tr>
									</thead>
									<tbody>
									<g:each in="${measureInstance.getOutstandingErrors()}" status="i" var="result" >
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											<td>${result.reference}</td>
											<td><joda:format pattern="yyyy-MM-dd h:mma" value="${result.found.runtime}"/></td>
											<g:each in="${result.getData().values()}" var="val">
												<td>${val}</td>
											</g:each>
										</tr>
									</g:each>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<script type="text/javascript">
							$(document).ready(function() {
							    $.plot($("#bar-chart"), [ 
						        {
						        	data: ${measureInstance.getOldErrorData()},
							    	label: "Recurring Errors",
						        }, 
						        {
							    	data: ${measureInstance.getNewErrorData()},
							    	label: "New Errors",
						        },
						        {
						        	data: ${measureInstance.getRebrokenErrorData()},
							    	label: "Rebroken Errors",
						        }, 
						        {
							    	data: ${measureInstance.getFixedData()},
							    	label: "Resolved Errors",
							    	stack: false,
						            bars: { show: true, barWidth: 0.7, align: "center", fillColor: { colors: [ { opacity: 1 }, { opacity: 0.9 } ] } }
						             
						        }],
						        {
						        	grid: {
						                borderWidth: 0, hoverable: false, color: "#777"
						            },

						            yaxis: {
						            	minTickSize: 1,
							            min: 0,
							            tickFormatter: function formatter(val, axis) {
								            return Math.round(val);
								        }
							        },
						            xaxis: {
							            minTickSize: 1,
							            min: 0,
							            
							            tickFormatter: function formatter(val, axis) {
								            return Math.round(val);
								        }
							        },
							        series: {
						                stack: true,
						                bars: { show: true, barWidth: 0.9, align: "center" }
						            },
						            colors: ["#FFcc33", "#ff6c24", "#ff2424", "#4ac344"],
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
	</body>
</html>
