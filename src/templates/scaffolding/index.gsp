<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<!-- Page heading -->
	      <div class="page-head">
	        <h2 class="pull-left"><i class="fa icon-${domainClass.propertyName}"></i> <g:message code="default.list.label" args="[entityName]" /></h2>
	
	        <!-- Breadcrumb -->
	        <div class="bread-crumb pull-right">
	        	<a class="home" href="\${createLink(uri: '/')}"><i class="fa fa-home"></i> <g:message code="default.home.label"/></a>
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
					<div id="list-${domainClass.propertyName}" class="widget scaffold-list" role="main">
						<div class="widget-content">
							<g:if test="\${flash.message}">
								<div class="message" role="status">\${flash.message}</div> 
							</g:if>
							<div class="table-responsive">
								<table class="table dataTable table-striped table-bordered table-hover">
								<thead>
										<tr>
										<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
											allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
											props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
											Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
											props.eachWithIndex { p, i ->
												if (i < 6) {
													if (p.isAssociation()) { %>
											<th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
										<%      } else { %>
											<g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
										<%  }   }   } %>
										</tr>
									</thead>
									<tbody>
									<g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
										<tr class="\${(i % 2) == 0 ? 'even' : 'odd'}">
										<%  props.eachWithIndex { p, i ->
												if (i == 0) { %>
											<td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
										<%      } else if (i < 6) {
													if (p.type == Boolean || p.type == boolean) { %>
											<td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
										<%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
											<td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
										<%          } else { %>
											<td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
										<%  }   }   } %>
										</tr>
									</g:each>
									</tbody>
								</table>
							</div>
							<div class="widget-foot">
								<div class="pagination pagination-sm pull-right">
									<g:paginate total="\${${propertyName}Count ?: 0}" />
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
