<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Felhasználók</title>
</head>

<body>
    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Felhasználók</h3>
        </div>

        <g:render template="/templates/filter" />

        <form action="${createLink([action: 'list'])}" method="get" id="listForm">
            <input type='hidden' name="offset" id="pagingOffset" value="from" />
            <div class="large-6 columns global-operations">
                <g:link class="button small blue radius" action="create"><i class="icon-plus"></i> Új felhasználó</g:link>
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
                        <th><a href="#"><g:message code="user.login.label" /></a></th>
                        <th><a href="#"><i class="icon-sort-by-alphabet"></i> <g:message code="user.name.label" /></a></th>
                        <th><a href="#"><g:message code="user.email.label" /></a></th>
                        <th><a href="#"><g:message code="user.role.label"/></a></th>
                        <th><a href="#"><g:message code="user.active.label" /></a></th>
                        <th class="operations">Műveletek</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${instances}" var="instance">
                        <tr>
                            <td><i class="icon-user"></i> ${instance.login}</td>
                            <td>${instance.name}</td>
                            <td>${instance.email}</td>
                            <td>${instance.role}</td>
                            <td><g:formatBoolean boolean="${instance.active}" true="Igen" false="Nem"/></td>
                            <td class="operations">
                                <g:link action="edit" id="${instance.id}" title="Szerkesztés"><i class="icon-pencil"></i></g:link>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
