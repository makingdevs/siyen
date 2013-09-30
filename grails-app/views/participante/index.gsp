<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - Información del participante : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap" />

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>

    <r:layoutResources />

  </head>

  <body>
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
                </li>
              <!-- END: Menu de opciones -->
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="page-header">
      <h1>Información del participante</h1>
    </div>

    <dl class="dl-horizontal">
      <dt> Numero de control </dt>
      <dd> ${participante.numeroDeControl} </dd>

      <dt> Nombre completo </dt>
      <dd> ${participante.nombreCompleto} </dd>

      <dt> Observaciones </dt>
      <dd> ${participante.observaciones ?: '-'} </dd>

      <dt> Fecha de inicio </dt>
      <dd> ${participante.cursoProgramado.fechaDeInicio.format('dd/MMMM/yyyy')} </dd>

      <dt> Fecha de termino </dt>
      <dd> ${participante.cursoProgramado.fechaDeTermino.format('dd/MMMM/yyyy')} </dd>

      <dt> Puerto </dt>
      <dd> ${participante.cursoProgramado.puerto.puerto}, ${participante.cursoProgramado.puerto.estado} </dd>

      <dt> Curso </dt>
      <dd> ${participante.cursoProgramado.curso.nombre} (${participante.cursoProgramado.curso.clave}) </dd>

      <dt> Instructor </dt>
      <dd> ${participante.cursoProgramado.instructor.nombre} </dd>
    </dl>

    <hr>
    <footer>
      <div class="footer">
        <p>&copy; Siyen 2013</p>
      </div>
    </footer>

    <r:layoutResources />
  </body>
</html>