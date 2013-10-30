<%@ page import="curriculum.Activity; curriculum.Subactivity" %>
<div class="row">
    <div class="large-5 columns">
        <label for="name" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="subactivity.name.label" />:</label>
        <input name="name" id="name" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}">
    </div>
    <div class="large-5 columns">
        <label for="activity" class="${hasErrors(bean: instance, field: 'activity', 'error')}"><g:message code="subactivity.activity.label"/>:</label>
        <g:select id="activity" name="activity.id" from="${Activity.list()}" optionKey="id" required="" value="${instance?.activity?.id}" />
        <g:hasErrors bean="${instance}" field="name">
        <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>
