<%@ page import="curriculum.Question; curriculum.Answer" %>


<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'question', 'error')} required">
    <label for="question">
        <g:message code="answer.question.label" default="Question" />
    </label>
    <g:hiddenField name="questionId" value="${answerInstance?.question?.id}"></g:hiddenField>
    <g:link name="question" controller="question" action="show" id="${answerInstance.question.id}">${answerInstance.question.questionText}</g:link>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'answerText', 'error')} ">
	<label for="answerText">
		<g:message code="answer.answerText.label" default="Answer Text" />
		
	</label>
	<g:textField name="answerText" value="${answerInstance?.answerText}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'teacherInstruction', 'error')} ">
    <label for="teacherInstruction">
        <g:message code="answer.teacherInstruction.label" default="Teacher Instruction" />

    </label>
    <g:textField name="teacherInstruction" value="${answerInstance?.teacherInstruction}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'isCorrect', 'error')} ">
    <label for="isCorrect">
        <g:message code="answer.isCorrect.label" default="Is Correct" />

    </label>
    <g:checkBox name="isCorrect" value="${answerInstance?.isCorrect}" />
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'feedbacks', 'error')} ">
    <label for="feedbacks">
        <g:message code="answer.feedbacks.label" default="Feedbacks" />

    </label>
    <ul class="one-to-many">
        <g:each in="${answerInstance?.feedbacks?}" var="f">
            <li><g:link controller="feedback" action="show" id="${f.id}">${f?.description}</g:link></li>
        </g:each>
        <li class="add">
            <g:actionSubmit action="addFeedback" name="addFeedback" class="edit" value="Add feedback" />
        </li>
    </ul>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'mediaItems', 'error')} ">
    <label for="mediaItems">
        <g:message code="answer.mediaItems.label" default="Media Items" />

    </label>
    <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${answerInstance?.mediaItems*.id}" class="many-to-many"/>
    <g:actionSubmit action="addMediaItem" name="addMediaItem" class="edit" value="Add media item" />
    <ul>
        <g:each in="${answerInstance?.mediaItems?}" var="m">
            <li><g:link controller="mediaItem" action="show" id="${m.id}">${m?.description}</g:link></li>
        </g:each>
    </ul>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'nextQuestion', 'error')} required">
	<label for="nextQuestion">
		<g:message code="answer.nextQuestion.label" default="Next Question" />
	</label>
    <g:select id="nextQuestion" name="nextQuestionId" noSelection="${[null:'Kérem válasszon!']}" from="${nextQuestionList}" optionKey="id" required="" value="${answerInstance?.nextQuestion?.nextQuestion?.id}" class="many-to-one"/>
</div>



