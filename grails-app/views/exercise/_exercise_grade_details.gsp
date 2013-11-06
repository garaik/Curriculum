<div id="exerciseGradeDetailsSnippet"
     class="fieldcontain ${hasErrors(bean: instance, field: 'gradeDetails', 'error')} ">

    <label for="gradeDetails">
        <g:message code="exercise.gradeDetails.label" default="GradeDetails"/>
    </label>

    <g:each in="${instance?.gradeDetails ?}" var="gradeDetails" status="i">
        <div>
            <%-- set the domain reference that it can be mapped by the controller --%>
            <g:set var="domainReference" value="gradeDetails[${i}]."/>
            <%-- ajax link to remove entries --%>
            <g:hiddenField name="gradeDetails[${i}].id" value="${gradeDetails?.id}"/>
            <div class="row">
                <g:render template="/gradeDetails/form" model="[gradeDetailsInstance: gradeDetails]"/>
                <div class="large-2 columns" style="padding-top: 16px">
                    <g:submitToRemote class="button small blue radius" url="[action: 'removeGradeDetails']"
                                      update="exerciseGradeDetailsSnippet" params="[removeGradeDetailIx: i]"
                                      value="-"/>
                </div>

            </div>
        </div>
    </g:each>
    <div class="large-2 columns">
        <g:submitToRemote class="button small blue radius" url="[action: 'addGradeDetails']"
                          update="exerciseGradeDetailsSnippet" value="Évfolam adatok hozzáadása"/>
    </div>
</div>