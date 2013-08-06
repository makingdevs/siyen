<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="twitterBootstrapSiyen"/>
    <title>Registro de un curso</title> <!-- CursoProgramado -->

    <r:require module="emberjs" />
  </head>

  <body>

    <div class="page-header">
      <h1>Registro de curso</h1>
    </div>
    
    <script type="text/x-handlebars">
      <div class="row-fluid">
        <div class="span12">
          <form class="form-horizontal">
          
            <div class="control-group">
              <label class="control-label" for="fechaDeInicio">Fecha de inicio:</label>
              <div class="controls">
                <g:datePicker name="fechaDeInicio" value="${new Date()}" precision="day" />
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="puerto">Puerto</label>
              <div class="controls">
                <select id="puerto" name="puerto"> </select>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="tipoDeCurso">Tipo de curso:</label>
              <div class="controls">
                <select id="tipoDeCurso" name="Tipo de curso"> </select>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="instructor">Instructor:</label>
              <div class="controls">
                <select id="instructor" name="Instructor"> </select>
              </div>
            </div>

            <button class="btn btn-large btn-block btn-primary" type="button">Guardar</button>
            
          </form>
        </div>
      </div>
    </script> 

  </body>

</html>