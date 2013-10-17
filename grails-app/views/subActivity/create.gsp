<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Al-tevékenység létrehozása</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Al-tevékenység létrehozása</h3>
    </div>

    <div class="small-12 columns">
        <form action="<g:createLink action="save"/>" id="subactivityCreateForm">
            <g:render template="subactivity_form"/>
            <div class="row">
                <div class="small-12 columns">
                    <a href="" class="button small blue radius" onclick="document.getElementById('subactivityCreateForm').submit();
                    return false;">Létrehozás</a>
                    <a href="<g:createLink action="list"/>" class="button small blue radius">Mégsem</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>