<%@ page import="com.makingdevs.QuestionType"%>
<!DOCTYPE html>
<html>
<head>
  <title>Create answer</title>
  <meta name="layout" content="catalogoSiyenMenu"/>
</head>
<body>
  <div class="container">
    <h1>Captura respuesta para "${question.description}"</h1>
    <div class="row-fluid">
      <div class="span6">
          <g:form name="answer1Form" action="agregar">
            <label>¿Cual es la respuesta?:</label>
            <textarea class="field span12" rows="4" name="description" required></textarea>
            <input type="hidden" value="${question.id}" name="question" />
            <br>
            <input class="btn btn-primary" type="submit" value="Enviar" />
          </g:form>
      </div>
    </div>
  </div>
</body>
</html>