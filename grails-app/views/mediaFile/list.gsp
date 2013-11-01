
<%@ page import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediaFile.label', default: 'MediaFile')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mediaFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mediaFile" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="finalVersion" title="${message(code: 'mediaFile.finalVersion.label', default: 'Final Version')}" />
					
						<g:sortableColumn property="isIcon" title="${message(code: 'mediaFile.isIcon.label', default: 'Is Icon')}" />
					
						<th><g:message code="mediaFile.mediaItem.label" default="Media Items" /></th>
					
						<g:sortableColumn property="path" title="${message(code: 'mediaFile.path.label', default: 'Path')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mediaFileInstanceList}" status="i" var="mediaFileInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mediaFileInstance.id}">${fieldValue(bean: mediaFileInstance, field: "finalVersion")}</g:link></td>
					
						<td><g:formatBoolean boolean="${mediaFileInstance.isIcon}" /></td>
					
						<td>${fieldValue(bean: mediaFileInstance, field: "mediaItem")}</td>
					
						<td>${fieldValue(bean: mediaFileInstance, field: "path")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mediaFileInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
