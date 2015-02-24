<%@ page import="chia.Measure" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'measure.label', default: 'Measure')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
	  <!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left"><i class="fa icon-measure"></i> <g:message code="default.edit.label" args="[entityName]" /></h2>

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
            	<div id="edit-measure" class="widget content scaffold-edit" role="main">
					<div class="widget-content">
						<div class="padd">
							<g:if test="${flash.message}">
							<div class="message" role="status">${flash.message}</div>
							</g:if>
							<g:hasErrors bean="${measureInstance}">
							<ul class="errors" role="alert">
								<g:eachError bean="${measureInstance}" var="error">
								<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
								</g:eachError>
							</ul>
							</g:hasErrors>
							<g:form url="[resource:measureInstance, action:'update']" method="PUT" >
								<g:hiddenField name="version" value="${measureInstance?.version}" />
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<g:actionSubmit class="save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
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
