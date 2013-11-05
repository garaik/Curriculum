<div id="gapFillExerciseStringsSnippet"
     class=" fieldcontain ${hasErrors(bean: instance, field: 'gapFillExerciseStrings', 'error')} ">
    <div class="large-2">
        <g:submitToRemote class="button small blue radius" url="[controller: 'gapFillExercise',  action: 'addGapFillExerciseString']"
                          update="gapFillExerciseStringsSnippet"  value="Kijelölt szöveg \'rejtése\'"/>
    </div>
        <g:set var="stringsListSize" value="${instance?.gapFillExerciseStrings?.size()}"/>
    <fieldset class="form">
    <label><g:message code="gapFillExercise.gapFillExerciseStrings.label" /></label>
        <g:each in="${instance?.gapFillExerciseStrings}" var="gapFillExerciseStrings" status="i">
            <g:if test="${i%3==0}"><div class="row"></g:if>
            <div class="large-4 columns hiddenStringContainer ">
                <%-- set the domain reference that it can be mapped by the controller --%>
                <g:set var="gapFillExerciseDomainReference" value="gapFillExerciseStrings[${i}]."/>
                <%-- ajax link to remove entries --%>
                <g:hiddenField name="gapFillExerciseStrings[${i}].id" value="${gapFillExerciseStrings?.id}"/>
                <fieldset class="form large-12">
                        <g:render template="/gapFillExerciseString/gap_fill_exercise_string_form"
                                  model="[gapFillExerciseStringInstance: gapFillExerciseStrings, gapStringIndex: i, isAlternativable: instance?.selectMode ]"/>
                </fieldset>
            </div>
            <g:if test="${ i%3==2 || stringsListSize == i+1 }"></div></g:if>
        </g:each>
</fieldset>
</div>
