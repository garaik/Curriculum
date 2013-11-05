<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Média fájl adatai</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Média fájl adatai</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">

        <g:if test="${mediaFileInstance?.extension}">
            <div class="row">
                <div class="large-12 columns" style="margin-top: 10px; margin-bottom: 10px">
                    <span id="extension-label" class="property-label"><g:message code="mediaFile.extension.label" default="Kiterjesztés"/></span>

                    <span class="property-value" aria-labelledby="extension-label"><g:fieldValue bean="${mediaFileInstance}" field="extension"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediaFileInstance?.finalVersion}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="finalVersion-label" class="property-label"><g:message code="mediaFile.finalVersion.label" default="Végső verzió"/></span>

                    <span class="property-value" aria-labelledby="finalVersion-label"><g:formatBoolean boolean="${mediaFileInstance?.finalVersion}"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediaFileInstance?.isIcon}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="isIcon-label" class="property-label"><g:message code="mediaFile.isIcon.label" default="Ikon"/></span>

                    <span class="property-value" aria-labelledby="isIcon-label"><g:formatBoolean boolean="${mediaFileInstance?.isIcon}"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediaFileInstance?.path}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="path-label" class="property-label"><g:message code="mediaFile.path.label" default="Útvonal"/></span>

                    <span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${mediaFileInstance}" field="path"/></span>

                </div>
            </div>
        </g:if>


        <g:form>
            <div class="row">
                <div class="small-12 columns">
                    <g:hiddenField name="id" value="${mediaFileInstance?.id}"/>
                    <g:link class="button small blue radius" action="edit" id="${mediaFileInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés"/></g:link>
                    <g:if test="${mediaFileInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link controller="mediaItem" action="edit" params="[id: mediaFileInstance.mediaItem.id]" class="button small blue radius">Mégsem</g:link>
                </div>
            </div>
        </g:form>
    </div>
</body>
</html>
