

<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="mediaItem.description.label" default="Description" />

    </label>
    <g:textField name="${mediaItemPrefix}description" value="${mediaItemInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'instruction', 'error')} ">
    <label for="instruction">
        <g:message code="mediaItem.instruction.label" default="Instruction" />

    </label>
    <g:textField name="${mediaItemPrefix}instruction" value="${mediaItemInstance?.instruction}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'mediaFiles', 'error')} ">
    <label for="mediaFiles">
        <g:message code="mediaItem.mediaFiles.label" default="Media Files" />

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
            <g:each in="${mediaItemInstance?.mediaFiles ?}" status="i" var="mediaFileInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>
                        <g:if test="${acceptableImages.contains(mediaFileInstance.extension)}">
                            <img src="${fieldValue(bean: mediaFileInstance, field: "path")}" width="100px">
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
                    </td>
                    <td>${fieldValue(bean: mediaFileInstance, field: "extension")}</td>
                    <td><g:formatBoolean boolean="${mediaFileInstance.finalVersion}"/></td>
                    <td><g:formatBoolean boolean="${mediaFileInstance.isIcon}"/></td>
                    <td>${fieldValue(bean: mediaFileInstance, field: "path")}</td>

                    <td class="operations">
                        <g:link controller="mediaFile" params="[pairingExerciseId: params.pairingExerciseId]" action="edit" id="${mediaFileInstance.id}" title="Szerkesztés"><i class="icon-pencil"></i></g:link>
                    &nbsp;
                        <g:link controller="mediaFile" params="[pairingExerciseId: params.pairingExerciseId]" action="delete" id="${mediaFileInstance.id}" title="Törlés" onclick="if (!confirm('Biztosan törölni szeretné ezt a médiaFile-t?')) return false;"><i
                                class="icon-trash"></i>
                        </g:link>
                    </td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:link controller="mediaFile" params="[mediaItemId: mediaItemInstance?.id, pairingExerciseId: params.pairingExerciseId]" action="create" name="addMediaFile" class="button small blue radius">Új média fájl</g:link>

</div>

<div class="fieldcontain ${hasErrors(bean: mediaItemInstance, field: 'mediaType', 'error')} required">
    <label for="mediaType">
        <g:message code="mediaItem.mediaType.label" default="Media Type" />
        <span class="required-indicator">*</span>
    </label>
    <g:select name="${mediaItemPrefix}mediaType" from="${curriculum.MediaType?.values()}" keys="${curriculum.MediaType.values()*.name()}" required="" value="${mediaItemInstance?.mediaType?.name()}"/>
</div>