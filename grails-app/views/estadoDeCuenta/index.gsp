<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <title>Estado de cuenta</title>
    <r:require modules="momentjs, datepicker" />

    <r:script>
      $('.datepicker').datepicker({
        format          : "dd/MM/yyyy",
        autoclose       : true,
        todayHighlight  : true,
        language        : 'es'
      })

      $(".datepicker").attr('readonly', 'true')
      $(".datepicker").val(moment().format('DD/MMMM/YYYY'))
    </r:script>

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

    </form>

  </body>
</html>
