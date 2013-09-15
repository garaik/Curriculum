<%@ page import="curriculum.User" %>
<div class="row">
    <div class="large-6 columns">
        <label for="userLoginName" class="${hasErrors(bean: instance, field: 'login', 'error')}"><g:message code="user.login.label" />:</label>
        <input name="login" id="userLoginName" type="text" value="${instance?.login}" class="${hasErrors(bean: instance, field: 'login', 'error')}">
        <g:hasErrors bean="${instance}" field="login">
            <small class="error"><g:fieldError bean="${instance}" field="login" /></small>
        </g:hasErrors>
    </div>
    <div class="large-6 columns">
        <label for="userName" class="${hasErrors(bean: instance, field: 'name', 'error')}"><g:message code="user.name.label" />:</label>
        <input name="name" id="userName" type="text" value="${instance?.name}" class="${hasErrors(bean: instance, field: 'name', 'error')}" />
        <g:hasErrors bean="${instance}" field="name">
            <small class="error"><g:fieldError bean="${instance}" field="name" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="large-6 columns">
        <label for="password-input" class="${hasErrors(bean: instance, field: 'password', 'error')}"><g:message code="user.password.label" />:</label>
        <input name="password" id="password-input" type="text" value="${instance?.password}" class="${hasErrors(bean: instance, field: 'password', 'error')}" />
        <g:hasErrors bean="${instance}" field="password">
            <small class="error"><g:fieldError bean="${instance}" field="password" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="small-12 columns">
        <label for="email-input" class="${hasErrors(bean: instance, field: 'email', 'error')}"><g:message code="user.email.label" />:</label>
        <input name="email" id="email-input" type="text" value="${instance?.email}" class="${hasErrors(bean: instance, field: 'email', 'error')}" />
        <g:hasErrors bean="${instance}" field="email">
            <small class="error"><g:fieldError bean="${instance}" field="email" /></small>
        </g:hasErrors>
    </div>
</div>
