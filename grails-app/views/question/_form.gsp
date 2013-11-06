<%@ page import="curriculum.Question" %>
<div class="row">
    <div class="small-12 columns">
        <%--<label for="exerciseId" class="${hasErrors(bean: questionInstance, field: 'exercise', 'error')}"><g:message code="question.exercise.label" default="Exercise"/>:</label>--%>
        <g:hiddenField name="exerciseId" value="${questionInstance?.exercise?.id}"></g:hiddenField>
        <%--<g:link controller="multipleChoiceExercise" action="show" id="${questionInstance.exercise.id}">${questionInstance.exercise.title}</g:link>--%>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="questionText" class="${hasErrors(bean: questionInstance, field: 'questionText', 'error')}"><g:message code="question.questionText.label" default="Kérdés szövege"/>:</label>
        <g:textField name="questionText" value="${questionInstance?.questionText}" class="${hasErrors(bean: questionInstance, field: 'questionText', 'error')}"/>
        <g:hasErrors bean="${questionInstance}" field="questionText">
            <small class="error"><g:fieldError bean="${questionInstance}" field="questionText"/></small>
        </g:hasErrors>
    </div>
</div>

<div class="row">
    <div class="small-3 columns">
        <label for="questionDisplayType" class="${hasErrors(bean: questionInstance, field: 'questionDisplayType', 'error')}"><g:message code="question.questionDisplayType.label" default="Kérdés megjelenítés típusa"/>:</label>
        <g:select id="questionDisplayType" name="questionDisplayType.id" from="${curriculum.QuestionDisplayType.list()}" optionKey="id" required="" noSelection="${[null: 'Kérem válasszon!']}"
                  value="${questionInstance?.questionDisplayType?.id}" class="many-to-one"/>

        <g:hasErrors bean="${questionInstance}" field="questionDisplayType">
            <small class="error"><g:fieldError bean="${questionInstance}" field="questionDisplayType"/></small>
        </g:hasErrors>
    </div>
</div>

<div class="row">
    <div class="small-3 columns">
        <label class="${hasErrors(bean: questionInstance, field: 'answers', 'error')}"><g:message code="question.answers.label" default="Válaszok"/>:</label>
        <ul style="list-style: none">
            <g:each in="${questionInstance?.answers ?}" var="a">
                <li><g:link controller="answer" action="edit" id="${a.id}">${a?.answerText}</g:link></li>
            </g:each>
        </ul>
        <g:actionSubmit action="addAnswer" name="addAnswer" class="button small blue radius" value="Új válasz"/>
    </div>
</div>

<div class="row">
    <div class="small-3 columns">
        <label class="${hasErrors(bean: questionInstance, field: 'feedbacks', 'error')}"><g:message code="question.feedbacks.label" default="Visszajelzések"/>:</label>
        <ul style="list-style: none">
            <g:each in="${questionInstance?.feedbacks ?}" var="f">
                <li><g:link controller="feedback" action="show" id="${f.id}">${f?.description}</g:link></li>
            </g:each>
        </ul>
        <g:actionSubmit action="addFeedback" name="addFeedback" class="button small blue radius" value="Új visszajelzés"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label class="${hasErrors(bean: questionInstance, field: 'mediaItems', 'error')}"><g:message code="question.mediaItems.label" default="Média elemek"/>:</label>
        <g:select name="mediaItems" from="${curriculum.MediaItem.list(sort: 'description')}" multiple="multiple" optionKey="id" size="5" value="${questionInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem"/>

    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <g:if test="${questionInstance?.mediaItems}">
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
                <g:each in="${questionInstance?.mediaItems?.sort { it.description } ?}" status="i" var="mediaItemInstance">
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
