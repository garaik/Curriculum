<%@ page import="curriculum.Question" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'exercise', 'error')} ">
    <label for="exercise">
        <g:message code="question.exercise.label" default="Exercise" />

    </label>
    <g:hiddenField name="exerciseId" value="${questionInstance.exercise.id}"></g:hiddenField>
    <g:link controller="multipleChoiceExercise" action="show" id="${questionInstance.exercise.id}">${questionInstance.exercise.title}</g:link>
</div>


<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'questionText', 'error')} ">
    <label for="questionText">
		<g:message code="question.questionText.label" default="Question Text" />

	</label>
    <g:textField name="questionText" value="${questionInstance?.questionText}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'questionDisplayType', 'error')} required">
    <label for="questionDisplayType">
		<g:message code="question.questionDisplayType.label" default="Question Display Type" />
		<span class="required-indicator">*</span>
	</label>
    <g:select id="questionDisplayType" name="questionDisplayType.id" from="${curriculum.QuestionDisplayType.list()}" optionKey="id" required="" noSelection="${[null:'Kérem válasszon!']}" value="${questionInstance?.questionDisplayType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answers', 'error')} ">
    <label for="answers">
        <g:message code="question.answers.label" default="Answers" />

    </label>

    <ul class="one-to-many">
        <g:each in="${questionInstance?.answers?}" var="a">
            <li><g:link controller="answer" action="show" id="${a.id}">${a?.answerText}</g:link></li>
        </g:each>
        <li class="add">
            <g:actionSubmit action="addAnswer" name="addAnswer" class="edit" value="Add answer" />
        </li>
    </ul>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'feedbacks', 'error')} ">
    <label for="feedbacks">
        <g:message code="question.feedbacks.label" default="Feedbacks" />

    </label>
    <ul class="one-to-many">
        <g:each in="${questionInstance?.feedbacks?}" var="f">
            <li><g:link controller="feedback" action="show" id="${f.id}">${f?.description}</g:link></li>
        </g:each>
        <li class="add">
            <g:actionSubmit action="addFeedback" name="addFeedback" class="edit" value="Add feedback" />
        </li>
    </ul>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'mediaItems', 'error')} ">
    <label for="mediaItems">
        <g:message code="question.mediaItems.label" default="Media Items" />

    </label>
    <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${questionInstance?.mediaItems*.id}" class="many-to-many"/>
    <g:actionSubmit action="addMediaItem" name="addMediaItem" class="edit" value="Add media item" />
    <ul>
        <g:each in="${questionInstance?.mediaItems?}" var="m">
            <li><g:link controller="mediaItem" action="show" id="${m.id}">${m?.description}</g:link></li>
        </g:each>
    </ul>
</div>


