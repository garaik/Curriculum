<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Answer" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Válasz adatai</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Válasz adatai</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">

        <g:if test="${answerInstance?.answerText}">
            <div class="row">
                <div class="large-12 columns" style="margin-top: 10px; margin-bottom: 10px">
                    <span id="answerText-label" class="property-label"><g:message code="answer.answerText.label" default="Válasz szövege"/>:</span>

                    <span class="property-value" aria-labelledby="answerText-label"><g:fieldValue bean="${answerInstance}" field="answerText"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.feedbacks}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="feedbacks-label" class="property-label"><g:message code="answer.feedbacks.label" default="Visszajelzések"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${answerInstance.feedbacks}" var="f">
                            <li><span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.isCorrect}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="isCorrect-label" class="property-label"><g:message code="answer.isCorrect.label" default="Helyes"/>:</span>

                    <span class="property-value" aria-labelledby="isCorrect-label"><g:formatBoolean boolean="${answerInstance?.isCorrect}"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.mediaItems}">
            <div class="row">
                <div class="large-12 columns">
                    <span id="mediaItems-label" class="property-label"><g:message code="answer.mediaItems.label" default="Média elemek"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${answerInstance.mediaItems}" var="m">
                            <li><span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.nextQuestion}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="nextQuestion-label" class="property-label"><g:message code="answer.nextQuestion.label" default="Következő kérdés"/>:</span>

                    <span class="property-value" aria-labelledby="nextQuestion-label"><g:link controller="question" action="show"
                                                                                              id="${answerInstance?.nextQuestion?.nextQuestion?.id}">${answerInstance?.nextQuestion?.encodeAsHTML()}</g:link></span>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.question}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="question-label" class="property-label"><g:message code="answer.question.label" default="Kérdés"/>:</span>

                    <span class="property-value" aria-labelledby="question-label"><g:link controller="question" action="show"
                                                                                          id="${answerInstance?.question?.id}">${answerInstance?.question?.encodeAsHTML()}</g:link></span>

                </div>
            </div>
        </g:if>

        <g:if test="${answerInstance?.teacherInstruction}">
            <div class="row">
                <div class="large-12 columns" style="margin-bottom: 10px">
                    <span id="teacherInstruction-label" class="property-label"><g:message code="answer.teacherInstruction.label" default="Tanári instrukció"/>:</span>

                    <span class="property-value" aria-labelledby="teacherInstruction-label"><g:fieldValue bean="${answerInstance}" field="teacherInstruction"/></span>

                </div>
            </div>
        </g:if>


        <g:form>
            <div class="row">
                <div class="small-12 columns">
                    <g:hiddenField name="id" value="${answerInstance?.id}"/>
                    <g:link class="button small blue radius" action="edit" id="${answerInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés"/></g:link>
                    <g:if test="${answerInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link controller="question" action="edit" params="[id: answerInstance.question.id]" class="button small blue radius">Mégsem</g:link>
                </div>
            </div>
        </g:form>
    </div>
</body>
</html>
