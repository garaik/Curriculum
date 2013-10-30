
<g:render template="/templates/filter" />

<form action="${createLink([action: 'list'])}" method="get" id="listForm">
    <input type='hidden' name="offset" id="pagingOffset" value="from" />

    <div class="large-6 columns global-operations">
        <g:link class="button small blue radius" action="create"><i class="icon-plus"></i> Új feladat</g:link>
    </div>
    <div class="large-6 columns pager">
        <g:render template="/templates/pagination" />
    </div>
</form>

<g:if test="${flash.message}">
    <div class="small-12 columns">
        <p><span class="label ${flash.error?'alert':'success'} radius"><i class="${flash.error?'icon-exclamation':'icon-ok'}"></i> ${flash.message}</span></p>
    </div>
</g:if>

<div class="small-12 columns">
    <table style="width: 100%">
        <thead>
            <tr>
                <th><a href="#"><g:message code="exercise.title.label" /></a></th>
                <th><a href="#"><g:message code="exercise.activity.label" /></a></th>
                <th><a href="#"><g:message code="gradeDetails.grade.label" /></a></th>
                <th><a href="#"><g:message code="gradeDetails.difficulty.label" /></a></th>
                <th class="operations">Műveletek</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${instances}" var="instance">
                <tr>
                    <td><i class="icon-tasks"></i> ${instance?.title}</td>
                    <td>${instance?.activity}</td>
                    <td><g:each in="${instance?.gradeDetails?.grade}" var="grade">${grade}<br/></g:each></td>
                    <td><g:each in="${instance?.gradeDetails?.difficulty}" var="difficulty">${difficulty}<br/></g:each></td>
                    <td class="operations">
                        <g:link action="edit" id="${instance?.id}" title="Szerkesztés"><i class="icon-pencil"></i></g:link>
                        &nbsp;
                        <g:link action="delete" id="${instance?.id}" title="Törlés" onclick="if (!confirm('Biztosan törölni szeretné a(z) ${instance?.title} című feladatot?')) return false;"><i class="icon-trash"></i></g:link>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</div>