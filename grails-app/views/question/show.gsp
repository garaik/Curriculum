<%@ page contentType="text/html;charset=UTF-8" import="curriculum.Question" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="app">
    <title>Kérdés adatai</title>
</head>

<body>
<div class="row curriculum">
    <div class="small-12 columns">
        <h3>Kérdés adatai</h3>
    </div>
    <g:if test="${flash.message}">
        <div class="small-12 columns">
            <p><span class="label ${flash.error ? 'alert' : 'success'} radius"><i class="${flash.error ? 'icon-exclamation' : 'icon-ok'}"></i> ${flash.message}</span></p>
        </div>
    </g:if>
    <div class="small-12 columns">

        <g:if test="${questionInstance?.questionText}">
            <div class="row">
                <div class="large-12 columns">
                    <span id="questionText-label" class="property-label"><g:message code="question.questionText.label" default="Kérdés szövege"/>:</span>

                    <span class="property-value" aria-labelledby="questionText-label"><g:fieldValue bean="${questionInstance}" field="questionText"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.questionDisplayType}">
            <div class="row">
                <div class="large-12 columns" style="margin-top: 10px; margin-bottom: 10px">
                    <span id="questionDisplayType-label" class="property-label"><g:message code="question.questionDisplayType.label" default="Kérdés megjelenítés típusa"/>:</span>

                    <span class="property-value" aria-labelledby="questionDisplayType-label">${questionInstance?.questionDisplayType?.encodeAsHTML()}</span>

                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.previousAnswers}">
            <div class="row">
                <div class="small-12 columns" style="margin-bottom: 10px">
                    <span id="previousAnswers-label" class="property-label"><g:message code="question.previousAnswers.label" default="Előző válaszok"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${questionInstance.previousAnswers}" var="p">
                            <li><span class="property-value" aria-labelledby="previousAnswers-label"><g:link controller="answerNextQuestion" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>

                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.exercise}">
            <div class="row">
                <div class="small-12 columns" style="margin-bottom: 10px">
                    <span id="exercise-label" class="property-label"><g:message code="question.exercise.label" default="Feladat"/>:</span>

                    <span class="property-value" aria-labelledby="exercise-label"><g:link controller="multipleChoiceExercise" action="edit"
                                                                                          id="${questionInstance?.exercise?.id}">${questionInstance?.exercise?.encodeAsHTML()}</g:link></span>

                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.answers}">
            <div class="row">
                <div class="small-12 columns" style="margin-bottom: 10px">
                    <span id="answers-label" class="property-label"><g:message code="question.answers.label" default="Válaszok"/>:</span>

                    <ul style="list-style: none">
                        <g:each in="${questionInstance.answers}" var="a">
                            <li><g:link controller="answer" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>



                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.mediaItems}">
            <div class="row">
                <div class="small-12 columns" style="margin-bottom: 10px">
                    <span id="mediaItems-label" class="property-label"><g:message code="question.mediaItems.label" default="Média Elemek"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${questionInstance.mediaItems}" var="m">
                            <li><span class="property-value" aria-labelledby="mediaItems-label"><g:link controller="mediaItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </g:if>

        <g:if test="${questionInstance?.feedbacks}">
            <div class="row">
                <div class="small-12 columns">
                    <span id="feedbacks-label" class="property-label"><g:message code="question.feedbacks.label" default="Visszajelzések"/>:</span>
                    <ul style="list-style: none">
                        <g:each in="${questionInstance.feedbacks}" var="f">
                            <li><span class="property-value" aria-labelledby="feedbacks-label"><g:link controller="feedback" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span></li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </g:if>



        <g:form>
            <div class="row">
                <div class="small-12 columns">
                    <g:hiddenField name="id" value="${questionInstance?.id}"/>
                    <g:link class="button small blue radius" action="edit" id="${questionInstance?.id}"><g:message code="default.button.edit.label" default="Szerkesztés"/></g:link>
                    <g:if test="${questionInstance?.id}">
                        <g:actionSubmit class="button small blue radius" action="delete" value="${message(code: 'default.button.delete.label', default: 'Törlés')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Biztosan törli?')}');"/>
                    </g:if>
                    <g:link controller="multipleChoiceExercise" action="edit" params="[id: questionInstance.exercise.id]" class="button small blue radius">Mégsem</g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>
