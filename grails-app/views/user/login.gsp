<%@ page contentType="text/html;charset=UTF-8" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app"/>
    <title>Login</title>
</head>

<body>
<div>
    <div class="small-12 columns">
        <h3>Belépés</h3>
    </div>

    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">
        <g:form action="authenticate" method="post">

            <table>
                <tbody>
                <tr class="prop">
                    <td class="name">
                        <label for="login">Azonosító:</label>
                    </td>
                    <td>
                        <input type="text" id="login" name="login"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td class="name">
                        <label for="password">Jelszó:</label>
                    </td>
                    <td>
                        <input type="password" id="password" name="password"/>
                    </td>
                </tr>
                </tbody>

            </table>
            <input class="button small blue radius" type="submit" value="Login"/>
        </g:form>
    </div>

</div>
</body>
</html>


