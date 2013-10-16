<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Tevékenység szerkesztése</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Tevékenység szerkesztése</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">
        <form action="<g:createLink action="update"/>" id="activityEditForm" method="post">
            <input type="hidden" name="id" value="${instance.id}"/>
            <input type="hidden" name="version" value="${instance.version}"/>
            <g:render template="activity_form"/>
            <div class="row">
                <div class="small-12 columns">
                    <a href="" class="button small blue radius" onclick="document.getElementById('activityEditForm').submit(); return false;">Mentés</a>
                    <a href="<g:createLink action="list"/>" class="button small blue radius">Mégsem</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>