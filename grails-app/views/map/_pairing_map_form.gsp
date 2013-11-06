<%@ page import="curriculum.Map" %>
<g:if test="${params.id && params.id instanceof java.lang.String}">
    <g:hiddenField name="pairingExerciseId" value="${params.id}"/>
</g:if>
<g:elseif test="${params.pairingExerciseId}">
    <g:hiddenField name="pairingExerciseId" value="${params.pairingExerciseId}"/>
</g:elseif>
<div id="updatePairingExercise">
    <table style="width: 100%">
        <thead>
            <tr>
                <th><a href="#"><g:message code="mapItem.title.label" /></a></th>
                <th style="text-align: right" class="operations">Műveletek</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${mapInstance?.mapItems?}" var="m" status="i">
                <tr>
                    <td><i class="icon-tasks"></i> ${m?.mapItemTitle}</td>
                    <td style="text-align: right" class="operations">
                        <g:submitToRemote class="button tiny blue radius" url="[controller: 'map', action: 'editMapItem']" params="[editMapItemId: m.id]" update="updatePairingExercise" value="Edit" />
                        <g:submitToRemote class="button tiny blue radius" url="[controller: 'map', action: 'deleteMapItem']" params="[deleteMapItemId: m.id]" update="updatePairingExercise" value="Delete" />
                    </td>
                </tr>
            </g:each>
            <tr>
                <td colspan="2">
                    <g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'addMapItem']" update="updatePairingExercise" value="addMapItem" />
                </td>
            </tr>
        </tbody>
    </table>
    <table style="width: 100%">
        <thead>
            <tr>
                <th><a href="#"><g:message code="mapItem.title.label" /></a></th>
                <th style="text-align: right" class="operations">Műveletek</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <g:each in="${groupList}" var="group" status="i">
                <tr>
                    <td><i class="icon-tasks"></i> ${group?.mediaItem?.description}</td>
                    <td style="text-align: right" class="operations">
                        <g:submitToRemote class="button tiny blue radius" url="[controller: 'map', action: 'editGroup']" params="[editGroupId: group.id]" update="updatePairingExercise" value="Edit" />
                        <g:submitToRemote class="button tiny blue radius" url="[controller: 'map', action: 'deleteGroup']" params="[deleteGroupId: group.id]" update="updatePairingExercise" value="Delete" />
                    </td>
                </tr>
            </g:each>
            </tr>
            <tr>
                <td colspan="2">
                    <g:submitToRemote class="button small blue radius" url="[controller: 'map', action: 'addGroup']" update="updatePairingExercise" value="New pair/group" />
                </td>
            </tr>
        </tbody>
    </table>

</div>

