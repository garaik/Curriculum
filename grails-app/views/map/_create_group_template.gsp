
<g:set var="mediaItemPrefix" value="mediaItem."/>
<g:render template="mediaItem_template" model="[mediaItemInstance: mapItemGroup.mediaItem]"/>

<div class="fieldcontain ${hasErrors(bean: mapItemGroup, field: 'mapItems', 'error')} ">
    %{--<g:select name="mapItems[0]" from="${mapItemList}" optionKey="id" value="${mapItemGroup?.mapItems?.asList()?.get(0)?.id}" noSelection="${[null:'Kérem válasszon!']}"/>--}%
    <g:select name="mapItems" from="${mapItemList}" multiple="multiple" optionKey="id" size="5" value="${mapItemGroup?.mapItems*.id}" class="many-to-many"/>
</div>
<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'saveGroup']" update="updatePairingExercise" value="Save" />
<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'cancel']" update="updatePairingExercise" value="Cancel" />