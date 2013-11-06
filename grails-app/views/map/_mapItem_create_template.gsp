
<%@ page import="curriculum.MapItem" %>

<g:if test="${params.editMapItemId == '' || params.editMapItemId == null}">
    <g:set var="mapItemPrefix" value="map.mapItems[${sequence}]."/>
</g:if>
<g:else>
    <g:set var="mapItemPrefix" value=""/>
    <g:hiddenField name="editMapItemId" value="${params.editMapItemId}"/>
</g:else>

<div class="fieldcontain ${hasErrors(bean: mapItemInstance, field: 'mapItemTitle', 'error')} ">
    <label for="mapItemTitle">
        <g:message code="mapItem.description.label" default="Title" />

    </label>
    <g:textField name="${mapItemPrefix}mapItemTitle" value="${mapItemInstance?.mapItemTitle}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mapItemInstance, field: 'hoover', 'error')} ">
    <label for="hoover">
        <g:message code="mapItem.hoover.label" default="Hoover" />

    </label>
    <g:textField name="${mapItemPrefix}hoover" value="${mapItemInstance?.hoover}"/>
</div>

%{--MEDIA ITEM--}%
<g:set var="mediaItemPrefix" value="${mapItemPrefix}mediaItem."/>
<g:render template="mediaItem_template" model="[mediaItemInstance: mapItemInstance?.mediaItem]" />
%{--MEDIA ITEM END--}%

<g:hiddenField name="${mapItemPrefix}id" value="${mapItemInstance?.id}"/>
<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'saveMapItem']" params="[sequence: sequence]" update="updatePairingExercise" value="Save" />

<g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'cancel']" update="updatePairingExercise" value="Cancel" />