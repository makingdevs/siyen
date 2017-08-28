<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Estado de cuenta</title>
    <asset:stylesheet src='datepicker/datepicker.css' />

    <asset:javascript src="momentjs/moment.js" />
    <asset:javascript src="momentjs/lang/es.js" />
    <asset:javascript src="datepicker/bootstrap-datepicker.js" />
    <asset:javascript src="datepicker/locales/bootstrap-datepicker.es.js" />
    <asset:javascript src="estadoDeCuenta/estadoDeCuenta.js" />

  </head>

  <body>
    <g:form name="estadoDeCuentaForm" class="form-horizontal" url="[controller:'estadoDeCuenta', action:'generarEstadoDeCuenta']">
      <div class="control-group">
        <label class="control-label" for="anio">Instructor:</label>
        <div class="controls">
          <g:select name="instructor" id="instructor" from="${instructor}" optionKey="id" noSelection="['':'-Elige un Instructor-']"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="anio">Puertos:</label>
        <div class="controls">
          <g:select name="puerto" id="puerto" from="${puertos}" optionKey="id" noSelection="['':'-Elige un puerto-']"/>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="anio">Fecha de inicio:</label>
        <div class="controls">
          <div class="input-append date" >
            <input name="fechaDeInicio" id="fechaDeInicio" class="datepicker">
            <span class="add-on"><i class="icon-th"></i></span>
          </div>
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="anio">Fecha de término:</label>
        <div class="controls">
          <div class="input-append date" >
            <input name="fechaDeTermino" id="fechaDeTermino" class="datepicker">
            <span class="add-on"><i class="icon-th"></i></span>
          </div>
        </div>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-large btn-primary">Generar</button>
      </div>
    </g:form>

    <div id="result"></div>

  </body>
</html>
