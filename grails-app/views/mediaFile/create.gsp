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


            <g:hiddenField name="returnId" value="${params.returnId}"/>
            <g:hiddenField name="returnAction" value="${params.returnAction}"/>
            <g:hiddenField name="returnController" value="${params.returnController}"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}"/>
                    <g:if test="params.mediaItemId != ''">
                        <g:set var="mediaItemId" value="${params.mediaItemId}"></g:set>
                    </g:if>
                    <g:else>
                        <g:set var="mediaItemId" value="${mediaFileInstance?.mediaItem?.id}"></g:set>
                    </g:else>
                    <g:link controller="mediaItem" action="edit" class="button small blue radius"
                            params="[id: mediaItemId, returnController: returnController, returnAction: returnAction, returnId: returnId ]">Mégsem</g:link>
                </div>
            </div>
        </g:uploadForm>
    </div>
</div>
</body>
</html>
