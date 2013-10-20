<%@ page import="curriculum.Grade" %>
<div class="row">
    <div class="large-6 columns">
        <label for="gradeName" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="grade.name.label" />:</label>
        <input name="name" id="gradeName" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}" />
        <g:hasErrors bean="${instance}" field="name">
            <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>