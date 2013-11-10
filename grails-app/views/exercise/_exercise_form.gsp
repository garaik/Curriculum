<%@ page import="curriculum.*" %>
<g:render template="/exercise/exercise_grade_details" model="[instance: instance]"/>
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
<div class="fieldcontain ${hasErrors(bean: instance, field: 'capability', 'error')} required">
    <label for="capabilities">
        <g:message code="exercise.capabilities.label" default="Capability"/>
    </label>
    <g:select id="capabilities" name="capabilities" from="${curriculum.Capability.list()}"  multiple="multiple" optionKey="id" size="5"
              value="${instance?.capabilities*.id}" class="many-to-many" />
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
        <label for="field" class="${hasErrors(bean: instance, field: 'methodologySuggestion', 'error')}"><g:message code="exercise.methodologySuggestion.label" />:</label>
        <textarea name="methodologySuggestion" id="field" class="${hasErrors(bean: instance, field: 'methodologySuggestion', 'error')}">${instance?.methodologySuggestion}</textarea>
        <g:hasErrors bean="${instance}" field="methodologySuggestion">
            <small class="error"><g:fieldError bean="${instance}" field="methodologySuggestion" /></small>
        </g:hasErrors>
    </div>
</div>
