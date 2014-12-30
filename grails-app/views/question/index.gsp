<%@ page import="com.makingdevs.QuestionType"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Create question</title>
  <r:require module="jquery"/>
</head>
<body>
  <div class="container">
    <h1>Captura pregunta</h1>
    <div class="row-fluid">
      <div class="span12">
        <g:form class="form-horizontal" name="questionForm" action="save">
          <div class="control-group span6">
            <label>Description</label>
            <textarea class="span12" rows="4" name="description" style="overflow:auto; resize:none;" required></textarea>
          </div>
          <div class="control-group span6" id="satisfaccion">
            <label>QuestionType</label>
            <g:select name="questionType" from="${QuestionType.values()}"/>
          </div>
          <div class="control-group span6">
            <input class="btn btn-primary" type="submit" value="Enviar" />
          </div>
        </g:form>
      </div>
      <div class="span12">
        <g:link class="btn btn-info" controller="question" action="list" >Todas las preguntas</g:link>
      </div>
    </div>
  </div>
  <r:script>
  $( "#questionType" ).change(function() {
    if($("#questionType option:selected").text()=="CON_CALIFICACION"){
      $( "<div class='agregado'><br><label>Rango de Calificacion</label><input class='input-mini' type='text' name='from' required>&nbsp;a&nbsp;<input class='input-mini' type='text' name='to' required><br></div>" ).appendTo( '#satisfaccion');
    }else{
      $( ".agregado" ).remove();
    }
  });
  </r:script>
</body>
</html>