<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Feladat létrehozása</title>
</head>
<body>
    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Feladat létrehozása</h3>
        </div>

        <div class="small-12 columns">
        <%-- the form id to submit with the ajax link --%>
        <g:set value="createForm" var="formId"/>
        <%-- the element id to refresh the page wit the ajax response --%>
        <g:set value="elementToReplace" var="elementToReplace"/>
            <form action="<g:createLink action="save" />" method="post" id="createForm" class="custom" name="${formId}">
                <fieldset class="form" id="${elementToReplace}">
                    <g:render template="exercise_form" id="${elementToReplace}"/>
                </fieldset>
                <div class="row">
                    <div class="small-12 columns">
                        <a href="" class="button small blue radius" onclick="document.getElementById('createForm').submit(); return false;">Létrehozás</a>
                        <a href="<g:createLink action="list" />" class="button small blue radius">Mégsem</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
