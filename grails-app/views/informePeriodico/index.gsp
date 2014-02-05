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
        <label class="control-label" for="anio">Años:</label>
        <div class="controls">
          <g:select id="anio" name="anio" from="${anios}" noSelection="['':'-Selecciona un año-']"> </g:select>
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

      <div class="control-group">
        <label class="control-label" for="libretas">Meses : </label>
        <div class="controls">
          <a id="todos" href="#"> Todos </a>
          <div id="months" class="row-fluid"> </div>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="libretas">Agrupación : </label>
        <div class="controls">
          <label class="radio">
            <input type="radio" name="agrupacion" value="curso" checked> Curso
          </label>
          <label class="radio">
            <input type="radio" name="agrupacion" value="participantes"> Participante
          </label>
        </div>
      </div>

    </form>

    <div id="acotaciones"></div>
    <canvas id="grafica" width="1000" height="600"></canvas>
  </body>

</html> 
