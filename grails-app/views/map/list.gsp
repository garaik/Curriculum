
<%@ page import="curriculum.Map" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'map.label', default: 'Map')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-map" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-map" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="map.exercise.label" default="Exercise" /></th>
					
						<g:sortableColumn property="exerciseType" title="${message(code: 'map.exerciseType.label', default: 'Exercise Type')}" />
					
						<th><g:message code="map.question.label" default="Question" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mapInstanceList}" status="i" var="mapInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mapInstance.id}">${fieldValue(bean: mapInstance, field: "exercise")}</g:link></td>
					
						<td>${fieldValue(bean: mapInstance, field: "exerciseType")}</td>
					
						<td>${fieldValue(bean: mapInstance, field: "question")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mapInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
