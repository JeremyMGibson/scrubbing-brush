<%@ page import="chia.Measure" %>



<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'name', 'error')} required">
	<label for="name" class="control-label">
		<g:message code="measure.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${measureInstance?.name}" class="form-control"/>

</div>

<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'description', 'error')} required">
	<label for="description" class="control-label">
		<g:message code="measure.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" required="" value="${measureInstance?.description}" class="form-control"/>

</div>

<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'connection', 'error')} required">
	<label for="connection" class="control-label">
		<g:message code="measure.connection.label" default="Connection" />
		<span class="required-indicator">*</span>
	</label>
	<g:select class="form-control" name="connection" from="${chia.Measure$Connection?.values()}" keys="${chia.Measure$Connection.values()*.name()}" required="" value="${measureInstance?.connection?.name()}" />

</div>

<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'type', 'error')} required">
	<label for="type" class="control-label">
		<g:message code="measure.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select class="form-control" name="type" from="${chia.Measure$MeasureType?.values()}" keys="${chia.Measure$MeasureType.values()*.name()}" required="" value="${measureInstance?.type?.name()}" />

</div>

<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'query', 'error')} required">
	<label for="query" class="control-label">
		<g:message code="measure.query.label" default="Query" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="query" required="" value="${measureInstance?.query}" class="form-control"/>

</div>

<div class="fieldcontain form-group ${hasErrors(bean: measureInstance, field: 'correctionScript', 'error')} required">
	<label for="correctionScript" class="control-label">
		<g:message code="measure.correctionScript.label" default="Correction Script" />
	</label>
	<g:textArea name="correctionScript" value="${measureInstance?.correctionScript}" class="form-control"/>

</div>

