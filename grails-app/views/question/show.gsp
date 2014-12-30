
<%@ page import="com.makingdevs.QuestionType"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Show Question </title>
</head>
<body>
  <div class="container">
    <h1>${question.description}</h1>
    <h3>${question.questionType}</h3>
    <div class="row-fluid">
      <div class="span12">
        <g:if test="${question.answers.size() > 0}">
          <g:each in="${question.answers}" var="answers" status="i">
          <ul>
            <li>
              <p>${answers.description}</p>
            </li>
          </ul>
          </g:each>
        </g:if>

        <g:if test="${question.questionType == QuestionType.SIN_CALIFICACION || question.questionType == QuestionType.CON_CALIFICACION}">
          <g:link class="btn btn-primary" controller="answer" action="create" id="${question.id}">Agregar respuestas</g:link>
        </g:if>
        <g:link class="btn btn-info"  action="index">Crear otra Pregunta</g:link>
        <g:link class="btn btn-info"  action="list">Todas las Perguntas</g:link>
      </div>
    </div>
  </div>
</body>
</html>