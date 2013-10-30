<%@ page import="curriculum.Exercise" %>
<%@ page import="curriculum.ExerciseController" %>


<div class="fieldcontain ${hasErrors(bean: instance, field: 'activity', 'error')} required">
    <label for="activity">
        <g:message code="exercise.activity.label" default="Activity"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="activity" name="activity.id" from="${curriculum.Activity.list()}" noSelection="${[null:'Kérem válasszon!']}"  optionKey="id" required=""
              value="${instance?.activity?.id}" class="many-to-one" onchange="${remoteFunction(action: 'refreshSubactivityList', update: 'exerciseActivities', params: '\'activity\' : this.value')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: instance, field: 'subactivities', 'error')} ">
    <label for="subactivities">
        <g:message code="exercise.subactivities.label" default="Sub Activities"/>

    </label>
    <g:select id="subactivities"  name="subactivities"  from="${instance?.activity?.subactivities}"  multiple="multiple" optionKey="id" size="5"
              value="${instance?.subactivities*.id}" class="many-to-many"/>
</div>


%{--<div class="row">--}%
    %{--<div class="large-5 columns ${hasErrors(bean: instance, field: 'activity', 'error')}">--}%
        %{--<label for="exerciseActivity"><g:message code="exercise.activity.label" />:</label>--}%
        %{--<g:select id="exerciseActivity" name="activity.id" from="${Activity.list()}" optionKey="id" required="" value="${instance?.activity?.id}" />--}%
        %{--<g:hasErrors bean="${instance}" field="activity">--}%
            %{--<small class="error"><g:fieldError bean="${instance}" field="activity" /></small>--}%
        %{--</g:hasErrors>--}%
    %{--</div>--}%
    %{--<div class="large-5 columns ${hasErrors(bean: instance, field: 'subactivity', 'error')}">--}%
        %{--<label for="exerciseSubactivity"><g:message code="exercise.subactivity.label" />:</label>--}%
        %{--<g:select id="exerciseSubactivity" name="subactivity.id" from="${Subactivity.list()}" optionKey="id" required="" value="${instance?.subactivity?.id}" noSelection="${['null':'[ Nincs megadva ]']}" />--}%
        %{--<g:hasErrors bean="${instance}" field="subactivity">--}%
            %{--<small class="error"><g:fieldError bean="${instance}" field="subactivity" /></small>--}%
        %{--</g:hasErrors>--}%
    %{--</div>--}%
%{--</div>--}%