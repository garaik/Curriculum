
<%@ page import="curriculum.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'answer.label', default: 'Answer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-answer" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list answer">
			
				<g:if test="${answerInstance?.answerText}">
				<li class="fieldcontain">
					<span id="answerText-label" class="property-label"><g:message code="answer.answerText.label" default="Answer Text" /></span>
					
						<span class="property-value" aria-labelledby="answerText-label"><g:fieldValue bean="${answerInstance}" field="answerText"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.feedbacks}">
				<li class="fieldcontain">
					<span id="feedbacks-label" class="property-label"><g:message code="answer.feedbacks.label" default="Feedbacks" /></span>
					
						<g:each in="${answerInstance.feedbacks}" var="f">
						<span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.isCorrect}">
				<li class="fieldcontain">
					<span id="isCorrect-label" class="property-label"><g:message code="answer.isCorrect.label" default="Is Correct" /></span>
					
						<span class="property-value" aria-labelledby="isCorrect-label"><g:formatBoolean boolean="${answerInstance?.isCorrect}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.mediaItems}">
				<li class="fieldcontain">
					<span id="mediaItems-label" class="property-label"><g:message code="answer.mediaItems.label" default="Media Items" /></span>
					
						<g:each in="${answerInstance.mediaItems}" var="m">
						<span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.nextQuestion}">
				<li class="fieldcontain">
					<span id="nextQuestion-label" class="property-label"><g:message code="answer.nextQuestion.label" default="Next Question" /></span>
					
						<span class="property-value" aria-labelledby="nextQuestion-label"><g:link controller="question" action="show" id="${answerInstance?.nextQuestion?.nextQuestion?.id}">${answerInstance?.nextQuestion?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="answer.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:link controller="question" action="show" id="${answerInstance?.question?.id}">${answerInstance?.question?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.teacherInstruction}">
				<li class="fieldcontain">
					<span id="teacherInstruction-label" class="property-label"><g:message code="answer.teacherInstruction.label" default="Teacher Instruction" /></span>
					
						<span class="property-value" aria-labelledby="teacherInstruction-label"><g:fieldValue bean="${answerInstance}" field="teacherInstruction"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${answerInstance?.id}" />
					<g:link class="edit" action="edit" id="${answerInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
