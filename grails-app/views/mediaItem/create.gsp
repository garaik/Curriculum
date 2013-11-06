<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="app">
        <title>Média elem létrehozása</title>
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Média elem létrehozása</h3>
        </div>

        <div class="small-12 columns">
			<g:form action="save" >

                <g:hiddenField name="returnId" value="${params.returnId}"/>
                <g:hiddenField name="returnAction" value="${params.returnAction}"/>
                <g:hiddenField name="returnController" value="${params.returnController}"/>

		        <g:render template="form"/>

                <div class="row">
                    <div class="small-12 columns">
					    <g:submitButton name="create" class="button small blue radius" value="${message(code: 'default.button.create.label', default: 'Létrehozás')}" />
                        <g:link controller="${params.returnController}" action="${params.returnAction}" params="[id: params.returnId]" class="button small blue radius">Mégsem</g:link>
                    </div>
                </div>
			</g:form>
        </div>
    </div>
	</body>
</html>
