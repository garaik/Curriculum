<%@ page import="curriculum.Exercise" %>



<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'grade', 'error')} required">
    <label for="grade">
        <g:message code="exercise.grade.label" default="Grade"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="grade" name="grade.id" from="${curriculum.Grade.list()}" optionKey="id" required=""
              value="${exerciseInstance?.grade?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'activity', 'error')} required">
    <label for="activity">
        <g:message code="exercise.activity.label" default="Activity"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="activity" name="activity.id" from="${curriculum.Activity.list()}" optionKey="id" required=""
              value="${exerciseInstance?.activity?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'subactivity', 'error')} ">
    <label for="subactivity">
        <g:message code="exercise.subactivity.label" default="Subactivity"/>

    </label>
    <g:select id="subactivity" name="subactivity.id" from="${curriculum.Subactivity.list()}" optionKey="id"
              value="${exerciseInstance?.subactivity?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'duration', 'error')} required">
    <label for="duration">
        <g:message code="exercise.duration.label" default="Duration"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="duration" type="number" value="${exerciseInstance.duration}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'instruction', 'error')} ">
    <label for="instruction">
        <g:message code="exercise.instruction.label" default="Instruction"/>

    </label>
    <g:textField name="instruction" value="${exerciseInstance?.instruction}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'mediaDescription', 'error')} ">
    <label for="mediaDescription">
        <g:message code="exercise.mediaDescription.label" default="Media Description"/>

    </label>
    <g:textField name="mediaDescription" value="${exerciseInstance?.mediaDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'feedback', 'error')} ">
    <label for="feedback">
        <g:message code="exercise.feedback.label" default="Feedback"/>

    </label>
    <g:textField name="feedback" value="${exerciseInstance?.feedback}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'methodologySuggestion', 'error')} ">
    <label for="methodologySuggestion">
        <g:message code="exercise.methodologySuggestion.label" default="Methodology Suggestion"/>

    </label>
    <g:textField name="methodologySuggestion" value="${exerciseInstance?.methodologySuggestion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'capabilities', 'error')} ">
    <label for="capabilities">
        <g:message code="exercise.capabilities.label" default="Capabilities"/>

    </label>
    <g:select name="capabilities" from="${curriculum.Capability.list()}" multiple="multiple" optionKey="id" size="5"
              value="${exerciseInstance?.capabilities*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'difficulty', 'error')} required">
    <label for="difficulty">
        <g:message code="exercise.difficulty.label" default="Difficulty"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="difficulty" name="difficulty.id" from="${curriculum.Difficulty.list()}" optionKey="id" required=""
              value="${exerciseInstance?.difficulty?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: exerciseInstance, field: 'title', 'error')} ">
    <label for="title">
        <g:message code="exercise.title.label" default="Title"/>

    </label>
    <g:textField name="title" value="${exerciseInstance?.title}"/>
</div>

