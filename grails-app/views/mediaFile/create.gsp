<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Média fájl létrehozása</title>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Média fájl létrehozása</h3>
    </div>

    <div class="small-12 columns">

        <g:uploadForm action="save" method="post">

            <g:render template="form"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}"/>
                    <g:if test="params.mediaItemId != ''">
                        <g:set var="mediaItemId" value="${params.mediaItemId}"></g:set>
                    </g:if>
                    <g:else>
                        <g:set var="mediaItemId" value="${mediaFileInstance?.mediaItem?.id}"></g:set>
                    </g:else>
                    <g:if test="${params.pairingExerciseId}">
                        <g:hiddenField name="pairingExerciseId" value="${params.pairingExerciseId}"/>
                    </g:if>
                    <g:link controller="mediaItem" action="edit" params="[id: mediaItemId]" class="button small blue radius">Mégsem</g:link>
                </div>
            </div>
        </g:uploadForm>
    </div>
</div>
</body>
</html>
