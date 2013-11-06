<%@ page import="curriculum.MediaItem" %>
<div class="row">
    <div class="small-12 columns">
        <label for="description" class="${hasErrors(bean: mediaItemInstance, field: 'description', 'error')}">
            <g:message code="mediaItem.description.label" default="Leírás"/>

        </label>
        <g:textField name="description" value="${mediaItemInstance?.description}"/>
        <g:hasErrors bean="${mediaItemInstance}" field="description">
            <small class="error"><g:fieldError bean="${mediaItemInstance}" field="description"/></small>
        </g:hasErrors>

    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="instruction" class="${hasErrors(bean: mediaItemInstance, field: 'instruction', 'error')}">
            <g:message code="mediaItem.instruction.label" default="Instrukció"/>

        </label>
        <g:textField name="instruction" value="${mediaItemInstance?.instruction}"/>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="mediaFiles" class="${hasErrors(bean: mediaItemInstance, field: 'mediaFiles', 'error')}">
            <g:message code="mediaItem.mediaFiles.label" default="Média fájlok"/>

        </label>

        <g:if test="${mediaItemInstance?.mediaFiles}">
        <table style="width: 100%">
            <thead>
            <tr>
                <th>Thumbnail</th>

                <g:sortableColumn property="extension" title="${message(code: 'mediaFile.extension.label', default: 'Kiterjesztés')}"/>

                <g:sortableColumn property="finalVersion" title="${message(code: 'mediaFile.finalVersion.label', default: 'Végső verrzió')}"/>

                <g:sortableColumn property="isIcon" title="${message(code: 'mediaFile.isIcon.label', default: 'Ikon')}"/>

                <g:sortableColumn property="path" title="${message(code: 'mediaFile.path.label', default: 'Útvonal')}"/>

                <th class="operations">Műveletek</th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${mediaItemInstance?.mediaFiles?.sort { it.id } ?}" status="i" var="mediaFileInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>
                        <g:if test="${acceptableImages?.contains(mediaFileInstance?.extension)}">
                            <img src="${fieldValue(bean: mediaFileInstance, field: "path")}" width="100px">
                        </g:if>
                        <g:if test="${acceptableDocuments?.contains(mediaFileInstance?.extension)}">
                            <img src="${createLinkTo(dir: 'images/icons', file: 'document_image.png', absolute: true)}" alt="document_image.png" title="DOCUMENT" width="100px"/>
                        </g:if>
                        <g:if test="${acceptableVideos?.contains(mediaFileInstance?.extension)}">
                            <img src="${createLinkTo(dir: 'images/icons', file: 'video_image.png', absolute: true)}" alt="video_image.png" title="VIDEO" width="100px"/>
                        </g:if>
                        <g:if test="${acceptableSounds?.contains(mediaFileInstance?.extension)}">
                            <img src="${createLinkTo(dir: 'images/icons', file: 'music_image.png', absolute: true)}" alt="music_image.png" title="MUSIC" width="100px"/>
                        </g:if>
                    </td>
                    <td>${fieldValue(bean: mediaFileInstance, field: "extension")}</td>
                    <td><g:formatBoolean boolean="${mediaFileInstance?.finalVersion}" true="Igen" false="Nem"/></td>
                    <td><g:formatBoolean boolean="${mediaFileInstance?.isIcon}" true="Igen" false="Nem"/></td>
                    <td>${fieldValue(bean: mediaFileInstance, field: "path")}</td>

                    <td class="operations">
                        <g:link controller="mediaFile" action="edit" id="${mediaFileInstance.id}" title="Szerkesztés"><i class="icon-pencil"></i></g:link>
                    &nbsp;
                        <g:link controller="mediaFile" action="delete" id="${mediaFileInstance.id}" title="Törlés" onclick="if (!confirm('Biztosan törölni szeretné ezt a médiaFile-t?')) return false;"><i
                                class="icon-trash"></i>
                        </g:link>
                    </td>

                </tr>
            </g:each>
            </tbody>
        </table>
        </g:if>
        <g:actionSubmit action="addMediaFile" name="addMediaFile" class="button small blue radius" value="Új média fájl"/>
        <g:hasErrors bean="${mediaItemInstance}" field="addMediaFile">
            <small class="error"><g:fieldError bean="${mediaItemInstance}" field="addMediaFile"/></small>
        </g:hasErrors>
        <g:if test="${flash.error}">
            <small class="error" role="status">${flash.error}</small>
        </g:if>
    </div>
</div>

<div class="row">
    <div class="small-12 columns">
        <label for="mediaType" class="${hasErrors(bean: mediaItemInstance, field: 'mediaType', 'error')}">
            <g:message code="mediaItem.mediaType.label" default="Média típus"/>
            <span class="required-indicator">*</span>
        </label>
        <g:select disabled="${(mediaItemInstance?.mediaFiles) as boolean}" name="mediaType" from="${curriculum.MediaType?.values()}" keys="${curriculum.MediaType.values()*.name()}" required="" value="${mediaItemInstance?.mediaType?.name()}"/>

    </div>
</div>

