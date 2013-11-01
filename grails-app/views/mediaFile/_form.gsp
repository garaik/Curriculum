<%@ page import="curriculum.MediaFile" %>



<div class="fieldcontain ${hasErrors(bean: mediaFileInstance, field: 'finalVersion', 'error')} ">
	<label for="finalVersion">
		<g:message code="mediaFile.finalVersion.label" default="Final Version" />
		
	</label>
	<g:checkBox name="finalVersion" value="${mediaFileInstance?.finalVersion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: mediaFileInstance, field: 'isIcon', 'error')} ">
	<label for="isIcon">
		<g:message code="mediaFile.isIcon.label" default="Is Icon" />
		
	</label>
	<g:checkBox name="isIcon" value="${mediaFileInstance?.isIcon}" />
</div>

<div class="fieldcontain ${hasErrors(bean: mediaFileInstance, field: 'mediaItem', 'error')} required">
	<label for="mediaItem">
		<g:message code="mediaFile.mediaItem.label" default="Media Item" />
	</label>
    <g:hiddenField name="mediaItemId" value="${mediaFileInstance?.mediaItem?.id}"></g:hiddenField>
	<g:link controller="mediaItem" action="show" id="${mediaFileInstance?.mediaItem?.id}">${mediaFileInstance?.mediaItem?.description}</g:link>
</div>

<div class="fieldcontain ${hasErrors(bean: mediaFileInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="mediaFile.path.label" default="Path" />
		
	</label>
	<g:textField name="path" value="${mediaFileInstance?.path}"/>
</div>

