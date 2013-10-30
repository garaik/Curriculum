<%@ page import="curriculum.*" %>

<g:if test="${!domainReference}">
    <g:set var="domainReference" value=""/>
</g:if>
    <div class="large-4 columns ${hasErrors(bean: gradeDetailsInstance, field: 'grade', 'error')}">
        <label for="gradeDetailsGrade"><g:message code="gradeDetails.grade.label" />:</label>
        <g:select id="gradeDetailsGrade" name="${domainReference}grade.id" from="${Grade.list()}" optionKey="id" required="" value="${gradeDetailsInstance?.grade?.id}" />
        <g:hasErrors bean="${gradeDetailsInstance}" field="grade">
            <small class="error"><g:fieldError bean="${gradeDetailsInstance}" field="grade" /></small>
        </g:hasErrors>
    </div>
    <div class="large-4 columns ${hasErrors(bean: gradeDetailsInstance, field: 'difficulty', 'error')}">
        <label for="gradeDetailsDifficulty"><g:message code="gradeDetails.difficulty.label" />:</label>
        <g:select id="gradeDetailsDifficulty" name="${domainReference}difficulty.id" from="${Difficulty.list()}" optionKey="id" required="" value="${gradeDetailsInstance?.difficulty?.id}" />
        <g:hasErrors bean="${gradeDetailsInstance}" field="difficulty">
            <small class="error"><g:fieldError bean="${gradeDetailsInstance}" field="difficulty" /></small>
        </g:hasErrors>
    </div>
    <div class="large-2 columns">
        <label for="gradeDetailsDuration" class="${hasErrors(bean: gradeDetailsInstance, field: 'duration', 'error')}"><g:message code="gradeDetails.duration.label" />:</label>
        <input name="${domainReference}duration" id="gradeDetailsDuration" type="text" value="${gradeDetailsInstance?.duration}" class="${hasErrors(bean: gradeDetailsInstance, field: 'duration', 'error')}">
        <g:hasErrors bean="${gradeDetailsInstance}" field="duration">
            <small class="error"><g:fieldError bean="${gradeDetailsInstance}" field="duration" /></small>
        </g:hasErrors>
    </div>


