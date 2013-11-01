<%@ page import="curriculum.MediaItem" %>


<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="mediaItem.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${mediaItemInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'instruction', 'error')} ">
	<label for="instruction">
		<g:message code="mediaItem.instruction.label" default="Instruction" />
		
	</label>
	<g:textField name="instruction" value="${mediaItemInstance?.instruction}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'mediaFiles', 'error')} ">
    <label for="mediaFiles">
        <g:message code="mediaItem.mediaFiles.label" default="Media Files" />

    </label>

    <ul class="one-to-many">
        <g:each in="${mediaItemInstance?.mediaFiles?}" var="m">
            <li><g:link controller="mediaFile" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
        </g:each>
        <li class="add">
            <g:actionSubmit action="addMediaFile" name="addMediaFile" class="edit" value="Add media file" />
        </li>
    </ul>

</div>

<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'mediaType', 'error')} required">
	<label for="mediaType">
		<g:message code="mediaItem.mediaType.label" default="Media Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="mediaType" from="${curriculum.MediaType?.values()}" keys="${curriculum.MediaType.values()*.name()}" required="" value="${mediaItemInstance?.mediaType?.name()}"/>
</div>


