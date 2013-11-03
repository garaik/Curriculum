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
        <g:select name="mediaItems" from="${curriculum.MediaItem.list()}" multiple="multiple" optionKey="id" size="5" value="${feedbackInstance?.mediaItems*.id}" class="many-to-many"/>
        <g:actionSubmit action="addMediaItem" name="addMediaItem" class="button small blue radius" value="Új média elem"/>
        <ul style="list-style: none">
            <g:each in="${feedbackInstance?.mediaItems ?}" var="m">
                <li><g:link controller="mediaItem" action="show" id="${m.id}">${m?.description}</g:link></li>
            </g:each>
        </ul>
    </div>
</div>



