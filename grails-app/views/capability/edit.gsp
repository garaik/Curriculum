<%--
  Created by IntelliJ IDEA.
  User: DullB
  Date: 2013.10.20.
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Képességfókusz szerkesztése</title>
</head>
<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Képességfókusz szerkesztése</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error?'alert':'success'} radius"><i class="${flash.error?'icon-exclamation':'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">
        <form action="<g:createLink action="update" />" id="capabilityEditForm" method="post">
            <input type="hidden" name="id" value="${instance.id}" />
            <input type="hidden" name="version" value="${instance.version}" />
            <g:render template="capability_form" />
            <div class="row">
                <div class="small-12 columns">
                    <a href="" class="button small blue radius" onclick="document.getElementById('capabilityEditForm').submit(); return false;">Mentés</a>
                    <a href="<g:createLink action="list" />" class="button small blue radius">Mégsem</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
