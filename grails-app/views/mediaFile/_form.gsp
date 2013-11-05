<%@ page import="curriculum.MediaFile" %>

<g:hiddenField name="mediaItemId" value="${mediaFileInstance?.mediaItem?.id}"></g:hiddenField>

%{-- TODO only one final version can be exist --}%
<div class="row">
    <div class="small-12 columns">
        <label for="finalVersion" class="${hasErrors(bean: mediaFileInstance, field: 'finalVersion', 'error')}">
            <g:message code="mediaFile.finalVersion.label" default="Végső verzió"/>

        </label>
        <g:checkBox name="finalVersion" value="${mediaFileInstance?.finalVersion}"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="isIcon" class="${hasErrors(bean: mediaFileInstance, field: 'isIcon', 'error')}">
            <g:message code="mediaFile.isIcon.label" default="Ikon"/>

        </label>
        <g:checkBox name="isIcon" value="${mediaFileInstance?.isIcon}"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="upload" class="${hasErrors(bean: mediaFileInstance, field: 'path', 'error')}">
            <g:message code="mediaFile.fileUpload.label" default="Fájl feltöltés"/>
        </label>
        <input type="file" name="upload" class="${hasErrors(bean: mediaFileInstance, field: 'path', 'error')}"/>
        <g:hasErrors bean="${mediaFileInstance}" field="path">
            <small class="error"><g:fieldError bean="${mediaFileInstance}" field="path"/></small>
        </g:hasErrors>
        <g:if test="${flash.message}">
            <small class="error" role="status">${flash.message}</small>
        </g:if>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <g:if test="${mediaFileInstance?.path}">
            <div class="fieldcontain">
                <a class="button small blue radius" href="${fieldValue(bean: mediaFileInstance, field: "path")}" download>Download media</a>
            </div>

            <div class="row" style="margin-bottom: 10px">
                <div class="small-12 columns">
                    <g:if test="${acceptableImages.contains(mediaFileInstance.extension)}">
                        <img src="${fieldValue(bean: mediaFileInstance, field: "path")}" width="100%">
                    </g:if>
                    <g:if test="${acceptableDocuments.contains(mediaFileInstance.extension)}">
                        <img src="${createLinkTo(dir: 'images/icons', file: 'document_image.png', absolute: true)}" alt="document_image.png" title="DOCUMENT" width="100px"/>
                    </g:if>
                    <g:if test="${acceptableVideos.contains(mediaFileInstance.extension)}">
                        <img src="${createLinkTo(dir: 'images/icons', file: 'video_image.png', absolute: true)}" alt="video_image.png" title="VIDEO" width="100px"/>
                    </g:if>
                    <g:if test="${acceptableSounds.contains(mediaFileInstance.extension)}">
                        <img src="${createLinkTo(dir: 'images/icons', file: 'music_image.png', absolute: true)}" alt="music_image.png" title="MUSIC" width="100px"/>
                    </g:if>
                </div>
            </div>
        </g:if>

    </div>
</div>