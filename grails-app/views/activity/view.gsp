<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="app">
    <title>View activity</title>
</head>
<body>
    <div class="column col_12 tab-content">
        <h4>View activity</h4>
        <table>
            <thead>
            <tr>
                <th>Property</th>
                <th>Value</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Id:</td>
                <td>${item.id}</td>
            </tr>
            <tr>
                <td>Name:</td>
                <td>${item.name}</td>
            </tr>
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
            <tr>
                <td>Grades:</td>
                <td>
                    <ul>
                    <g:each in="${item.grades}" var="grade">
                        <li>${grade.name}</li>
                    </g:each>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
        <g:link action="index">Back to list...</g:link>
    </div>
</body>
</html>