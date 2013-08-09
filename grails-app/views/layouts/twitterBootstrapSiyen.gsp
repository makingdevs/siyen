<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap, emberjs, application, momentjs" />

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
                    {{#linkTo "cursosProgramados" }}Cursos programados{{/linkTo}}

                  </li>
                <!-- END: Menu de opciones -->
              </ul>
            </div><!--/.nav-collapse -->
          </div>
        </div>
      </div>

      <div class="container">
        {{ outlet }}

        <hr>
        <footer>
          <div class="footer">
            <p>&copy; Siyen 2013</p>
          </div>
        </footer>

      </div>
    </script>

    <script type="text/x-handlebars" data-template-name="cursosProgramados">
      <div class="page-header">
        <h1>Cursos programados</h1>
      </div>

      <table class="table table-condensed table-striped table-hover">
        <thead>
          <tr>
            <th>Fecha de inicio</th>
            <th>Fecha de termino</th>
            <th>Fecha de registro</th>
            <th>Puerto</th>
            <th>Curso</th>
            <th>Instructor</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            {{#each cursoProgramado in controller}}
              <td> {{ date cursoProgramado.fechaDeInicio }} </td>
              <td> {{ date cursoProgramado.fechaDeTermino }} </td>
              <td> {{ date cursoProgramado.dateCreated }} </td>

              <td> {{ cursoProgramado.puerto.puerto }} </td>
              <td> {{ cursoProgramado.curso.nombre }} </td>
              <td> {{ cursoProgramado.instructor.nombre }} </td>

              <td> {{ cursoProgramado.statusCurso }} </td>
            {{/each}}
            </tr>
          </tr>
        </tbody>
      </table>

    </script>

    <r:layoutResources />
  </body>
</html>











