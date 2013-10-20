
<%@ page import="curriculum.GradeDetails" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gradeDetails.label', default: 'GradeDetails')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-gradeDetails" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-gradeDetails" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="gradeDetails.grade.label" default="Grade" /></th>
					
						<g:sortableColumn property="duration" title="${message(code: 'gradeDetails.duration.label', default: 'Duration')}" />
					
						<th><g:message code="gradeDetails.difficulty.label" default="Difficulty" /></th>
					
						<th><g:message code="gradeDetails.exercise.label" default="Exercise" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${gradeDetailsInstanceList}" status="i" var="gradeDetailsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${gradeDetailsInstance.id}">${fieldValue(bean: gradeDetailsInstance, field: "grade")}</g:link></td>
					
						<td>${fieldValue(bean: gradeDetailsInstance, field: "duration")}</td>
					
						<td>${fieldValue(bean: gradeDetailsInstance, field: "difficulty")}</td>
					
						<td>${fieldValue(bean: gradeDetailsInstance, field: "exercise")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${gradeDetailsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
