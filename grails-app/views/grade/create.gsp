<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Évfolyam létrehozása</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Évfolyam létrehozása</h3>
    </div>

    <div class="small-12 columns">
        <form action="<g:createLink action="save"/>" id="gradeCreateForm">
            <g:render template="grade_form"/>
            <div class="row">
                <div class="small-12 columns">
                    <a href="" class="button small blue radius" onclick="document.getElementById('gradeCreateForm').submit();
                    return false;">Létrehozás</a>
                    <a href="<g:createLink action="list"/>" class="button small blue radius">Mégsem</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>