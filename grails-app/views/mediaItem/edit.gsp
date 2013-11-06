<%@ page contentType="text/html;charset=UTF-8" import="curriculum.MediaItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="app">
        <title>Média elem szerkesztése</title>
	</head>
	<body>
    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Média elem szerkesztése</h3>
        </div>
			<g:if test="${flash.message}">
                <div class="small-12 columns">
                    <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
                </div>
			</g:if>
            <div class="small-12 columns">
			<g:form method="post" >
				<g:hiddenField name="id" value="${mediaItemInstance?.id}" />
				<g:hiddenField name="version" value="${mediaItemInstance?.version}" />
			    <g:render template="form"/>

                <g:hiddenField name="returnId" value="${params.returnId}"/>
                <g:hiddenField name="returnAction" value="${params.returnAction}"/>
                <g:hiddenField name="returnController" value="${params.returnController}"/>

                <div class="row">
                    <div class="small-12 columns">
                        <g:actionSubmit class="button small blue radius" action="update" value="${message(code: 'default.button.update.label', default: 'Mentés')}" />
                        <g:if test="${mediaItemInstance?.id}">
                           <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');" />
                        </g:if>

                        <g:if test="${questionId}">
                            <g:link controller="${params.returnController}" action="${params.returnAction}" params="[id: params.returnId]" class="button small blue radius">Mégsem</g:link>
                        </g:if>


                    </div>
                </div>
			</g:form>
            </div>
        </div>
	</body>
</html>
