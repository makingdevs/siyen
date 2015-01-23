<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu"/>
    <title>Edición de Curso Programado</title>
    <r:require module="editCursoProgramado" />
  </head>
  <body>
    <div class="page-header">
      <h4>Edición de Curso Programado</h4>
      <p>Actualiza los datos del Curso Programado <strong>${cursoProgramado?.curso?.nombre}</strong></p>
    </div>
    <g:if test="${msg}">
      <div id="msgSuccessBox" class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <strong>Actualización!</strong> ${msg}.
      </div>
    </g:if>
    <g:form class="form-horizontal" method="post" controller="cursoProgramado" action="editCursoByAdmin" id="${cursoProgramado?.id}">
      <div class="control-group">
        <label class="control-label" for="instructores">Fecha de Inicio :</label>
        <div class="controls">
          <div class="input-append date" >
            <input id="fechaDeInicio" name="fechaDeInicio" type="text" class="datepicker" value="${g.formatDate(format:'dd/MM/yyyy', date:cursoProgramado.fechaDeInicio)}"/>
            <span class="add-on"><i class="icon-th"></i></span>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="instructores">Puerto :</label>
        <div class="controls">
          <g:select name="puerto" from="${catPuertos}" optionKey="id" optionValue="clave" value="${cursoProgramado?.puerto?.id}"/>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="instructores">Instructor :</label>
        <div class="controls">
          <input class="input-xlarge" type="text" disabled value="${cursoProgramado?.instructor?.nombre}">
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="instructores">Curso :</label>
        <div class="controls">
          <input class="input-xlarge" type="text" disabled value="${cursoProgramado?.curso?.clave}">
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <button type="submit" class="btn btn-success">Actualizar Datos</button>
        </div>
      </div>
    </g:form>
  </body>
</html>