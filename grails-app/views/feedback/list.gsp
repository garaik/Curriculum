
<%@ page import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'feedback.label', default: 'Feedback')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-feedback" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-feedback" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="correct" title="${message(code: 'feedback.correct.label', default: 'Correct')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'feedback.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="systemFeedback" title="${message(code: 'feedback.systemFeedback.label', default: 'System Feedback')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${feedbackInstanceList}" status="i" var="feedbackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${feedbackInstance.id}">${fieldValue(bean: feedbackInstance, field: "correct")}</g:link></td>
					
						<td>${fieldValue(bean: feedbackInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${feedbackInstance.systemFeedback}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${feedbackInstanceTotal}" />
			</div>
		</div>
	</body>
</html>