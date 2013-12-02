<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Graficas</title>
    <r:require modules="chosen, siyenChart" />
  </head>

  <body>

    <form class="form-horizontal" action="realizarInfome" controller="informePeriodico">
      <div class="control-group">
        <label class="control-label" for="anios">Años:</label>
        <div class="controls">
          <select id="anios" class="busquedaChosen"> </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="puertos">Puertos : </label>
        <div class="controls">
          <select id="puertos" class="busquedaChosen"> </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="libretas">Libretas : </label>
        <div class="controls">
          <select id="libretas" class="busquedaChosen"> </select>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="cursos">Cursos : </label>
        <div class="controls">
          <select id="cursos" class="busquedaChosen"> </select>
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
