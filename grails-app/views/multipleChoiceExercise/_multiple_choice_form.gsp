<%@ page import="curriculum.*" %>

<div class="small-12 columns">
    <label for="exerciseAlmaszosz" class="${hasErrors(bean: instance, field: 'almaszosz', 'error')}"><g:message code="exercise.almaszosz.label" />:</label>
    <input name="almaszosz" id="exerciseAlmaszosz" type="text" value="${instance?.almaszosz}" class="${hasErrors(bean: instance, field: 'almaszosz', 'error')}">
    <g:hasErrors bean="${instance}" field="almaszosz">
        <small class="error"><g:fieldError bean="${instance}" field="almaszosz" /></small>
    </g:hasErrors>
</div>