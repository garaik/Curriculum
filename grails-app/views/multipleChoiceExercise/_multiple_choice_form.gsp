<%@ page import="curriculum.*" %>
<div class="small-12 columns">
    <label for="questions" class="${hasErrors(bean: instance, field: 'questions', 'error')}"><g:message code="exercise.questions.label" />:</label>

    <ul class="one-to-many">
        <g:each in="${instance?.questions?}" var="q">
            <li><g:link controller="question" action="show" id="${q.id}">${q?.questionText}</g:link></li>
        </g:each>
        <li class="add">
            <g:actionSubmit action="addQuestion" name="addQuestion" class="edit" value="Add question" />
        </li>
    </ul>

</div>