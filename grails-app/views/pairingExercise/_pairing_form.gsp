<%@ page import="curriculum.PairingExercise" %>

<g:render template="/map/exercise_type" model="[mapInstance: instance?.map]"></g:render>
<g:render template="/map/pairing_map_form" model="[mapInstance: instance?.map, groupList: groupList]"></g:render>