<%@ page import="curriculum.GapFillExerciseAlternative" %>

<g:if test="${!gapFillExerciseStringDomainReference}">
    <g:set var="gapFillExerciseStringDomainReference" value=""/>
</g:if>
    <div class="fieldcontain ${hasErrors(bean: gapFillExerciseAlternativeInstance, field: 'alternative', 'error')} ">
        <g:textField name="${gapFillExerciseStringDomainReference}alternative"
                     value="${gapFillExerciseAlternativeInstance?.alternative}"/>
    </div>
