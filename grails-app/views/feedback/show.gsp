
<%@ page import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'feedback.label', default: 'Feedback')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-feedback" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-feedback" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list feedback">
			
				<g:if test="${feedbackInstance?.answers}">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label"><g:message code="feedback.answers.label" default="Answers" /></span>
					
						<g:each in="${feedbackInstance.answers}" var="a">
						<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${feedbackInstance?.correct}">
				<li class="fieldcontain">
					<span id="correct-label" class="property-label"><g:message code="feedback.correct.label" default="Correct" /></span>
					
						<span class="property-value" aria-labelledby="correct-label"><g:formatBoolean boolean="${feedbackInstance?.correct}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${feedbackInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="feedback.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${feedbackInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${feedbackInstance?.mediaItems}">
				<li class="fieldcontain">
					<span id="mediaItems-label" class="property-label"><g:message code="feedback.mediaItems.label" default="Media Items" /></span>
					
						<g:each in="${feedbackInstance.mediaItems}" var="m">
						<span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${feedbackInstance?.questions}">
				<li class="fieldcontain">
					<span id="questions-label" class="property-label"><g:message code="feedback.questions.label" default="Questions" /></span>
					
						<g:each in="${feedbackInstance.questions}" var="q">
						<span class="property-value" aria-labelledby="questions-label"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${feedbackInstance?.systemFeedback}">
				<li class="fieldcontain">
					<span id="systemFeedback-label" class="property-label"><g:message code="feedback.systemFeedback.label" default="System Feedback" /></span>
					
						<span class="property-value" aria-labelledby="systemFeedback-label"><g:formatBoolean boolean="${feedbackInstance?.systemFeedback}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${feedbackInstance?.id}" />
					<g:link class="edit" action="edit" id="${feedbackInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
