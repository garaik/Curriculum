<div class="fieldcontain ${hasErrors(bean: mapInstance, field: 'exerciseType', 'error')} required">
    <label for="exerciseType">
        <g:message code="map.exerciseType.label" default="Exercise Type" />
        <span class="required-indicator">*</span>
    </label>
    <g:select disabled="${(mapInstance?.exercise?.id) as boolean}" onchange="" name="map.exerciseType" from="${curriculum.ExerciseType?.values()}" keys="${curriculum.ExerciseType.values()*.name()}" required="" value="${mapInstance?.exerciseType?.name()}"/>
</div>