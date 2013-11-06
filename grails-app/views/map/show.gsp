
<%@ page import="curriculum.Map" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'map.label', default: 'Map')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-map" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-map" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list map">
			
				<g:if test="${mapInstance?.exercise}">
				<li class="fieldcontain">
					<span id="exercise-label" class="property-label"><g:message code="map.exercise.label" default="Exercise" /></span>
					
						<span class="property-value" aria-labelledby="exercise-label"><g:link controller="pairingExercise" action="show" id="${mapInstance?.exercise?.id}">${mapInstance?.exercise?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${mapInstance?.exerciseType}">
				<li class="fieldcontain">
					<span id="exerciseType-label" class="property-label"><g:message code="map.exerciseType.label" default="Exercise Type" /></span>
					
						<span class="property-value" aria-labelledby="exerciseType-label"><g:fieldValue bean="${mapInstance}" field="exerciseType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mapInstance?.mapAreas}">
				<li class="fieldcontain">
					<span id="mapAreas-label" class="property-label"><g:message code="map.mapAreas.label" default="Map Areas" /></span>
					
						<g:each in="${mapInstance.mapAreas}" var="m">
						<span class="property-value" aria-labelledby="mapAreas-label"><g:link controller="mapArea" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mapInstance?.mapItems}">
				<li class="fieldcontain">
					<span id="mapItems-label" class="property-label"><g:message code="map.mapItems.label" default="Map Items" /></span>
					
						<g:each in="${mapInstance.mapItems}" var="m">
						<span class="property-value" aria-labelledby="mapItems-label"><g:link controller="mapItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mapInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="map.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:link controller="question" action="show" id="${mapInstance?.question?.id}">${mapInstance?.question?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${mapInstance?.id}" />
					<g:link class="edit" action="edit" id="${mapInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
