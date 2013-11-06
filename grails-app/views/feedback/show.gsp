<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Visszajelzés adatai</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Visszajelzés adatai</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">

        <g:if test="${feedbackInstance?.description}">
            <div class="row">
                <div class="large-12 columns" style="margin-top: 10px; margin-bottom: 10px">
                    <span id="description-label" class="property-label"><g:message code="feedback.description.label" default="Leírás"/>:</span>

                    <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${feedbackInstance}" field="description"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${feedbackInstance?.correct}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="correct-label" class="property-label"><g:message code="feedback.correct.label" default="Helyes"/>:</span>

                    <span class="property-value" aria-labelledby="correct-label"><g:formatBoolean boolean="${feedbackInstance?.correct}" true="Igen" false="Nem"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${feedbackInstance?.systemFeedback}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="systemFeedback-label" class="property-label"><g:message code="feedback.systemFeedback.label" default="Rendszer visszajelzés"/>:</span>

                    <span class="property-value" aria-labelledby="systemFeedback-label"><g:formatBoolean boolean="${feedbackInstance?.systemFeedback}" true="Igen" false="Nem"/></span>

                </div>
            </div>
        </g:if>


        <g:if test="${feedbackInstance?.questions}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="questions-label" class="property-label"><g:message code="feedback.questions.label" default="Kérdések"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${feedbackInstance.questions}" var="q">
                            <li><span class="property-value" aria-labelledby="questions-label"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>

                </div>
            </div>
        </g:if>

        <g:if test="${feedbackInstance?.answers}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="answers-label" class="property-label"><g:message code="feedback.answers.label" default="Válaszok"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${feedbackInstance.answers}" var="a">
                            <li><span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>

                </div>
            </div>
        </g:if>

        <div class="row">
            <div class="small-12 columns">
                <g:if test="${feedbackInstance?.mediaItems}">
                    <span id="mediaItems-label" class="property-label"><g:message code="feedback.mediaItems.label" default="Média elemek"/>:</span>
                    <table style="width: 100%">
                        <thead>
                        <tr>
                            <th>Thumbnail</th>

                            <g:sortableColumn property="description" title="${message(code: 'mediaItem.description.label', default: 'Leírás')}"/>
                            <g:sortableColumn property="instruction" title="${message(code: 'mediaItem.instruction.label', default: 'Instrukció')}"/>

                            <th class="operations">Műveletek</th>

                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${feedbackInstance?.mediaItems ?}" status="i" var="mediaItemInstance">
                            <g:each in="${mediaItemInstance?.mediaFiles?.sort { it.id } ?}" status="j" var="mediaFileInstance">
                                <g:if test="${mediaFileInstance.finalVersion}">
                                    <g:set var="mediaFileInstanceToDisplay" value="${mediaFileInstance}"/>
                                </g:if>
                            </g:each>
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td>
                                    <g:if test="${acceptableImages?.contains(mediaFileInstanceToDisplay?.extension)}">
                                        <img src="${mediaFileInstanceToDisplay.path}" width="100px">
                                    </g:if>
                                    <g:if test="${acceptableDocuments?.contains(mediaFileInstanceToDisplay?.extension)}">
                                        <img src="${createLinkTo(dir: 'images/icons', file: 'document_image.png', absolute: true)}" alt="document_image.png" title="DOCUMENT" width="100px"/>
                                    </g:if>
                                    <g:if test="${acceptableVideos?.contains(mediaFileInstanceToDisplay?.extension)}">
                                        <img src="${createLinkTo(dir: 'images/icons', file: 'video_image.png', absolute: true)}" alt="video_image.png" title="VIDEO" width="100px"/>
                                    </g:if>
                                    <g:if test="${acceptableSounds?.contains(mediaFileInstanceToDisplay?.extension)}">
                                        <img src="${createLinkTo(dir: 'images/icons', file: 'music_image.png', absolute: true)}" alt="music_image.png" title="MUSIC" width="100px"/>
                                    </g:if>
                                </td>
                                <td>${fieldValue(bean: mediaItemInstance, field: "description")}</td>
                                <td>${fieldValue(bean: mediaItemInstance, field: "instruction")}</td>
                                <td class="operations">
                                    <g:link controller="mediaItem" action="edit" id="${mediaItemInstance.id}" title="Szerkesztés"><i class="icon-pencil"></i></g:link>

                                </td>

                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>

            </div>
        </div>

        <g:form>
            <div class="row">
                <div class="small-12 columns">
                    <g:hiddenField name="id" value="${feedbackInstance?.id}"/>
                    <g:link class="button small blue radius" action="edit" id="${feedbackInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés"/></g:link>
                    <g:if test="${feedbackInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                </div>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>
