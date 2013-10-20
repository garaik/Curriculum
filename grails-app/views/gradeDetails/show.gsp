
<%@ page import="curriculum.GradeDetails" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gradeDetails.label', default: 'GradeDetails')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-gradeDetails" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-gradeDetails" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list gradeDetails">
			
				<g:if test="${gradeDetailsInstance?.grade}">
				<li class="fieldcontain">
					<span id="grade-label" class="property-label"><g:message code="gradeDetails.grade.label" default="Grade" /></span>
					
						<span class="property-value" aria-labelledby="grade-label"><g:link controller="grade" action="show" id="${gradeDetailsInstance?.grade?.id}">${gradeDetailsInstance?.grade?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${gradeDetailsInstance?.duration}">
				<li class="fieldcontain">
					<span id="duration-label" class="property-label"><g:message code="gradeDetails.duration.label" default="Duration" /></span>
					
						<span class="property-value" aria-labelledby="duration-label"><g:fieldValue bean="${gradeDetailsInstance}" field="duration"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${gradeDetailsInstance?.difficulty}">
				<li class="fieldcontain">
					<span id="difficulty-label" class="property-label"><g:message code="gradeDetails.difficulty.label" default="Difficulty" /></span>
					
						<span class="property-value" aria-labelledby="difficulty-label"><g:link controller="difficulty" action="show" id="${gradeDetailsInstance?.difficulty?.id}">${gradeDetailsInstance?.difficulty?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${gradeDetailsInstance?.exercise}">
				<li class="fieldcontain">
					<span id="exercise-label" class="property-label"><g:message code="gradeDetails.exercise.label" default="Exercise" /></span>
					
						<span class="property-value" aria-labelledby="exercise-label"><g:link controller="exercise" action="show" id="${gradeDetailsInstance?.exercise?.id}">${gradeDetailsInstance?.exercise?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${gradeDetailsInstance?.id}" />
					<g:link class="edit" action="edit" id="${gradeDetailsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
