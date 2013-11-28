<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Graficas</title>
    <r:require modules="siyenChart" />
  </head>

  <body>
    <form class="form-horizontal" action="realizarInfome" controller="informePeriodico">

      <div class="control-group">
        <label class="control-label" for="desde">Desde :</label>
        <div class="controls">
          <input type="text" id="desde" name="desde" class="datepicker">
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="hasta">Hasta :</label>
        <div class="controls">
          <input type="text" id="hasta" name="hasta" class="datepicker">
        </div>
      </div>

      <button type="submit" class="btn btn-primary">Mostrar</button>

    </form>

    <canvas id="myChart" width="600" height="400"></canvas>
  </body>

</html>
