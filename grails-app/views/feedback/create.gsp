<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Visszajelzés létrehozása</title>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Visszajelzés létrehozása</h3>
    </div>

    <div class="small-12 columns">
        <g:form action="save">
            <g:if test="${params?.questionId}">
                <g:hiddenField name="questionId" value="${params?.questionId}"></g:hiddenField>
            </g:if>
            <g:if test="${params?.answerId}">
                <g:hiddenField name="answerId" value="${params?.answerId}"></g:hiddenField>
            </g:if>

            <g:render template="form"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}"/>
                    <g:if test="${params.questionId}">
                        <g:link controller="question" action="edit" params="[id: params.questionId]" class="button small blue radius">Mégsem</g:link>
                    </g:if>
                    <g:if test="${params.answerId}">
                        <g:link controller="answer" action="edit" params="[id: params.answerId]" class="button small blue radius">Mégsem</g:link>
                    </g:if>
                </div>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>
