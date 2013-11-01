
<%@ page import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediaFile.label', default: 'MediaFile')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-mediaFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-mediaFile" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list mediaFile">
			
				<g:if test="${mediaFileInstance?.finalVersion}">
				<li class="fieldcontain">
					<span id="finalVersion-label" class="property-label"><g:message code="mediaFile.finalVersion.label" default="Final Version" /></span>
					
						<span class="property-value" aria-labelledby="finalVersion-label"><g:formatBoolean boolean="${mediaFileInstance?.finalVersion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaFileInstance?.isIcon}">
				<li class="fieldcontain">
					<span id="isIcon-label" class="property-label"><g:message code="mediaFile.isIcon.label" default="Is Icon" /></span>
					
						<span class="property-value" aria-labelledby="isIcon-label"><g:formatBoolean boolean="${mediaFileInstance?.isIcon}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaFileInstance?.mediaItem}">
				<li class="fieldcontain">
					<span id="mediaItem-label" class="property-label"><g:message code="mediaFile.mediaItem.label" default="Media Items" /></span>
					
						<span class="property-value" aria-labelledby="mediaItem-label"><g:link controller="mediaItem" action="show" id="${mediaFileInstance?.mediaItem?.id}">${mediaFileInstance?.mediaItem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaFileInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="mediaFile.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${mediaFileInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${mediaFileInstance?.id}" />
					<g:link class="edit" action="edit" id="${mediaFileInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
