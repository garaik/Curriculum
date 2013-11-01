
<%@ page import="curriculum.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'answer.label', default: 'Answer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-answer" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="answerText" title="${message(code: 'answer.answerText.label', default: 'Answer Text')}" />
					
						<g:sortableColumn property="isCorrect" title="${message(code: 'answer.isCorrect.label', default: 'Is Correct')}" />
					
						<th><g:message code="answer.nextQuestion.label" default="Next Question" /></th>
					
						<th><g:message code="answer.question.label" default="Question" /></th>
					
						<g:sortableColumn property="teacherInstruction" title="${message(code: 'answer.teacherInstruction.label', default: 'Teacher Instruction')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${answerInstanceList}" status="i" var="answerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${answerInstance.id}">${fieldValue(bean: answerInstance, field: "answerText")}</g:link></td>
					
						<td><g:formatBoolean boolean="${answerInstance.isCorrect}" /></td>
					
						<td>${fieldValue(bean: answerInstance, field: "nextQuestion")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "question")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "teacherInstruction")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${answerInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
