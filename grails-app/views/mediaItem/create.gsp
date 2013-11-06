<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="app">
        <title>Média elem létrehozása</title>
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Média elem létrehozása</h3>
        </div>

        <div class="small-12 columns">
			<g:form action="save" >

		        <g:render template="form"/>

                <div class="row">
                    <div class="small-12 columns">
					    <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}" />
                        <g:if test="${questionId}">
                            <g:link controller="question" action="edit" params="[id: questionId]" class="button small blue radius">Mégsem</g:link>
                        </g:if>
                        <g:if test="${feedbackId}">
                            <g:link controller="feedback" action="edit" params="[id: feedbackId]" class="button small blue radius">Mégsem</g:link>
                        </g:if>
                        <g:if test="${answerId}">
                            <g:link controller="answer" action="edit" params="[id: answerId]" class="button small blue radius">Mégsem</g:link>
                        </g:if>
                    </div>
                </div>
			</g:form>
        </div>
    </div>
	</body>
</html>
