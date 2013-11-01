
<%@ page import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediaItem.label', default: 'MediaItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mediaItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mediaItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'mediaItem.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="instruction" title="${message(code: 'mediaItem.instruction.label', default: 'Instruction')}" />
					
						<g:sortableColumn property="mediaType" title="${message(code: 'mediaItem.mediaType.label', default: 'Media Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mediaItemInstanceList}" status="i" var="mediaItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mediaItemInstance.id}">${fieldValue(bean: mediaItemInstance, field: "description")}</g:link></td>
					
						<td>${fieldValue(bean: mediaItemInstance, field: "instruction")}</td>
					
						<td>${fieldValue(bean: mediaItemInstance, field: "mediaType")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mediaItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
