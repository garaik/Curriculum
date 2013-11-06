<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Média fájl szerkesztése</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Média fájl szerkesztése</h3>
    </div>

    <div class="small-12 columns">
        <g:uploadForm action="update" method="post">
            <g:hiddenField name="id" value="${mediaFileInstance?.id}"/>
            <g:hiddenField name="version" value="${mediaFileInstance?.version}"/>
            <g:render template="form"/>

            <g:hiddenField name="returnId" value="${params.returnId}"/>
            <g:hiddenField name="returnAction" value="${params.returnAction}"/>
            <g:hiddenField name="returnController" value="${params.returnController}"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:actionSubmit class="button small blue radius" action="update" value="${message(code: 'default.button.update.label', default: 'Mentés')}"/>
                    <g:if test="${mediaFileInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}" formnovalidate=""
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link controller="mediaItem" action="edit" params="[id: mediaFileInstance.mediaItem.id, returnController: returnController, returnAction: returnAction, returnId: returnId]" class="button small blue radius">Mégsem</g:link>
                </div>
            </div>
        </g:uploadForm>
    </div>
</div>
</body>
</html>
