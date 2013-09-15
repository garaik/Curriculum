<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="app">
  <title>Create new activity</title>
</head>
<body>
    <div class="column col_12 tab-content">
        <h4>Create new activity</h4>
    <g:form method="post">
        <table>
            <thead>
            <tr>
                <th>Property</th>
                <th>Value</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Name:</td>
                <td><g:textField name="name" size="50" value=""/></td>
            </tr>
            </tbody>
        </table>
        <g:actionSubmit action="save" value="Create" />
    </g:form>
    <g:link action="index">Back to list...</g:link>
    </div>
</body>
</html>