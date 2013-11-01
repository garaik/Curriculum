<%@ page import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediaItem.label', default: 'MediaItem')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-mediaItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-mediaItem" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${mediaItemInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${mediaItemInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
                <g:if test="${params?.questionId}">
                    <g:link controller="question" action="edit" params="[id: params?.questionId]">Question</g:link>
                    <g:hiddenField name="questionId" value="${params?.questionId}"></g:hiddenField>
                </g:if>
                <g:if test="${params?.answerId}">
                    <g:link controller="answer" action="edit" params="[id: params?.answerId]">Answer</g:link>
                    <g:hiddenField name="answerId" value="${params?.answerId}"></g:hiddenField>
                </g:if>
                <g:if test="${params?.feedbackId}">
                    <g:link controller="feedback" action="edit" params="[id: params?.feedbackId]">Answer</g:link>
                    <g:hiddenField name="feedbackId" value="${params?.feedbackId}"></g:hiddenField>
                </g:if>
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
