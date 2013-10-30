<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Párosítós feladat szerkesztése</title>
</head>
<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Párosítós feladat szerkesztése</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error?'alert':'success'} radius"><i class="${flash.error?'icon-exclamation':'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">
        <%-- the form id to submit with the ajax link --%>
        <g:set value="createForm" var="formId"/>
        <%-- the element id to refresh the page wit the ajax response --%>
	    <g:set value="elementToReplace" var="elementToReplace"/>
        <form action="<g:createLink action="update" />" id="createForm" method="post" class="custom" name="${formId}">
            <input type="hidden" name="id" value="${instance.id}" />
            <input type="hidden" name="version" value="${instance.version}" />
            <fieldset class="form" id="${elementToReplace}">
                <g:render template="/exercise/exercise_form" id="${elementToReplace}"/>
            </fieldset>
            <fieldset class="form">
                <g:render template="/pairingExercise/pairing_form"/>
            </fieldset>
            <div class="row">
                <div class="small-12 columns">
                    <a href="" class="button small blue radius" onclick="document.getElementById('createForm').submit(); return false;">Mentés</a>
                    <a href="<g:createLink action="list" />" class="button small blue radius">Mégsem</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>