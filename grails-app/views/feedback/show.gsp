<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Feedback" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="app">
        <title>Visszajelzés adatai</title>
	</head>
	<body>
    <div class="row curriculum">
        <div class="small-12 columns">
            <h3>Visszajelzés adatai</h3>
        </div>
			<g:if test="${flash.message}">
                <div class="small-12 columns">
                    <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
                </div>
			</g:if>
             <div class="small-12 columns">
			
				<g:if test="${feedbackInstance?.answers}">
                    <div class="row">
                    <div class="large-12 columns">
                        <span id="answers-label" class="property-label"><g:message code="feedback.answers.label" default="Válaszok" />:</span>
                        <ul style="list-style: none">
                            <g:each in="${feedbackInstance.answers}" var="a">
                                <li><span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span></li>
                            </g:each>
                        </ul>

                    </div>
                    </div>
				</g:if>
			
				<g:if test="${feedbackInstance?.correct}">
				<div class="row">
                <div class="large-12 columns">
					<span id="correct-label" class="property-label"><g:message code="feedback.correct.label" default="Helyes" />:</span>
					
						<span class="property-value" aria-labelledby="correct-label"><g:formatBoolean boolean="${feedbackInstance?.correct}" /></span>

                </div>
                </div>
				</g:if>
			
				<g:if test="${feedbackInstance?.description}">
				<div class="row">
                <div class="large-12 columns">
					<span id="description-label" class="property-label"><g:message code="feedback.description.label" default="Leírás" />:</span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${feedbackInstance}" field="description"/></span>

                </div>
                </div>
				</g:if>
			
				<g:if test="${feedbackInstance?.mediaItems}">
				<div class="row">
                <div class="large-12 columns">
					<span id="mediaItems-label" class="property-label"><g:message code="feedback.mediaItems.label" default="Média elemek" />:</span>
                    <ul style="list-style: none">
						<g:each in="${feedbackInstance.mediaItems}" var="m">
						    <li><span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span></li>
						</g:each>
                    </ul>

                </div>
                </div>
				</g:if>
			
				<g:if test="${feedbackInstance?.questions}">
				<div class="row">
                <div class="large-12 columns">
					<span id="questions-label" class="property-label"><g:message code="feedback.questions.label" default="Kérdések" />:</span>
                    <ul style="list-style: none">
						<g:each in="${feedbackInstance.questions}" var="q">
					    	<li><span class="property-value" aria-labelledby="questions-label"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></span></li>
						</g:each>
                    </ul>

                </div>
                </div>
				</g:if>
			
				<g:if test="${feedbackInstance?.systemFeedback}">
				<div class="row">
                <div class="large-12 columns">
					<span id="systemFeedback-label" class="property-label"><g:message code="feedback.systemFeedback.label" default="Rendszer visszajelzés" />:</span>
					
						<span class="property-value" aria-labelledby="systemFeedback-label"><g:formatBoolean boolean="${feedbackInstance?.systemFeedback}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<div class="row">
                <div class="small-12 columns">
					<g:hiddenField name="id" value="${feedbackInstance?.id}" />
					<g:link class="button small blue radius" action="edit" id="${feedbackInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés" /></g:link>
                <g:if test="${feedbackInstance?.id}">
					<g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');" />
                    </g:if>
                </div>
             </div>
			</g:form>
             </div>
    </div>
	</body>
</html>
