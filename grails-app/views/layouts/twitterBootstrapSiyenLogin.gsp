<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
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
    </style>

    <g:layoutHead/>
    <r:layoutResources />
  </head>

  <body>
    <script type="text/x-handlebars" data-template-name="application">

      <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">Siyen</a>
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
                        {{#linkTo "cursosNuevos" }}Nuevo{{/linkTo}}
                      </li>
                      <li>
                        {{#linkTo "cursosAutorizados" }}Autorizados{{/linkTo}}
                      </li>
                      <li>
                        {{#linkTo "movimientos" }}Movimientos{{/linkTo}}
                      </li>
                    </ul>
                  </li>
                  <li>
                    {{#linkTo "archivo" }}Procesar archivo{{/linkTo}}
                  </li>
                  <li>
                    {{#linkTo "busqueda" }}Busqueda{{/linkTo}}
                  </li>
                  <sec:access expression="hasRole('ROLE_ADMIN')">
                    <li>
                      {{#linkTo "notificacion" }}Notificaciones{{/linkTo}}
                    </li>

                    <li>
                      <g:link controller="puerto">Catálogos</g:link>
                    </li>
                  </sec:access>


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
                          Logout
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

    <script type="text/x-handlebars" data-template-name="movimientos">
      <div class="container-fluid">
        <div class="row-fluid">
          <div class="span6">
            <div class="control-group">
              <label class="control-label" for="cursos">Curso :</label>
              <div class="controls">
                {{ view Ember.Select prompt="Selecciona un curso : "
                                     contentBinding="model"
                                     optionValuePath="content.id"
                                     optionLabelPath="content.descripcion"
                                     selectionBinding="cursoSelectedA" }}
              </div>
            </div>

            {{#if cursoSelectedA}}
              <dl class="dl-horizontal">
                <dt>Fecha de inicio</dt>
                <dd>{{ date cursoSelectedA.fechaDeInicio }}</dd>

                <dt>Instructor</dt>
                <dd>{{ cursoSelectedA.instructor.nombre }}</dd>

                <dt>Curso</dt>
                <dd>{{ cursoSelectedA.curso.clave }}</dd>

                <dt>Puerto</dt>
                <dd>{{ cursoSelectedA.puerto.descripcion }}</dd>
              </dl>
            {{/if}}

            {{ view App.ListaAlumnosView contentBinding=this }}

          </div>

          <div class="span6">
            <div class="control-group">
              <label class="control-label" for="cursos">Curso :</label>
              <div class="controls">
                {{ view Ember.Select prompt="Selecciona un curso : "
                                     contentBinding="model"
                                     optionValuePath="content.id"
                                     optionLabelPath="content.descripcion"
                                     selectionBinding="cursoSelectedB" }}
              </div>
            </div>
            {{#if cursoSelectedB}}
              <dl class="dl-horizontal">
                <dt>Fecha de inicio</dt>
                <dd>{{ date cursoSelectedB.fechaDeInicio }}</dd>

                <dt>Instructor</dt>
                <dd>{{ cursoSelectedB.instructor.nombre }}</dd>

                <dt>Curso</dt>
                <dd>{{ cursoSelectedB.curso.clave }}</dd>

                <dt>Puerto</dt>
                <dd>{{ cursoSelectedB.puerto.descripcion }}</dd>
              </dl>
            {{/if}}
          </div>
        </div>
      </div>
    </script>

    <div id="alertas" class="hide">
      <strong></strong>
      <span class="message">
      </span>
    </div>

    <input type="hidden" id="frenteParaCurso" value="${g.createLink(action:'generarFrenteParaCurso', controller:'certificado')}" />
    <input type="hidden" id="reversoParaCurso" value="${g.createLink(action:'generarReversoParaCurso', controller:'certificado')}" />

    <input type="hidden" id="frenteParaCursoPorAlumno" value="${g.createLink(action:'generarFrenteParaCursoPorAlumno', controller:'certificado')}" />
    <input type="hidden" id="reversoParaCursoPorAlumno" value="${g.createLink(action:'generarReversoParaCursoPorAlumno', controller:'certificado')}" />

    <input type="hidden" id="urlBusqueda" value="${g.createLink(action:'realizarBusqueda', controller:'busqueda')}" />

    <r:layoutResources />
  </body>
</html>
