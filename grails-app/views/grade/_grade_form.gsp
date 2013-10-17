<%@ page import="curriculum.Grade; curriculum.Grade" %>
<div class="row">
    <div class="large-6 columns">
        <label for="name" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="grade.name.label" />:</label>
        <input name="name" id="name" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}">

        <g:hasErrors bean="${instance}" field="name">
            <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>
