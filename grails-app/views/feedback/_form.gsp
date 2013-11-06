<%@ page import="curriculum.Feedback" %>

<div class="row">
    <div class="small-12 columns">
        <label for="correct" class="${hasErrors(bean: feedbackInstance, field: 'correct', 'error')}">
            <g:message code="feedback.correct.label" default="Helyes"/>
        </label>
        <g:checkBox name="correct" value="${feedbackInstance?.correct}"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">

        <label for="systemFeedback" class="${hasErrors(bean: feedbackInstance, field: 'systemFeedback', 'error')}">
            <g:message code="feedback.systemFeedback.label" default="Rendszer visszajelzés"/>

        </label>
        <g:checkBox name="systemFeedback" value="${feedbackInstance?.systemFeedback}"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="description" class="${hasErrors(bean: feedbackInstance, field: 'description', 'error')}">
            <g:message code="feedback.description.label" default="Leírás"/>

        </label>
        <g:textField name="description" value="${feedbackInstance?.description}"/>
        <g:hasErrors bean="${feedbackInstance}" field="description">
            <small class="error"><g:fieldError bean="${feedbackInstance}" field="description"/></small>
        </g:hasErrors>
        <g:if test="${flash.message}">
            <small class="error" role="status">${flash.message}</small>
        </g:if>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">

        <label for="mediaItems" class="${hasErrors(bean: feedbackInstance, field: 'mediaItems', 'error')}">
            <g:message code="feedback.mediaItems.label" default="Média Elemek"/>

        </label>
        <g:select name="mediaItems" from="${curriculum.MediaItem.list(sort: 'description')}" multiple="multiple" optionKey="id" size="5" value="${feedbackInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <g:if test="${feedbackInstance?.mediaItems}">
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


