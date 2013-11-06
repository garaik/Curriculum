
<g:if test="${params.editGroupId != null}">
    <g:hiddenField name="editGroupId" value="${params.editGroupId}"/>
</g:if>

<g:set var="mediaItemPrefix" value="mediaItem."/>
<g:render template="mediaItem_template" model="[mediaItemInstance: mapItemGroup.mediaItem]"/>

<div class="fieldcontain ${hasErrors(bean: mapItemGroup, field: 'mapItems', 'error')} ">
<g:if test="${params.editGroupId != null}">
    <g:select name="mapItems" from="${mapItemList}" optionKey="id" value="${mapItemGroup?.mapItems.asList()?.get(0)?.id}"/>
    <g:select name="mapItems" from="${mapItemList}" optionKey="id" value="${mapItemGroup?.mapItems.asList()?.get(1)?.id}"/>
</g:if>
<g:else>
    <g:select name="mapItems" from="${mapItemList}" optionKey="id" value="${mapItemGroup?.mapItems?.id}" noSelection="${[null:'Kérem válasszon!']}"/>
    <g:select name="mapItems" from="${mapItemList}" optionKey="id" value="${mapItemGroup?.mapItems?.id}" noSelection="${[null:'Kérem válasszon!']}"/>
</g:else>
</div>
<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'saveGroup']" update="updatePairingExercise" value="Save" />
<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'cancel']" update="updatePairingExercise" value="Cancel" />