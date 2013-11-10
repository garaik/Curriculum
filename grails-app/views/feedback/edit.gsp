<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Visszajelzés szerkesztése</title>
</head>

<body>
<div class="row curriculum">
    <p>${session.getAttribute("breadCrumbs")}</p>
    <div class="small-12 columns">
        <h3>Visszajelzés szerkesztése</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">

        <g:form method="post">
            <g:hiddenField name="id" value="${feedbackInstance?.id}"/>
            <g:hiddenField name="version" value="${feedbackInstance?.version}"/>

            <g:render template="form"/>

            <div class="row">
                <div class="small-12 columns">
                    <g:actionSubmit class="button small blue radius" action="update" value="${message(code: 'default.button.update.label', default: 'Mentés')}"/>
                    <g:if test="${feedbackInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}" formnovalidate=""
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link action="cancelAfterSave" class="button small blue radius" params="[instandceId: feedbackInstance?.id]">Mégsem</g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>
