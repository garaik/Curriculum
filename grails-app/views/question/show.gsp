
<%@ page import="curriculum.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-question" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list question">
			
				<g:if test="${questionInstance?.questionText}">
				<li class="fieldcontain">
					<span id="questionText-label" class="property-label"><g:message code="question.questionText.label" default="Question Text" /></span>
					
						<span class="property-value" aria-labelledby="questionText-label"><g:fieldValue bean="${questionInstance}" field="questionText"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.questionDisplayType}">
				<li class="fieldcontain">
					<span id="questionDisplayType-label" class="property-label"><g:message code="question.questionDisplayType.label" default="Question Display Type" /></span>
					
						<span class="property-value" aria-labelledby="questionDisplayType-label"><g:link controller="questionDisplayType" action="show" id="${questionInstance?.questionDisplayType?.id}">${questionInstance?.questionDisplayType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.previousAnswers}">
				<li class="fieldcontain">
					<span id="previousAnswers-label" class="property-label"><g:message code="question.previousAnswers.label" default="Previous Answers" /></span>
					
						<g:each in="${questionInstance.previousAnswers}" var="p">
						<span class="property-value" aria-labelledby="previousAnswers-label"><g:link controller="answerNextQuestion" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.exercise}">
				<li class="fieldcontain">
					<span id="exercise-label" class="property-label"><g:message code="question.exercise.label" default="Exercise" /></span>
					
						<span class="property-value" aria-labelledby="exercise-label"><g:link controller="multipleChoiceExercise" action="show" id="${questionInstance?.exercise?.id}">${questionInstance?.exercise?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.answers}">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label"><g:message code="question.answers.label" default="Answers" /></span>
					
						<g:each in="${questionInstance.answers}" var="a">
						<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.mediaItems}">
				<li class="fieldcontain">
					<span id="mediaItems-label" class="property-label"><g:message code="question.mediaItems.label" default="Media Items" /></span>
					
						<g:each in="${questionInstance.mediaItems}" var="m">
						<span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.feedbacks}">
				<li class="fieldcontain">
					<span id="feedbacks-label" class="property-label"><g:message code="question.feedbacks.label" default="Feedbacks" /></span>
					
						<g:each in="${questionInstance.feedbacks}" var="f">
						<span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${questionInstance?.id}" />
					<g:link class="edit" action="edit" id="${questionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
