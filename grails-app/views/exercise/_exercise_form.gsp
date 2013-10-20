<%@ page import="curriculum.*" %>
<div class="fieldcontain ${hasErrors(bean: instance, field: 'gradeDetails', 'error')} ">
    <%-- PLUSS GOMB --%>
    <label for="gradeDetails">
        <g:message code="exercise.gradeDetails.label" default="GradeDetails"/>
    </label>
    <%-- ajax link to add new entries --%>
    <input type="button" rel="nofollow" class="actionButton" href="javascript:void(0)"
           onclick="oneToManyScripts.ajaxPostReplace('${formId}', '${elementToReplace}', '${createLink(action: 'addGradeDetails')}')"
           value="${message(code: 'default.addNew.label', default: ' + ')}"/>
    <%-- PLUSS GOMB --%>
    <%-- GRADEDETAILS FIELDS --%>
    <g:each in="${instance?.gradeDetails ?}" var="graded" status="i">
        <div>
            <%-- set the domain reference that it can be mapped by the controller --%>
            <g:set var="domainReference" value="gradeDetails[${i}]."/>
            <%-- ajax link to remove entries --%>
            <%-- MINUS GOMB --%>
            <input type="button" class="actionButton"
                   onclick="oneToManyScripts.ajaxPostReplace('${formId}', '${elementToReplace}', '${createLink(action: 'removeGradeDetails', params:[removeIx: i])}')"
                   value="${message(code: 'default.addNew.label', default: ' - ')}"/>
            <%-- MINUS GOMB --%>
            <g:hiddenField name="gradeDetails[${i}].id" value="${graded?.id}"/>

            <g:render template="/gradeDetails/form" model="[gradeDetailsInstance: graded]"/>
        </div>
    </g:each>
    <%-- GRADEDETAILS FIELDS --%>

<%-- to restore the state of the form after ajax post/response --%>
    <g:hiddenField name="formId" value="${formId}"/>
    <g:hiddenField name="elementToReplace" value="${elementToReplace}"/>

</div>
<div class="row">
    <div class="small-12 columns">
        <label for="exerciseTitle" class="${hasErrors(bean: instance, field: 'title', 'error')}"><g:message code="exercise.title.label" />:</label>
        <input name="title" id="exerciseTitle" type="text" value="${instance?.title}" class="${hasErrors(bean: instance, field: 'title', 'error')}">
        <g:hasErrors bean="${instance}" field="title">
            <small class="error"><g:fieldError bean="${instance}" field="title" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="large-5 columns ${hasErrors(bean: instance, field: 'activity', 'error')}">
        <label for="exerciseActivity"><g:message code="exercise.activity.label" />:</label>
        <g:select id="exerciseActivity" name="activity.id" from="${Activity.list()}" optionKey="id" required="" value="${instance?.activity?.id}" />
        <g:hasErrors bean="${instance}" field="activity">
            <small class="error"><g:fieldError bean="${instance}" field="activity" /></small>
        </g:hasErrors>
    </div>
    <div class="large-5 columns ${hasErrors(bean: instance, field: 'subactivity', 'error')}">
        <label for="exerciseSubactivity"><g:message code="exercise.subactivity.label" />:</label>
        <g:select id="exerciseSubactivity" name="subactivity.id" from="${Subactivity.list()}" optionKey="id" required="" value="${instance?.subactivity?.id}" noSelection="${['null':'[ Nincs megadva ]']}" />
        <g:hasErrors bean="${instance}" field="subactivity">
            <small class="error"><g:fieldError bean="${instance}" field="subactivity" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="small-12 columns">
        <label for="exerciseInstruction" class="${hasErrors(bean: instance, field: 'instruction', 'error')}"><g:message code="exercise.instruction.label" />:</label>
        <textarea name="instruction" id="exerciseInstruction" rows="8" class="${hasErrors(bean: instance, field: 'instruction', 'error')}">${instance?.instruction}</textarea>
        <g:hasErrors bean="${instance}" field="instruction">
            <small class="error"><g:fieldError bean="${instance}" field="instruction" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="small-12 columns">
        <label for="field" class="${hasErrors(bean: instance, field: 'mediaDescription', 'error')}"><g:message code="exercise.mediaDescription.label" />:</label>
        <textarea name="mediaDescription" id="field" rows="8" class="${hasErrors(bean: instance, field: 'mediaDescription', 'error')}">${instance?.mediaDescription}</textarea>
        <g:hasErrors bean="${instance}" field="mediaDescription">
            <small class="error"><g:fieldError bean="${instance}" field="mediaDescription" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="small-12 columns">
        <label for="field" class="${hasErrors(bean: instance, field: 'feedback', 'error')}"><g:message code="exercise.feedback.label" />:</label>
        <textarea name="feedback" id="field" class="${hasErrors(bean: instance, field: 'feedback', 'error')}">${instance?.feedback}</textarea>
        <g:hasErrors bean="${instance}" field="feedback">
            <small class="error"><g:fieldError bean="${instance}" field="feedback" /></small>
        </g:hasErrors>
    </div>
</div>
<div class="row">
    <div class="small-12 columns">
        <label for="field" class="${hasErrors(bean: instance, field: 'methodologySuggestion', 'error')}"><g:message code="exercise.methodologySuggestion.label" />:</label>
        <textarea name="methodologySuggestion" id="field" class="${hasErrors(bean: instance, field: 'methodologySuggestion', 'error')}">${instance?.methodologySuggestion}</textarea>
        <g:hasErrors bean="${instance}" field="methodologySuggestion">
            <small class="error"><g:fieldError bean="${instance}" field="methodologySuggestion" /></small>
        </g:hasErrors>
    </div>
</div>
