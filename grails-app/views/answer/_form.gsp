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
                <li><g:link controller="feedback" action="show" id="${f.id}">${f?.description}</g:link></li>
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
        <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${answerInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem" />
        <ul style="list-style: none">
            <g:each in="${answerInstance?.mediaItems?}" var="m">
                <li><g:link controller="mediaItem" action="show" id="${m.id}">${m?.description}</g:link></li>
            </g:each>
        </ul>
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



