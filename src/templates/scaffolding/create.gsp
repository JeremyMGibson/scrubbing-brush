<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left"><i class="fa icon-${domainClass.propertyName}"></i> <g:message code="default.create.label" args="[entityName]" /></h2>

        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
        	<a class="home" href="\${createLink(uri: '/')}"><i class="fa fa-home"></i> <g:message code="default.home.label"/></a>
        	<span class="divider">/</span> 
			<g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
        </div>

        <div class="clearfix"></div>

      </div>
      <!-- Page heading ends -->


	  <!-- Matter -->

	  <div class="matter">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
            	<div id="create-${domainClass.propertyName}" class="widget content scaffold-create" role="main">
					<div class="widget-content">
						<div class="padd">
							<g:if test="\${flash.message}">
							<div class="alert alert-info" role="status">\${flash.message}</div>
							</g:if>
							<g:hasErrors bean="\${${propertyName}}">
							<ul class="errors" role="alert">
								<g:eachError bean="\${${propertyName}}" var="error">
								<li <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message error="\${error}"/></li>
								</g:eachError>
							</ul>
							</g:hasErrors>
							<g:form url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<g:submitButton name="create" class="save btn btn-primary" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
								</fieldset>
							</g:form>
						</div>
					</div>
				</div>
			</div>
		  </div>
		</div>
	  </div>
	</body>
</html>
