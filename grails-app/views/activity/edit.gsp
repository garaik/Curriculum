<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="app">
    <title>Edit activity</title>
</head>
<body>
    <div class="column tab-content">
        <h4 class="page-title">Edit activity</h4>
        <g:if test="${flash.message}">
            <h3>${flash.message}</h3>
        </g:if>
        <g:form method="post">
            <g:hiddenField name="id" value="${item?.id}"/>
            <g:hiddenField name="version" value="${item?.version}"/>
                <label class="col_3">Azonosító:</label><input type="text" class="col_9 disabled" value="${item.id}">
                <label class="col_3">Verzió:</label><input type="text" class="col_9 disabled" value="${item.version}">
                <label class="col_3">Név:</label><input type="text" name="name" class="col_9" value="${item?.name}">
            <table>
                <thead>
                <tr>
                    <th>Property</th>
                    <th>Value</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Subactivites:</td>
                    <td>
                        <ul>
                        <g:each in="${item.subactivities}" var="subactivity">
                            <li>${subactivity.name}</li>
                        </g:each>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
            <g:actionSubmit action="update" value="Save" />
        </g:form>
        <g:link action="index">Back to list...</g:link>
    </div>
</body>
</html>