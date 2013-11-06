<%@ page import="curriculum.GapFillExerciseString" %>

<g:if test="${!gapFillExerciseDomainReference}">
    <g:set var="gapFillExerciseDomainReference" value=""/>
</g:if>
<div class="large-12 row">
    <div class="small-10 columns">
        <div class="fieldcontain ${hasErrors(bean: gapFillExerciseStringInstance, field: 'hiddenString', 'error')} ">

            <g:textField id="${gapFillExerciseDomainReference}hiddenString"
                         name="${gapFillExerciseDomainReference}hiddenString"
                         value="${gapFillExerciseStringInstance?.hiddenString}" disabled="disabled"/>

            <g:hiddenField id="${gapFillExerciseDomainReference}hiddenString"
                         name="${gapFillExerciseDomainReference}hiddenString"
                         value="${gapFillExerciseStringInstance?.hiddenString}"/>
        </div>
    </div>

    <div class="small-2 columns">
        <g:submitToRemote class="button small blue radius" url="[action: 'removeGapFillExerciseString']"
                          update="gapFillExerciseStringsSnippet" params="[removeIx: gapStringIndex]"
                          value="-"/>
    </div>
</div>
<div  class="large-12 gapFillExerciseStringAlternativesDiv" <g:if test="${isAlternativable == false}"> hidden="hidden" </g:if>>
<g:render template="/gapFillExerciseString/gap_fill_exercise_string_alternative_list" model="[gapFillExerciseStringInstance: gapFillExerciseStringInstance, gapStringIndex: gapStringIndex]"/>
</div>
<g:hiddenField id="${gapFillExerciseDomainReference}startPosition" name="${gapFillExerciseDomainReference}startPosition"
               value="${gapFillExerciseStringInstance?.startPosition}"/>
<g:hiddenField id="${gapFillExerciseDomainReference}endPosition" name="${gapFillExerciseDomainReference}endPosition"
               value="${gapFillExerciseStringInstance?.endPosition}"/>

