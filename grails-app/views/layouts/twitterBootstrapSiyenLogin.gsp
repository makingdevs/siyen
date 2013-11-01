<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap, emberjs, application, momentjs, datepicker, dropzonejs, vertx" />

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
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
                  <li>
                    {{#linkTo "cursosNuevos" }}Crear curso{{/linkTo}}
                  </li>
                  <li>
                    {{#linkTo "cursosAutorizados" }}Cursos autorizados{{/linkTo}}
                  </li>
                  <li>
                    {{#linkTo "archivo" }}Procesar archivo{{/linkTo}}
                  </li>
                  <li>
                    {{#linkTo "busqueda" }}Busqueda{{/linkTo}}
                  </li>
                  <li>
                    {{#linkTo "notificacion" }}Notificaciones{{/linkTo}}
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

      <hr>
      <footer>
        <div class="footer">
          <p>&copy; Siyen 2013</p>
        </div>
      </footer>
    </script>

  <input type="hidden" id="frenteParaCurso" value="${g.createLink(action:'generarFrenteParaCurso', controller:'certificado')}" />
  <input type="hidden" id="reversoParaCurso" value="${g.createLink(action:'generarReversoParaCurso', controller:'certificado')}" />

    <r:layoutResources />
  </body>
</html>