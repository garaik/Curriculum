<!DOCTYPE html>
<!--[if IE 8]>
<html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en"><!--<![endif]-->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <dojo:header theme="soria" showSpinner="true"/>
    <title><g:layoutTitle default="CURRICULUM"/></title>
    <meta name="description" content=""/>
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,400,700,200italic,400italic,700italic&subset=latin,latin-ext'
          rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="${resource(dir: 'stylesheets/font-awesome/css', file: 'font-awesome.css')}" type="text/css">
    %{--<link rel="stylesheet" href="${resource(dir: 'stylesheets/font-awesome/css', file: 'font-awesome.css')}" type="text/css">--}%
    <link rel="stylesheet" href="${resource(dir: 'stylesheets', file: 'app.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'stylesheets', file: 'curriculum.css')}" type="text/css">
    <script src="${resource(dir: 'javascripts/vendor', file: 'custom.modernizr.js')}"></script>
    <script src="${resource(dir: 'javascripts/vendor', file: 'jquery.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'gapFillExerciseHelper.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.selection.js')}"></script>
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body class="soria">
<nav class="top-bar">
    <ul class="title-area">
        <li class="name">
            <h1><a href="#"><i class="icon-book"></i> CURRICULUM</a></h1>
        </li>
        <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
        <li class="toggle-topbar menu-icon"><a href="#"><span>Menü</span></a></li>
    </ul>

    <section class="top-bar-section">
    </section>

    <div class="loginPanel">
        <g:loginControl/>
    </div>
</nav>

<g:if test="${session.user}">
    <div class="row">

        <div class="large-3 small-12 columns">
            <div class="section-container accordion" data-section="accordion">

                <section class="${params.controller == 'activity' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'activity')}"><i class="icon-flag icon-fixed-width"></i> Tevékenységek</a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'activity' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'activity', action: 'list')}">Összes tevékenység</a></li>
                            <li><a class="${params.controller == 'activity' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'activity', action: 'create')}">Új tevékenység létrehozása</a></li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'subactivity' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'subactivity')}"><i class="icon-flag-alt icon-fixed-width"></i> Al-tevékenységek</a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'subactivity' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'subactivity', action: 'list')}">Összes al-tevékenység</a></li>
                            <li><a class="${params.controller == 'subactivity' && params.action == 'create' ? 'active' : ''}"
                                   href="${createLink(controller: 'subactivity', action: 'create')}">Új al-tevékenység létrehozása</a>
                            </li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'difficulty' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'difficulty')}"><i class="icon-tasks icon-fixed-width"></i> Nehézségek</a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'difficulty' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'difficulty', action: 'list')}">Összes nehézség</a></li>
                            <li><a class="${params.controller == 'difficulty' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'difficulty', action: 'create')}">Új nehézség létrehozása</a>
                            </li>
                        </ul>
                    </div>
                </section>
                <g:if test="${session.user.role == 'admin'}">
                    <section class="${params.controller == 'user' ? 'active' : ''}">
                        <p class="title" data-section-title><a href="${createLink(controller: 'user')}"><i class="icon-group icon-fixed-width"></i> Felhasználók</a></p>

                        <div class="content" data-section-content>
                            <ul class="side-nav">
                                <li><a class="${params.controller == 'user' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'user', action: 'list')}">Összes felhasználó</a></li>
                                <li><a class="${params.controller == 'user' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'user', action: 'create')}">Új felhasználó létrehozása</a></li>
                            </ul>
                        </div>
                    </section>
                </g:if>
                <section class="${params.controller == 'capability' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'capability')}"><i class="icon-dropbox icon-fixed-width"></i> Képességfókuszok</a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'capability' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'capability', action: 'list')}">Összes képesség</a></li>
                            <li><a class="${params.controller == 'capability' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'capability', action: 'create')}">Új képesség létrehozása</a>
                            </li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'grade' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'grade')}"><i class="icon-dropbox icon-fixed-width"></i> Évfolyamok</a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'grade' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'grade', action: 'list')}">Összes évfolyam</a></li>
                            <li><a class="${params.controller == 'grade' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'grade', action: 'create')}">Új évfolyam létrehozása</a></li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'multipleChoiceExercise' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'multipleChoiceExercise')}"><i class="icon-tasks icon-fixed-width"></i><g:message code="multipleChoiceExercise.label"/></a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'multipleChoiceExercise' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'multipleChoiceExercise', action: 'list')}">
                                <g:message code="multipleChoiceExercise.all.label"/></a></li>
                            <li><a class="${params.controller == 'multipleChoiceExercise' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'multipleChoiceExercise', action: 'create')}">
                                <g:message code="multipleChoiceExercise.new.label"/></a></li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'pictureMapExercise' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'pictureMapExercise')}"><i class="icon-tasks icon-fixed-width"></i><g:message code="pictureMapExercise.label"/></a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'pictureMapExercise' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'pictureMapExercise', action: 'list')}"><g:message
                                    code="pictureMapExercise.all.label"/></a></li>
                            <li><a class="${params.controller == 'pictureMapExercise' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'pictureMapExercise', action: 'create')}"><g:message
                                    code="pictureMapExercise.new.label"/></a></li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'pairingExercise' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'pairingExercise')}"><i class="icon-tasks icon-fixed-width"></i><g:message code="pairingExercise.label"/></a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'pairingExercise' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'pairingExercise', action: 'list')}"><g:message
                                    code="pairingExercise.all.label"/></a></li>
                            <li><a class="${params.controller == 'pairingExercise' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'pairingExercise', action: 'create')}"><g:message
                                    code="pairingExercise.new.label"/></a></li>
                        </ul>
                    </div>
                </section>
                <section class="${params.controller == 'gapFillExercise' ? 'active' : ''}">
                    <p class="title" data-section-title><a href="${createLink(controller: 'gapFillExercise')}"><i class="icon-tasks icon-fixed-width"></i><g:message code="gapFillExercise.label"/></a></p>

                    <div class="content" data-section-content>
                        <ul class="side-nav">
                            <li><a class="${params.controller == 'gapFillExercise' && params.action == 'list' ? 'active' : ''}" href="${createLink(controller: 'gapFillExercise', action: 'list')}"><g:message
                                    code="gapFillExercise.all.label"/></a></li>
                            <li><a class="${params.controller == 'gapFillExercise' && params.action == 'create' ? 'active' : ''}" href="${createLink(controller: 'gapFillExercise', action: 'create')}"><g:message
                                    code="gapFillExercise.new.label"/></a></li>
                        </ul>
                    </div>
                </section>
            </div>
        </div>

        <div class="large-9 small-12 columns">
            <g:layoutBody/>
        </div>
    </div>
</g:if>
<g:else>
    <div class="large-12 small-12 columns">
        <g:layoutBody/>
    </div>
</g:else>
<r:layoutResources/>

<script>
    document.write('<script src=' +
            ('__proto__' in {} ? "${resource(dir: 'javascripts/vendor', file: 'zepto.js')}" : "${resource(dir: 'javascripts/vendor', file: 'jquery.js')}") + '><\/script>')
</script>

<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.abide.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.alerts.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.clearing.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.cookie.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.dropdown.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.forms.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.interchange.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.joyride.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.magellan.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.orbit.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.placeholder.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.reveal.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.section.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.tooltips.js')}"></script>
<script src="${resource(dir: 'javascripts/foundation', file: 'foundation.topbar.js')}"></script>
<script>
    $(document).foundation();
</script>
</body>
</html>
