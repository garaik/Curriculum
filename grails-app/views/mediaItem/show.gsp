
<%@ page import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediaItem.label', default: 'MediaItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-mediaItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-mediaItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list mediaItem">
			
				<g:if test="${mediaItemInstance?.answers}">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label"><g:message code="mediaItem.answers.label" default="Answers" /></span>
					
						<g:each in="${mediaItemInstance.answers}" var="a">
						<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="mediaItem.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${mediaItemInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.exercises}">
				<li class="fieldcontain">
					<span id="exercises-label" class="property-label"><g:message code="mediaItem.exercises.label" default="Exercises" /></span>
					
						<g:each in="${mediaItemInstance.exercises}" var="e">
						<span class="property-value" aria-labelledby="exercises-label"><g:link controller="exercise" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.feedbacks}">
				<li class="fieldcontain">
					<span id="feedbacks-label" class="property-label"><g:message code="mediaItem.feedbacks.label" default="Feedbacks" /></span>
					
						<g:each in="${mediaItemInstance.feedbacks}" var="f">
						<span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.instruction}">
				<li class="fieldcontain">
					<span id="instruction-label" class="property-label"><g:message code="mediaItem.instruction.label" default="Instruction" /></span>
					
						<span class="property-value" aria-labelledby="instruction-label"><g:fieldValue bean="${mediaItemInstance}" field="instruction"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.mapItems}">
				<li class="fieldcontain">
					<span id="mapItems-label" class="property-label"><g:message code="mediaItem.mapItems.label" default="Map Items" /></span>
					
						<g:each in="${mediaItemInstance.mapItems}" var="m">
						<span class="property-value" aria-labelledby="mapItems-label"><g:link controller="mapItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.maps}">
				<li class="fieldcontain">
					<span id="maps-label" class="property-label"><g:message code="mediaItem.maps.label" default="Maps" /></span>
					
						<g:each in="${mediaItemInstance.maps}" var="m">
						<span class="property-value" aria-labelledby="maps-label"><g:link controller="map" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.mediaFiles}">
				<li class="fieldcontain">
					<span id="mediaFiles-label" class="property-label"><g:message code="mediaItem.mediaFiles.label" default="Media Files" /></span>
					
						<g:each in="${mediaItemInstance.mediaFiles}" var="m">
						<span class="property-value" aria-labelledby="mediaFiles-label"><g:link controller="mediaFile" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.mediaType}">
				<li class="fieldcontain">
					<span id="mediaType-label" class="property-label"><g:message code="mediaItem.mediaType.label" default="Media Type" /></span>
					
						<span class="property-value" aria-labelledby="mediaType-label"><g:fieldValue bean="${mediaItemInstance}" field="mediaType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mediaItemInstance?.questions}">
				<li class="fieldcontain">
					<span id="questions-label" class="property-label"><g:message code="mediaItem.questions.label" default="Questions" /></span>
					
						<g:each in="${mediaItemInstance.questions}" var="q">
						<span class="property-value" aria-labelledby="questions-label"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${mediaItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${mediaItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
