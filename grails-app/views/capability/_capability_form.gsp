<%@ page import="curriculum.Capability" %>
<div class="row">
    <div class="large-6 columns">
        <label for="capabilityName" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="capability.name.label" />:</label>
        <input name="name" id="capabilityName" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}" />
        <g:hasErrors bean="${instance}" field="name">
            <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>