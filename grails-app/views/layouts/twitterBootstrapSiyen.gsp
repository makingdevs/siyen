<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap, emberjs, application, momentjs, datepicker" />

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
          {{#each cursoProgramado in controller}}
            <tr>
              <td> {{ date cursoProgramado.fechaDeInicio }} </td>
              <td> {{ date cursoProgramado.fechaDeTermino }} </td>
              <td> {{ date cursoProgramado.dateCreated }} </td>

              <td> {{ cursoProgramado.puerto.puerto }} </td>
              <td> {{ cursoProgramado.curso.nombre }} </td>
              <td> {{ cursoProgramado.instructor.nombre }} </td>

              <td> {{ cursoProgramado.statusCurso }} </td>
            {{/each}}
          </tr>
        </tbody>
      </table>

      {{#linkTo "cursosProgramados.nuevo" class="btn btn-primary" }} Nuevo {{/linkTo}}

      {{ outlet }}

    </script>

    <script type="text/x-handlebars" data-template-name="cursosProgramados/nuevo">
      <div class="page-header">
        <h1>Programar nuevo curso</h1>
      </div>

        <div class="control-group">
          <label class="control-label" for="datepicker">Fecha de inicio :</label>
          <div class="controls">
            <div class="input-append date" id="datepicker" >
              <input size="16" type="text" readonly>
              <span class="add-on"><i class="icon-th"></i></span>
            </div>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="puerto">Puerto :</label>
          <div class="controls">
            {{view Ember.Select contentBinding="puertos" optionValuePath="content.clave" optionLabelPath="content.puerto" name="puerto" }}
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="instructores">Instructor :</label>
          <div class="controls">
            {{ view Ember.Select contentBinding="instructores" optionValuePath="content.numeroDeOficio" optionLabelPath="content.nombre" }}
          </div>
        </div>

        <div class="control-group">
          <label class="control-label" for="instructores">Instructor :</label>
          <div class="controls">
            {{ view Ember.Select contentBinding="cursos" optionValuePath="content.clave" optionLabelPath="content.nombre" }}
          </div>
        </div>

        <div class="form-actions">
          {{#linkTo "cursosProgramados.index" class="btn btn-primary" }} Guardar {{/linkTo}}
          {{#linkTo "cursosProgramados.index" class="btn btn-primary" }} Cancelar {{/linkTo}}
        </div>

      </div>

    </script>

    <r:layoutResources />
  </body>
</html>