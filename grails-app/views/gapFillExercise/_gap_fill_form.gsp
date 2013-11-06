<%@ page import="curriculum.*" %>
<g:hiddenField id="isSavedText" value="false" name="isSavedText"/>
<g:hiddenField id="editOrSaveMode" value="${editOrCreate}" name="editOrSaveMode"/>
<div class="row" id="gapFillSelectModeDiv" >
    <label  class="float-left"   for="selectMode"><g:message code="gapFillExercise.selectionMode.label" /></label>
    <g:checkBox  class="float-left"   id="gapFillSelectMode" name="selectMode" value="${instance?.selectMode}"/>
</div>
<div class="row" id="gapFillText">
    <div class="small-12 columns">
        <label for="gapFillExerciseTextarea" class="${hasErrors(bean: instance, field: 'text', 'error')}"><g:message code="gapFillExercise.text.label" /></label>
        <textarea name="text" id="gapFillExerciseTextarea"<g:if test="${ editOrCreate == 'edit'&& isSavedText == 'true' }"> readonly="readonly"</g:if> onmouseup="setPosition()" rows="8" class="${hasErrors(bean: instance, field: 'text', 'error')}">${instance?.text}</textarea>
        <g:hasErrors bean="${instance}" field="text">
            <small class="error"><g:fieldError bean="${instance}" field="mediaDescription" /></small>
        </g:hasErrors>
    </div>
</div>
<button type="button" class="small blue radius" id="gapFillTextSaveButton" <g:if test="${editOrCreate == 'edit' || (editOrCreate == 'create' && isSavedText == 'true')}"> hidden="hidden" </g:if> onclick="hiddenStringsShow()">Szöveg mentése</button>
<g:hiddenField id="positionStartValue" value="" name="positionStartValue"/>
<g:hiddenField id="positionEndValue" value="" name="positionEndValue"/>
<g:hiddenField id="positionTextValue" value="" name="positionTextValue"/>
<div id="gapFillExerciseStringsFormContainer" <g:if test="${editOrCreate == 'create' || (editOrCreate == 'edit' && isSavedText == 'false')}">hidden="hidden"</g:if>>
    <g:render template="/gapFillExercise/gap_fill_exercise_string_list" model="[instance :instance]"/>
</div>