<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a PIPE - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap, chosen, emberjs, application, momentjs, datepicker, dropzonejs, vertx" />

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }

      #busquedaDiv {
        padding:0 0 0 10px;
      }

      #busquedaAvanzada {
        position: absolute;
        border: 1px solid #ddd;
        padding: 10px 0 0 12px;
        position : absolute;
        background : #fff;
      }

      .overlay {
        position         : absolute;
        top              : 0;
        left             : 0;
        width            : 100%;
        height           : 100%;
        z-index          : 10;
        background       : rgba(0,0,0,0.5) url(../images/spinner.gif) 50% 50% no-repeat;
        display          : none;
      }
    </style>

    <g:layoutHead/>
    <r:layoutResources />
  </head>

  <body>
    <div class="overlay">
      <script type="text/x-handlebars" data-template-name="application">
        <div class="navbar navbar-fixed-top">
          <div class="navbar-inner">
            <div class="container">
              <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="brand" href="#">PIPE</a>
              <div class="nav-collapse collapse">
                <ul class="nav">
                  <!-- BEGIN: Menu de opciones -->
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <b class="caret"></b>
                        Cursos
                      </a>
                      <ul class="dropdown-menu">
                        <li>
                          {{#link-to "cursosNuevos" }}Nuevo{{/link-to}}
                        </li>
                        <li>
                          {{#link-to "cursosAutorizados" }}Autorizados{{/link-to}}
                        </li>
                        <li>
                          {{#link-to "oficios" }}Oficios{{/link-to}}
                        </li>
                      </ul>
                    </li>

                    <sec:access expression="hasRole('ROLE_ADMIN')">
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                          <b class="caret"></b>
                          Movimientos
                        </a>
                        <ul class="dropdown-menu">
                          <li>
                            {{#link-to "movimientos" }}Entre cursos{{/link-to}}
                          </li>
                          <li>
                            {{#link-to "alumnos" }}A un nuevo curso{{/link-to}}
                          </li>
                        </ul>
                      </li>
                    </sec:access>

                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <b class="caret"></b>
                        Avanzadas
                      </a>
                      <ul class="dropdown-menu">
                        <li>
                          {{#link-to "archivo" }}Procesar archivo{{/link-to}}
                        </li>
                        <li>
                          {{#link-to "busqueda" }}Busqueda{{/link-to}}
                        </li>
                        <li>
                          {{#link-to "busquedaAlumnos" }}Busqueda por alumnos{{/link-to}}
                        </li>
                      </ul>
                    </li>

                    <sec:access expression="hasRole('ROLE_ADMIN')">
                      <li>
                        {{#link-to "notificacion" }}Notificaciones{{/link-to}}
                      </li>

                      <li>
                        <g:link controller="puerto">Catálogos</g:link>
                      </li>
                    </sec:access>
                    <li class="active">
                      <a href="${createLink(controller:'payU')}"><r:img uri="images/credit-card.png" width="15" height="7"/> Pago con PayU</a>
                    </li>
                  <!-- END: Menu de opciones -->
                </ul>
                <sec:ifLoggedIn>
                  <ul class="nav pull-right">
                    <li class="dropdown">
                      <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                        <sec:loggedInUserInfo field="username"/>
                        <b class="caret"></b>
                      </a>
                      <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                        <li>
                          <g:link controller="logout" tabindex="-1">
                            Salir del PIPE
                          </g:link>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </sec:ifLoggedIn>
              </div><!--/.nav-collapse -->
            </div>
          </div>
        </div>

        {{ outlet }}

        <g:layoutBody />

        <hr>
        <footer>
          <div class="footer">
            <p>&copy; Siyen 2013</p>
          </div>
        </footer>
      </script>
    </div>

    <div id="alertas" class="hide">
      <strong></strong>
      <span class="message">
      </span>
    </div>

    <div id="error" class="alert alert-error hide">
      <strong>ERROR</strong>
      <span class="message">
      </span>
    </div>

    <input type="hidden" id="frenteParaCursoPorAlumno" value="${g.createLink(action:'generarFrenteParaCursoPorAlumno', controller:'certificado')}" />
    <input type="hidden" id="reversoParaCursoPorAlumno" value="${g.createLink(action:'generarReversoParaCursoPorAlumno', controller:'certificado')}" />

    <input type="hidden" id="generarOficios" value="${g.createLink(action:'generarOficio', controller:'oficio')}" />

    <input type="hidden" id="urlBusqueda" value="${g.createLink(action:'realizarBusqueda', controller:'busqueda')}" />
    <input type="hidden" id="urlBusquedaDeAlumnos" value="${g.createLink(action:'realizarBusquedaDeAlumnos', controller:'busqueda')}" />

    <input type="hidden" id="frenteParaCurso" value="${g.createLink(action:'generarFrenteParaCurso', controller:'certificado')}" />
    <input type="hidden" id="reversoParaCurso" value="${g.createLink(action:'generarReversoParaCurso', controller:'certificado')}" />

    <input type="hidden" id="eventBusURL" value="${grailsApplication.config.grails.app.vertx.eventbus}" />
    <input type="hidden" id="surveyable" value="${g.createLink(controller:'surveyable', action='show')}" />
    <r:layoutResources />
  </body>
</html>
