<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu"/>
    <title>Buscar curso Programado</title>
  </head>
  <body>
    <div class="page-header">
      <h3>Buscar curso programado</h3>
    </div>
    <div id="busquedaDiv" class="input-append">
      <input type="text" id="busqueda" name="busqueda" class="span2"/>
      <div id="busquedaAvanzada" class="ember-view hide">
        <div class="control-group">
          <label class="control-label" for="cursos">Cursos :</label>
          <div class="controls">
            <select id="cursos" class="busquedaChosen input-xxlarge" multiple> </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="puertos">Puertos :</label>
          <div class="controls">
            <select id="puertos" class="busquedaChosen input-xxlarge" multiple> </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="instructores">Instructores :</label>
          <div class="controls">
            <select id="instructores" class="busquedaChosen input-xxlarge" multiple> </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="instructores">Desde :</label>
          <div class="controls">
            <div class="input-append date" >
              <input type="text" class="datepicker"/>
              <span class="add-on"><i class="icon-th"></i></span>
            </div>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="instructores">Hasta :</label>
          <div class="controls">
            <div class="input-append date" >
              <input type="text" class="datepicker"/>
              <span class="add-on"><i class="icon-th"></i></span>
            </div>
          </div>
        </div>
      </div>
      <button id="mostrarBusquedaAvanzada" type="button" class="btn">
        <i class="icon-filter"></i>
      </button>

      <button type="submit" class="btn" {{ action "realizarBusqueda" }}>Buscar</button>
    </div>

    <div id="resultados"> </div>
  </body>
</html>