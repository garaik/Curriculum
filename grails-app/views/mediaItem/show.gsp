<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Média elem adatai</title>
</head>

<body>
<div class="row curriculum">
<div class="small-12 columns">
    <h3>Média elem adatai</h3>
</div>
<g:if test="${flash.message}">
    <div class="small-12 columns">
        <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
    </div>
</g:if>
<div class="small-12 columns">
    <g:if test="${mediaItemInstance?.description}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="description-label" class="property-label"><g:message code="mediaItem.description.label" default="Leírás"/>:</span>

                <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${mediaItemInstance}" field="description"/></span>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.mediaType}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="mediaType-label" class="property-label"><g:message code="mediaItem.mediaType.label" default="Média típusa"/>:</span>

                <span class="property-value" aria-labelledby="mediaType-label"><g:fieldValue bean="${mediaItemInstance}" field="mediaType"/></span>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.instruction}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="instruction-label" class="property-label"><g:message code="mediaItem.instruction.label" default="Instrukció"/>:</span>

                <span class="property-value" aria-labelledby="instruction-label"><g:fieldValue bean="${mediaItemInstance}" field="instruction"/></span>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.answers}">
        <div class="row">
            <div class="large-12 columns" style="margin-top: 10px; margin-bottom: 10px">
                <span id="answers-label" class="property-label"><g:message code="mediaItem.answers.label" default="Válaszok"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.answers}" var="a">
                        <li><span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>

            </div>
        </div>
    </g:if>



    <g:if test="${mediaItemInstance?.exercises}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="exercises-label" class="property-label"><g:message code="mediaItem.exercises.label" default="Feladatok"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.exercises}" var="e">
                        <li><span class="property-value" aria-labelledby="exercises-label"><g:link controller="exercise" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.feedbacks}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="feedbacks-label" class="property-label"><g:message code="mediaItem.feedbacks.label" default="Visszajelzések"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.feedbacks}" var="f">
                        <li><span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>
            </div>
        </div>
    </g:if>



    <g:if test="${mediaItemInstance?.mapItems}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="mapItems-label" class="property-label"><g:message code="mediaItem.mapItems.label" default="Map Items"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.mapItems}" var="m">
                        <li><span class="property-value" aria-labelledby="mapItems-label"><g:link controller="mapItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.maps}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="maps-label" class="property-label"><g:message code="mediaItem.maps.label" default="Maps"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.maps}" var="m">
                        <li><span class="property-value" aria-labelledby="maps-label"><g:link controller="map" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>

            </div>
        </div>
    </g:if>

    <g:if test="${mediaItemInstance?.mediaFiles}">
    <div class="row">
        <div class="large-12 columns" style="margin-bottom: 10px">
            <span id="mediaFiles-label" class="property-label"><g:message code="mediaItem.mediaFiles.label" default="Média fájlok"/>:</span>

            <table style="width: 100%">
                <thead>
                <tr>
                    <th>Thumbnail</th>

                    <g:sortableColumn property="extension" title="${message(code: 'mediaFile.extension.label', default: 'Kiterjesztés')}"/>

                    <g:sortableColumn property="finalVersion" title="${message(code: 'mediaFile.finalVersion.label', default: 'Végső verzió')}"/>

                    <g:sortableColumn property="isIcon" title="${message(code: 'mediaFile.isIcon.label', default: 'Ikon')}"/>

                    <g:sortableColumn property="path" title="${message(code: 'mediaFile.path.label', default: 'Útvonal')}"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${mediaItemInstance?.mediaFiles?.sort { it.id } ?}" status="i" var="mediaFileInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:if test="${acceptableImages.contains(mediaFileInstance.extension)}">
                                <img src="${fieldValue(bean: mediaFileInstance, field: "path")}" width="100px">
                            </g:if>
                            <g:if test="${acceptableDocuments.contains(mediaFileInstance.extension)}">
                                <img src="${createLinkTo(dir: 'images/icons', file: 'document_image.png', absolute: true)}" alt="document_image.png" title="DOCUMENT" width="100px"/>
                            </g:if>
                            <g:if test="${acceptableVideos.contains(mediaFileInstance.extension)}">
                                <img src="${createLinkTo(dir: 'images/icons', file: 'video_image.png', absolute: true)}" alt="video_image.png" title="VIDEO" width="100px"/>
                            </g:if>
                            <g:if test="${acceptableSounds.contains(mediaFileInstance.extension)}">
                                <img src="${createLinkTo(dir: 'images/icons', file: 'music_image.png', absolute: true)}" alt="music_image.png" title="MUSIC" width="100px"/>
                            </g:if>
                        </td>
                        <td>${fieldValue(bean: mediaFileInstance, field: "extension")}</td>
                        <td><g:formatBoolean boolean="${mediaFileInstance.finalVersion}" true="Igen" false="Nem"/></td>
                        <td><g:formatBoolean boolean="${mediaFileInstance.isIcon}" true="Igen" false="Nem"/></td>
                        <td>${fieldValue(bean: mediaFileInstance, field: "path")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
    </g:if>


    <g:if test="${mediaItemInstance?.questions}">
        <div class="row">
            <div class="large-12 columns" style="margin-bottom: 10px">
                <span id="questions-label" class="property-label"><g:message code="mediaItem.questions.label" default="Kérdések"/>:</span>
                <ul style="list-style: none">
                    <g:each in="${mediaItemInstance.questions}" var="q">
                        <li><span class="property-value" aria-labelledby="questions-label"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span></li>
                    </g:each>
                </ul>

            </div>
        </div>
    </g:if>
    <g:form>
        <div class="row">
            <div class="small-12 columns">
                <g:hiddenField name="id" value="${mediaItemInstance?.id}"/>
                <g:link class="button small blue radius" action="edit" params="[questionId: questionId]" id="${mediaItemInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés"/></g:link>
                <g:if test="${mediaItemInstance?.id}">
                    <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                </g:if>
                <g:if test="${questionId}">
                    <g:link controller="question" action="edit" params="[id: questionId]" class="button small blue radius">Mégsem</g:link>
                </g:if>
                <g:if test="${feedbackId}">
                    <g:link controller="feedback" action="edit" params="[id: feedbackId]" class="button small blue radius">Mégsem</g:link>
                </g:if>
                <g:if test="${answerId}">
                    <g:link controller="answer" action="edit" params="[id: answerId]" class="button small blue radius">Mégsem</g:link>
                </g:if>
            </div>
        </div>
    </g:form>

</div>
</body>
</html>
