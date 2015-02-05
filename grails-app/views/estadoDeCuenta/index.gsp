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

      $(".datepicker").attr('readonly', 'true');
      $(".datepicker").val(moment().format('DD/MMMM/YYYY'));

      $('#result').on('click', '#calcular', function() {
        var porcentaje = parseInt( $("#porcentaje").val() );
        var total = parseInt( $("#total").text() );
        var porcentajeTotal = (porcentaje / 100) * total;
        console.log(porcentajeTotal);
        $('#totalPorcentaje').html( '<h1> Porcentaje otorgado : $' + porcentajeTotal + '</h1>' );
      });
    </r:script>

  </head>

  <body>
    <g:formRemote name="estadoDeCuentaForm" update="result" class="form-horizontal" url="[controller:'estadoDeCuenta', action:'generarEstadoDeCuenta']">
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
    </g:formRemote>

    <div id="result"></div>

  </body>
</html>
