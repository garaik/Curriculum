<%@ page import="curriculum.Exercise" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'exercise.label', default: 'Exercise')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-exercise" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-exercise" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list exercise">

        <g:if test="${exerciseInstance?.activity}">
            <li class="fieldcontain">
                <span id="activity-label" class="property-label"><g:message code="exercise.activity.label"
                                                                            default="Activity"/></span>

                <span class="property-value" aria-labelledby="activity-label"><g:link controller="activity"
                                                                                      action="show"
                                                                                      id="${exerciseInstance?.activity?.id}">${exerciseInstance?.activity?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${exerciseInstance?.subactivities}">
            <li class="fieldcontain">
                <span id="subactivities-label" class="property-label"><g:message code="exercise.subactivities.label"
                                                                                 default="Subactivities"/></span>

                <g:each in="${exerciseInstance.subactivities}" var="s">
                    <span class="property-value" aria-labelledby="subactivities-label"><g:link controller="subactivity"
                                                                                               action="show"
                                                                                               id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

        <g:if test="${exerciseInstance?.title}">
            <li class="fieldcontain">
                <span id="title-label" class="property-label"><g:message code="exercise.title.label"
                                                                         default="Title"/></span>

                <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${exerciseInstance}"
                                                                                         field="title"/></span>

            </li>
        </g:if>

        <g:if test="${exerciseInstance?.instruction}">
            <li class="fieldcontain">
                <span id="instruction-label" class="property-label"><g:message code="exercise.instruction.label"
                                                                               default="Instruction"/></span>

                <span class="property-value" aria-labelledby="instruction-label"><g:fieldValue
                        bean="${exerciseInstance}" field="instruction"/></span>

            </li>
        </g:if>

        <g:if test="${exerciseInstance?.methodologySuggestion}">
            <li class="fieldcontain">
                <span id="methodologySuggestion-label" class="property-label"><g:message
                        code="exercise.methodologySuggestion.label" default="Methodology Suggestion"/></span>

                <span class="property-value" aria-labelledby="methodologySuggestion-label"><g:fieldValue
                        bean="${exerciseInstance}" field="methodologySuggestion"/></span>

            </li>
        </g:if>

        <g:if test="${exerciseInstance?.gradeDetails}">
            <li class="fieldcontain">
                <span id="gradeDetails-label" class="property-label"><g:message code="exercise.gradeDetails.label"
                                                                                default="Grade Details"/></span>

                <g:each in="${exerciseInstance.gradeDetails}" var="g">
                    <span class="property-value" aria-labelledby="gradeDetails-label"><g:link controller="gradeDetails"
                                                                                              action="show"
                                                                                              id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${exerciseInstance?.id}"/>
            <g:link class="edit" action="edit" id="${exerciseInstance?.id}"><g:message code="default.button.edit.label"
                                                                                       default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
