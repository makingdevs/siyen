<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu"/>
    <title>Buscar curso Programado</title>
    <r:require module="searchAdvanced" />
  </head>
  <body>
    <div class="page-header">
      <h3>Buscar curso programado</h3>
      <p>Edita un curso programado</p>
    </div>
    <div id="busquedaDiv" class="input-append">
      <input type="text" id="stringToSearch" class="span3" placeholder="Busca por palabra -Mínimo tres letras-"/>
      <button id="mostrarBusquedaAvanzada" type="button" class="btn" title="Agrega más parametros">
        <i class="icon-filter" ></i>
      </button>
      <button id="busquedaButton" type="button" class="btn" title="Buscar cursos programados">Buscar</button>
    </div>
      <div id="busquedaAvanzada" class="hide">
        <h5>Elige parametros de busqueda</h5>
        <div class="control-group">
          <g:select name="claveCurso" from="${catCursos}" optionKey="clave" optionValue="clave" noSelection="['':'-Elige un Curso-']"/>
        </div>
        <div class="control-group">
          <g:select name="clavePuerto" from="${catPuertos}" optionValue="clave" noSelection="['':'-Elige un Puerto-']"/>
        </div>
        <div class="control-group">
        <g:select name="nombreInstructor" from="${catInstructores}" optionValue="nombre" noSelection="['':'-Elige un Intructor-']"/>
        </div>
        <div class="control-group">
          <label class="control-label" for="instructores">Desde :</label>
          <div class="controls">
            <div class="input-append date" >
              <input id="desde" type="text" class="datepicker" placeholder="comenzar desde"/>
              <span class="add-on"><i class="icon-th"></i></span>
            </div>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="instructores">Hasta :</label>
          <div class="controls">
            <div class="input-append date" >
              <input id="hasta" type="text" class="datepicker" placeholder="finaliza hasta"/>
              <span class="add-on"><i class="icon-th"></i></span>
            </div>
          </div>
        </div>
        <p><small>*Oculta busqueda avanzada presionando "esc"</small></p>
      </div>
    <input id="urlSearchCurso" type="hidden" value="${createLink(controller:'busqueda', action:'buscarCursosProgramados')}"/>
    <div id="resultados">
      <g:render template="/cursoProgramado/listToEdit" model="['totalResultados':totalResultados?:0]"/>
    </div>
  </body>
</html>