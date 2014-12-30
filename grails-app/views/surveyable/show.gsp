<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="bootstrap"/>
  <title>Administrar Encuesta por Alumno</title>
</head>
<body>
  <div class="container">
    <h1>Encuesta de alumno : ${alumno.nombreCompleto}</h1>
    <div class="row-fluid">
      <div class="span6">
        <strong>Agregar un survey</strong>
        <g:showSurveyForThisInstance instance="${alumno}"/>

        <strong>Ver los survey agregados</strong>
        <g:showSurveyForAnswer instance="${alumno}"/>
      </div>
    </div>
  </div>
  <div id="footer">
    <div class="container">
      <nav>
        <ul class="pager">
          <li><a href="/#/cursosAutorizados/${alumno.cursoProgramado.id}">Regresar a ${alumno.cursoProgramado.curso.clave}</a></li>
        </ul>
      </nav>
    </div>
  </div>
</body>
</html>