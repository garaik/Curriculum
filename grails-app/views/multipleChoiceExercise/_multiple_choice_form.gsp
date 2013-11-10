<%@ page import="curriculum.*" %>
<div class="small-12 columns">
    <label for="questions" class="${hasErrors(bean: instance, field: 'questions', 'error')}"><g:message code="exercise.questions.label" default="Kérdések"/>:</label>

    <table style="list-style: none">
        <g:each in="${instance?.questions?.sort{it.questionText}}" var="q">
            <tr>
                <td>${q}</td>
                <td><g:link class="button small blue radius" controller="question" action="edit" id="${q.id}" >Szerkesztés</g:link>
            </tr>
        </g:each>
    </table>

    <g:actionSubmit action="addQuestion" name="addQuestion" class="button small blue radius" value="Új kérdés"/>

</div>