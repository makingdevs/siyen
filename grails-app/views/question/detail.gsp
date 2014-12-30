<%@ page import="com.makingdevs.QuestionType"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Detail Question</title>
</head>
<body>
  <div class="container">
    <h1>${question.description}</h1>
    <div  class="row-fluid">
      <div class="span6">
        <dl>
          <dt>Pregunta</dt>
          <dd>${question.description}</dd>
          <dt>Tipo de Respuesta</dt>
          <dd>${question.questionType}</dd>
          <dt>Respuestas</dt>
          <dd>
            <ul>
            <g:each in="${question?.answers}" var="respuestas" status="i">
              <li>${respuestas.description}</li>
            </g:each> 
            </ul>
          </dd>
          <g:if test="${question.questionType == QuestionType.CON_CALIFICACION}">
            <dt>Rango de Satisfacción</dt>
            <dd>${question.satisfaccion[0]} al ${question.satisfaccion.last()}</dd>
          </g:if>
        </dl>
      </div>
      <div class="span12">
        <g:link class="btn btn-info"  action="index">Crear otra Pregunta</g:link>
        <g:link class="btn btn-info"  action="list">Todas las Preguntas</g:link>
      </div>
    </div>
  </div>
</body>
</html>