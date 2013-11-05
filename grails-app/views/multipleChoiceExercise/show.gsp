<%@ page import="curriculum.MultipleChoiceExercise" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'multipleChoiceExercise.label', default: 'MultipleChoiceExercise')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-multipleChoiceExercise" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-multipleChoiceExercise" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list multipleChoiceExercise">

        <g:if test="${multipleChoiceExerciseInstance?.activity}">
            <li class="fieldcontain">
                <span id="activity-label" class="property-label"><g:message code="multipleChoiceExercise.activity.label"
                                                                            default="Activity"/></span>

                <span class="property-value" aria-labelledby="activity-label"><g:link controller="activity"
                                                                                      action="show"
                                                                                      id="${multipleChoiceExerciseInstance?.activity?.id}">${multipleChoiceExerciseInstance?.activity?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.subactivities}">
            <li class="fieldcontain">
                <span id="subactivities-label" class="property-label"><g:message
                        code="multipleChoiceExercise.subactivities.label" default="Subactivities"/></span>

                <g:each in="${multipleChoiceExerciseInstance.subactivities}" var="s">
                    <span class="property-value" aria-labelledby="subactivities-label"><g:link controller="subactivity"
                                                                                               action="show"
                                                                                               id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.title}">
            <li class="fieldcontain">
                <span id="title-label" class="property-label"><g:message code="multipleChoiceExercise.title.label"
                                                                         default="Title"/></span>

                <span class="property-value" aria-labelledby="title-label"><g:fieldValue
                        bean="${multipleChoiceExerciseInstance}" field="title"/></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.instruction}">
            <li class="fieldcontain">
                <span id="instruction-label" class="property-label"><g:message
                        code="multipleChoiceExercise.instruction.label" default="Instruction"/></span>

                <span class="property-value" aria-labelledby="instruction-label"><g:fieldValue
                        bean="${multipleChoiceExerciseInstance}" field="instruction"/></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.mediaDescription}">
            <li class="fieldcontain">
                <span id="mediaDescription-label" class="property-label"><g:message
                        code="multipleChoiceExercise.mediaDescription.label" default="Media Description"/></span>

                <span class="property-value" aria-labelledby="mediaDescription-label"><g:fieldValue
                        bean="${multipleChoiceExerciseInstance}" field="mediaDescription"/></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.feedback}">
            <li class="fieldcontain">
                <span id="feedback-label" class="property-label"><g:message code="multipleChoiceExercise.feedback.label"
                                                                            default="Feedback"/></span>

                <span class="property-value" aria-labelledby="feedback-label"><g:fieldValue
                        bean="${multipleChoiceExerciseInstance}" field="feedback"/></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.methodologySuggestion}">
            <li class="fieldcontain">
                <span id="methodologySuggestion-label" class="property-label"><g:message
                        code="multipleChoiceExercise.methodologySuggestion.label"
                        default="Methodology Suggestion"/></span>

                <span class="property-value" aria-labelledby="methodologySuggestion-label"><g:fieldValue
                        bean="${multipleChoiceExerciseInstance}" field="methodologySuggestion"/></span>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.gradeDetails}">
            <li class="fieldcontain">
                <span id="gradeDetails-label" class="property-label"><g:message
                        code="multipleChoiceExercise.gradeDetails.label" default="Grade Details"/></span>

                <g:each in="${multipleChoiceExerciseInstance.gradeDetails}" var="g">
                    <span class="property-value" aria-labelledby="gradeDetails-label"><g:link controller="gradeDetails"
                                                                                              action="show"
                                                                                              id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

        <g:if test="${multipleChoiceExerciseInstance?.questions}">
            <li class="fieldcontain">
                <span id="questions-label" class="property-label"><g:message
                        code="multipleChoiceExercise.questions.label" default="Questions"/></span>

                <g:each in="${multipleChoiceExerciseInstance.questions}" var="q">
                    <span class="property-value" aria-labelledby="questions-label"><g:link controller="question"
                                                                                           action="show"
                                                                                           id="${q.id}">${q?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${multipleChoiceExerciseInstance?.id}"/>
            <g:link class="edit" action="edit" id="${multipleChoiceExerciseInstance?.id}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
