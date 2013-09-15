<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="app">
  <title>Tevékenységek</title>
</head>
<body>
    <div class="column tab-content">
        <h4 class="page-title">Tevékenységek</h4>
        <g:if test="${flash.message}">
            <div class="notice success"><i class="icon-ok icon-large"></i> ${flash.message}<a href="#close" class="icon-remove"></a></div>
        </g:if>
            <div class="col_2">
                <g:link action="create" class="button small blue tooltip" title="Létrehozás"><i class="icon-plus-sign"></i> Létrehozás</g:link>
            </div>
            <div class="col_5 center">
                <input type="text" placeholder="Keresés">
                <button class="small blue"><i class="icon-search"></i></button>
            </div>
            <div class="col_2 center">1 - 20 (145)</div>
            <div class="col_3 center">
                <a href="" class="button small blue tooltip" title="Első oldal"><i class="icon-step-backward"></i></a>
                <a href="" class="button small blue tooltip" title="Előző oldal"><i class="icon-caret-left"></i></a>
                <a href="" class="button small blue tooltip" title="Következő oldal"><i class="icon-caret-right"></i></a>
                <a href="" class="button small blue tooltip" title="Utolsó oldal"><i class="icon-step-forward"></i></a>
            </div>
        <table>
            <thead>
                <tr>
                    <th width="5%">Id</th>
                    <th width="85%">Name</th>
                    <th width="10%">Műveletek</th>
                </tr>
            </thead>
            <tbody>
            <g:each in="${items}" status="i" var="item">
                <tr>
                    <td><input type="checkbox"></td>
                    <td>${item.name}</td>
                    <td>
                        <g:link action="view" id="${item.id}" class="tooltip" title="Megtekintés"><i class="icon-eye-open"></i></g:link>
                        &nbsp;
                        <g:link action="edit" id="${item.id}" class="tooltip" title="Szerkesztés"><i class="icon-pencil"></i></g:link>
                        &nbsp;
                        <g:link action="delete" id="${item.id}" class="tooltip" title="Törlés"><i class="icon-trash"></i></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</body>
</html>