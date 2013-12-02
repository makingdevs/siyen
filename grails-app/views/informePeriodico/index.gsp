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
          <g:select id="anios" name="anios" from="${anios}"> </g:select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="puertos">Puertos : </label>
        <div class="controls">
          <g:select id="puertos" name="puerto" from="${puertos.clave}"> </g:select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="libretas">Libretas : </label>
        <div class="controls">
          <g:select id="libretas" name="libreta" from="${libretas}"> </g:select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cursos">Cursos : </label>
        <div class="controls">
          <g:select id="cursos" name="curso" from="${cursos.clave}"> </g:select>
        </div>
      </div>

      <div class="control-group">
        <div class="controls">
          <label class="radio">
            <input type="radio" name="graficacion" id="curso" value="curso"> Cursos
          </label>

          <label class="radio">
            <input type="radio" name="graficacion" id="participante" value="participante"> Participantes
          </label>
        </div>
      </div>

      <div class="control-group">
        <div class="controls">
          <button type="submit" class="btn btn-primary">Generar informe</button>
        </div>
      </div>
    </form>

    <canvas id="myChart" width="600" height="400"></canvas>
  </body>

</html> 
