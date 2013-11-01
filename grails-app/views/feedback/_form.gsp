<%@ page import="curriculum.Feedback" %>


<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'correct', 'error')} ">
	<label for="correct">
		<g:message code="feedback.correct.label" default="Correct" />
		
	</label>
	<g:checkBox name="correct" value="${feedbackInstance?.correct}" />
</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="feedback.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${feedbackInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'mediaItems', 'error')} ">
    <label for="mediaItems">
        <g:message code="feedback.mediaItems.label" default="Media Items" />

    </label>
    <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${feedbackInstance?.mediaItems*.id}" class="many-to-many"/>
    <g:actionSubmit action="addMediaItem" name="addMediaItem" class="edit" value="Add media item" />
    <ul>
        <g:each in="${feedbackInstance?.mediaItems?}" var="m">
            <li><g:link controller="mediaItem" action="show" id="${m.id}">${m?.description}</g:link></li>
        </g:each>
    </ul>
</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'systemFeedback', 'error')} ">
	<label for="systemFeedback">
		<g:message code="feedback.systemFeedback.label" default="System Feedback" />
		
	</label>
	<g:checkBox name="systemFeedback" value="${feedbackInstance?.systemFeedback}" />
</div>

