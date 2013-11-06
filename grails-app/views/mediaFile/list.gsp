<%@ page import="curriculum.MediaFile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'mediaFile.label', default: 'Média fájl')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-mediaFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-mediaFile" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>
            <th>Thumbnail</th>

            <g:sortableColumn property="extension" title="${message(code: 'mediaFile.extension.label', default: 'Extension')}"/>

            <g:sortableColumn property="finalVersion" title="${message(code: 'mediaFile.finalVersion.label', default: 'Final Version')}"/>

            <g:sortableColumn property="isIcon" title="${message(code: 'mediaFile.isIcon.label', default: 'Is Icon')}"/>

            <g:sortableColumn property="path" title="${message(code: 'mediaFile.path.label', default: 'Path')}"/>

            <th class="operations">Műveletek</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${mediaFileInstanceList}" status="i" var="mediaFileInstance">
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
                <td><g:formatBoolean boolean="${mediaFileInstance.finalVersion}" true="Igen" false="Nem"/></td>
                <td><g:formatBoolean boolean="${mediaFileInstance.isIcon}" true="Igen" false="Nem"/></td>
                <td>${fieldValue(bean: mediaFileInstance, field: "path")}</td>
                <td class="operations">
                    <g:link action="edit" id="${mediaFileInstance.id}" title="Szerkesztés"><i class="icon-pencil">Szerkesztés</i></g:link>
                &nbsp;
                    <g:link action="delete" id="${mediaFileInstance.id}" title="Törlés" onclick="if (!confirm('Biztosan törölni szeretné ezt a médiaFile-t?')) return false;"><i
                            class="icon-trash">Törlés</i>
                    </g:link>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${mediaFileInstanceTotal}"/>
    </div>
</div>
</body>
</html>
