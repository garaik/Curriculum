<div id="gapFillExerciseStringAlternativesSnippet">

    <label class="large-6">
        <g:message code="gapFillExerciseString.gapFillExerciseAlternatives.label" default="Alternatívák"/>
    </label>
    <g:each in="${gapFillExerciseStringInstance?.gapFillExerciseAlternatives ?}" var="alternative" status="a">
    <%-- set the domain reference that it can be mapped by the controller --%>
        <g:set var="gapFillExerciseStringDomainReference"
               value="${gapFillExerciseDomainReference}gapFillExerciseAlternatives[${a}]."/>
    <%-- ajax link to remove entries --%>
        <g:hiddenField name="${gapFillExerciseDomainReference}gapFillExerciseAlternatives[${a}].id"
                       value="${alternative?.id}"/>
        <div class="large-12 row">
            <div class="small-10 columns">
                <g:render template="/gapFillExerciseAlternative/gap_fill_exercise_alternative_form"
                          model="[gapFillExerciseAlternativeInstance: alternative]"/>
            </div>

            <div class="small-2 columns">
                <g:submitToRemote class="button small blue radius"
                                  url="[controller: 'gapFillExerciseString', action: 'removeGapFillExerciseStringAlternative']"
                                  update="gapFillExerciseStringsSnippet"
                                  params="[gapStringIndex: gapStringIndex, alternativeRemoveIx: a]"
                                  value="-"/>
            </div>
        </div>
    </g:each>
<%-- PLUSS GOMB --%>

    <div class="large-2 columns">
        <g:submitToRemote class="button small blue radius"
                          url="[controller: 'gapFillExerciseString', action: 'addGapFillExerciseStringAlternative']"
                          update="gapFillExerciseStringsSnippet" params="[gapStringIndex: gapStringIndex]"
                          value="Alternatíva felvétele"/>
    </div>
</div>
