<%@ page import="curriculum.*" %>
<div class="small-12 columns">
    <label for="questions" class="${hasErrors(bean: instance, field: 'questions', 'error')}"><g:message code="exercise.questions.label" default="Kérdések"/>:</label>

    <ul style="list-style: none">
        <g:each in="${instance?.questions?.sort{it.questionText}}" var="q">
            <li><g:link controller="question" action="edit" id="${q.id}">${q?.questionText}</g:link></li>
        </g:each>
    </ul>

    <g:actionSubmit action="addQuestion" name="addQuestion" class="button small blue radius" value="Új kérdés"/>

</div>