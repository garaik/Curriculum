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
                <li><g:link controller="answer" action="show" id="${a.id}">${a?.answerText}</g:link></li>
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
        <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${questionInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem"/>
        <ul style="list-style: none">
            <g:each in="${questionInstance?.mediaItems ?}" var="m">
                <li><g:link controller="mediaItem" action="show" params="[questionId: questionInstance.id]" id="${m.id}">${m?.description}</g:link></li>
            </g:each>
        </ul>
    </div>
</div>
