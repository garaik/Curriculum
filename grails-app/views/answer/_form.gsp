<%@ page import="curriculum.Question; curriculum.Answer" %>

<div class="row">
    <div class="small-12 columns">
        <%--<label for="question" class="${hasErrors(bean: answerInstance, field: 'question', 'error')}"><g:message code="answer.question.label" default="Question" /></label>--%>
        <g:hiddenField name="questionId" value="${answerInstance?.question?.id}"></g:hiddenField>
        <%--<g:link name="question" controller="question" action="show" id="${answerInstance.question.id}">${answerInstance.question.questionText}</g:link>--%>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="answerText" class="${hasErrors(bean: answerInstance, field: 'answerText', 'error')}">
            <g:message code="answer.answerText.label" default="Válasz szövege" />
        </label>
        <g:textField name="answerText" value="${answerInstance?.answerText}"/>
        <g:hasErrors bean="${answerInstance}" field="answerText">
            <small class="error"><g:fieldError bean="${answerInstance}" field="answerText"/></small>
        </g:hasErrors>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="teacherInstruction" class="${hasErrors(bean: answerInstance, field: 'teacherInstruction', 'error')}">
            <g:message code="answer.teacherInstruction.label" default="Tanári instrukció" />
        </label>
        <g:textField name="teacherInstruction" value="${answerInstance?.teacherInstruction}"/>
        <g:hasErrors bean="${answerInstance}" field="teacherInstruction">
            <small class="error"><g:fieldError bean="${answerInstance}" field="teacherInstruction"/></small>
        </g:hasErrors>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="isCorrect" class="${hasErrors(bean: answerInstance, field: 'isCorrect', 'error')}">
            <g:message code="answer.isCorrect.label" default="Helyes" />
        </label>
        <g:checkBox name="isCorrect" value="${answerInstance?.isCorrect}" />
        <g:hasErrors bean="${answerInstance}" field="isCorrect">
            <small class="error"><g:fieldError bean="${answerInstance}" field="isCorrect"/></small>
        </g:hasErrors>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="feedbacks" class="${hasErrors(bean: answerInstance, field: 'feedbacks', 'error')}">
            <g:message code="answer.feedbacks.label" default="Visszajelzések" />
        </label>
        <ul style="list-style: none">
            <g:each in="${answerInstance?.feedbacks?}" var="f">
                <li><g:link controller="feedback" action="edit" id="${f.id}">${f?.description}</g:link></li>
            </g:each>
        </ul>
        <g:actionSubmit action="addFeedback" name="addFeedback" class="button small blue radius" value="Új visszajelzés"/>

    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="mediaItems" class="${hasErrors(bean: answerInstance, field: 'mediaItems', 'error')}">
            <g:message code="answer.mediaItems.label" default="Média elemek" />
        </label>
        <g:select name="mediaItems" from="${curriculum.MediaItem.list(sort: 'description')}" multiple="multiple" optionKey="id" size="5" value="${answerInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem" />
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <g:if test="${answerInstance?.mediaItems}">
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
                <g:each in="${answerInstance?.mediaItems ?}" status="i" var="mediaItemInstance">
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

<div class="row">
    <div class="small-12 columns">
        <label for="nextQuestion" class="${hasErrors(bean: answerInstance, field: 'nextQuestion', 'error')}">
            <g:message code="answer.nextQuestion.label" default="Következő kérdés" />
        </label>
        <g:select id="nextQuestion" name="nextQuestionId" noSelection="${[null:'Kérem válasszon!']}" from="${nextQuestionList}" optionKey="id" required="" value="${answerInstance?.nextQuestion?.nextQuestion?.id}" class="many-to-one"/>
        <g:hasErrors bean="${answerInstance}" field="nextQuestionId">
            <small class="error"><g:fieldError bean="${answerInstance}" field="nextQuestionId"/></small>
        </g:hasErrors>
    </div>
</div>



