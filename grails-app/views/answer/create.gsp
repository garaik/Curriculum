<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="app">
        <title>Válasz létrehozása</title>
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
        <div class="row curriculum">
            <div class="small-12 columns">
                <h3>Válasz létrehozása</h3>
            </div>
            <div class="small-12 columns">
                <g:form action="save" >

                    <g:render template="form"/>
                    <div class="row">
                        <div class="small-12 columns">
                            <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}" />
                            <g:link controller="question" action="edit" params="[id: answerInstance.question.id]" class="button small blue radius">Mégsem</g:link>
                        </div>
                    </div>
                </g:form>
            </div>
		</div>
	</body>
</html>