<%@ page import="curriculum.*" %>
<div class="fieldcontain ${hasErrors(bean: instance, field: 'gradeDetails', 'error')} ">

    <label for="gradeDetails">
        <g:message code="exercise.gradeDetails.label" default="GradeDetails"/>
    </label>

    <%-- GRADEDETAILS FIELDS --%>
    <g:each in="${instance?.gradeDetails ?}" var="graded" status="i">
        <div>
            <%-- set the domain reference that it can be mapped by the controller --%>
            <g:set var="domainReference" value="gradeDetails[${i}]."/>
            <%-- ajax link to remove entries --%>
            <g:hiddenField name="gradeDetails[${i}].id" value="${graded?.id}"/>
            <div class="row">
                <g:render template="/gradeDetails/form" model="[gradeDetailsInstance: graded]"/>
                <%-- MINUS GOMB --%>
                <div class="large-2 columns" style="padding-top: 16px">
                    <input type="button" class="button small blue radius"
                           onclick="oneToManyScripts.ajaxPostReplace('${formId}', '${elementToReplace}', '${createLink(action: 'removeGradeDetails', params:[removeIx: i])}')"
                           value="${message(code: 'default.addNew.label', default: ' - ')}"/>

                </div>
                <%-- MINUS GOMB --%>

            </div>
        </div>
    </g:each>
    <%-- PLUSS GOMB --%>
        <%-- ajax link to add new entries --%>
        <input type="button" rel="nofollow" class="button small blue radius" href="javascript:void(0)"
               onclick="oneToManyScripts.ajaxPostReplace('${formId}', '${elementToReplace}', '${createLink(action: 'addGradeDetails')}')"
               value="${message(code: 'default.addNew.label', default: ' + ')}"/>
        <%-- PLUSS GOMB --%>
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
<div id="exerciseActivities">
    <g:render template="/exercise/exercise_activities" model="['instance':instance]"/>
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
