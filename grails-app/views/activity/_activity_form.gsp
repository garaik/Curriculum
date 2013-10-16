<%@ page import="curriculum.Grade; curriculum.Activity" %>
<div class="row">
    <div class="large-6 columns">
        <label for="name" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="activity.name.label" />:</label>
        <input name="name" id="name" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}">

        <label for="grade" class="${hasErrors(bean: instance, field: 'grade', 'error')}"><g:message code="activity.grade.label"/>:</label>
        <%--<input name="grade" id="grade" type="" value="${instance?.grade}" class="${hasErrors(bean: instance, field: 'grade', 'error')}"> --%>
        <g:select id="grade" name="grade.id" from="${Grade.list()}" optionKey="id" required="" value="${instance?.grade?.id}" class="many-to-one"/>
        <g:hasErrors bean="${instance}" field="name">
            <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>
