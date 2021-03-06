<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Média fájl szerkesztése</title>
</head>

<body>
<div class="row curriculum">
    <p>${session.getAttribute("breadCrumbs")}</p>
    <div class="small-12 columns">
        <h3>Média fájl szerkesztése</h3>
    </div>

    <div class="small-12 columns">
        <g:uploadForm action="update" method="post">
            <g:hiddenField name="id" value="${mediaFileInstance?.id}"/>
            <g:hiddenField name="version" value="${mediaFileInstance?.version}"/>
            <g:render template="form"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:actionSubmit class="button small blue radius" action="update" value="${message(code: 'default.button.update.label', default: 'Mentés')}"/>
                    <g:if test="${mediaFileInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}" formnovalidate=""
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link action="cancelAfterSave" class="button small blue radius" params="[instandceId: mediaFileInstance?.id]">Mégsem</g:link>
                </div>
            </div>
        </g:uploadForm>
    </div>
</div>
</body>
</html>
