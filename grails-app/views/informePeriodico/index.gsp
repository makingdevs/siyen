<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Graficas</title>
    <r:require modules="chosen, siyenChart" />
  </head>

  <body>

    <form class="form-horizontal" controller="informePeriodico" action="realizarInfome">
      <div class="control-group">
        <label class="control-label" for="anios">Años:</label>
        <div class="controls">
          <g:select id="anios" name="anios" from="${anios}" noSelection="['':'-Selecciona un año-']"> </g:select>
        </div>
      </div>

      <div class="control-group hide">
        <label class="control-label" for="puertos">Puertos : </label>
        <div class="controls">
          <g:select name="puerto" from="${puertos.clave}" noSelection="['':'-Selecciona un puerto-']"> </g:select>
        </div>
      </div>

      <div class="control-group hide">
        <label class="control-label" for="libretas">Libretas : </label>
        <div class="controls">
          <g:select name="libreta" from="${libretas}" noSelection="['':'-Selecciona una libreta-']"> </g:select>
        </div>
      </div>

      <div class="control-group hide">
        <label class="control-label" for="cursos">Cursos : </label>
        <div class="controls">
          <g:select name="curso" from="${cursos.clave}" noSelection="['':'-Selecciona un curso-']"> </g:select>
        </div>
      </div>

      <div class="control-group hide">
        <div class="controls">
          <label class="radio">
            <input type="radio" name="graficacion" value="curso" checked> Cursos
          </label>

          <label class="radio">
            <input type="radio" name="graficacion" value="participante"> Participantes
          </label>
        </div>
      </div>

      <button class="btn btn-large btn-block btn-primary" type="button">Generar informe</button>
    </form>

    <canvas id="myChart" width="600" height="400"></canvas>
  </body>

</html> 
