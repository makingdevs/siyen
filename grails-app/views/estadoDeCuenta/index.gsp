<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Estado de cuenta</title>
    <r:require modules="chosen" />
  </head>

  <body>
    <form class="form-horizontal" controller="estadoDeCuenta" action="generarEstadoDeCuenta">
      <div class="control-group">
        <label class="control-label" for="anio">Instructor:</label>
        <div class="controls">
          <g:select name="instructor" id="instructor" from="${instructores}" noSelection="['':'-Elige un instructor-']"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="anio">Puertos:</label>
        <div class="controls">
          <g:select name="puerto" id="puerto" from="${puertos}" noSelection="['':'-Elige un puerto-']"/>
        </div>
      </div>

    </form>

  </body>
</html>
