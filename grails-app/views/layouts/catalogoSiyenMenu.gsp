<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a PIPE - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">


    <r:require modules="bootstrap, menu" />

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>

    <g:layoutHead/>
    <r:layoutResources />
  </head>

  <body>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="/#">PIPE</a>
          <sec:ifLoggedIn>
            <div class="nav-collapse collapse">
              <ul class="nav">
                <!-- BEGIN: Menu de opciones -->
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    Puertos<b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link class="list" controller="puerto" action="index"> Listado de puertos </g:link>
                    </li>
                    <li>
                      <li>
                        <g:link class="create" controller="puerto" action="create"> Nuevo puerto </g:link>
                      </li>
                    </li>
                  </ul>
                </li>

                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    Cursos<b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link class="list" controller="curso" action="index"> Listado de cursos </g:link>
                    </li>
                    <li>
                      <li>
                        <g:link class="create" controller="curso" action="create"> Nuevo curso </g:link>
                      </li>
                    </li>
                  </ul>
                </li>

                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    Instructores<b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link class="list" controller="instructor" action="index"> Listado de instructores </g:link>
                    </li>
                    <li>
                      <li>
                        <g:link class="create" controller="instructor" action="create"> Nuevo instructor </g:link>
                      </li>
                    </li>
                  </ul>
                </li>

                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    Usuarios<b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link class="list" controller="user" action="index"> Listado de usuarios </g:link>
                    </li>
                    <li>
                      <li>
                        <g:link class="create" controller="user" action="create"> Nuevo usuario </g:link>
                      </li>
                    </li>
                  </ul>
                </li>

                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    Encuestas <b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link class="list" controller="survey" action="list"> Lista de encuestas </g:link>
                    </li>
                    <li>
                      <g:link class="create" controller="survey" action="create"> Nueva encuesta </g:link>
                    </li>
                    <li class="divider">&nbps;&nbps;&nbps;&nbps;&nbps;</li>
                    <li>
                      <g:link class="list" controller="question" action="list"> Listado de preguntas </g:link>
                    </li>
                    <li>
                      <g:link class="create" controller="question"> Crear pregunta </g:link>
                    </li>
                  </ul>
                </li>

                <li>
                  <g:link controller="informePeriodico" action="index"> Gráficas </g:link>
                </li>

                <li>
                  <g:link controller="estadoDeCuenta" action="index"> Estado de cuenta </g:link>
                </li>
                <!-- END: Menu de opciones -->
              </ul>
            </div><!--/.nav-collapse -->
          </sec:ifLoggedIn>
        </div>
      </div>
    </div>

    <div class="container">
      <g:layoutBody />
      <hr>
      <footer>
        <div class="footer">
          <p>&copy; PIPE 2013</p>
        </div>
      </footer>
      <r:layoutResources />
    </div>
  </body>
</html>
