<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Add Questions</title>
</head>
<body>
  <div class="container">
    <h1>Agrege preguntas para "${survey.title}"</h1>
    <div class="row-fluid">
      <div class="span6">
        <g:form name="myForm" url="[controller:'survey', action: 'agregarPreguntas']">
          <ul>
            <g:each in="${questions?}" var="preguntas" status="i">
              <li>${preguntas.description}: <input name="id" value="${preguntas.id}" type="checkbox" /></li>
            </g:each> 
          </ul>
          <input type="hidden" value="${survey.id}" name="survey" />
          <input class="btn btn-primary" type="submit" value="Agregar">
        </g:form>
        <g:link class="btn btn-info" action="list">Todos los Cuestionarios</g:link>
        <g:link class="btn btn-info" action="create">Crear Cuestionario</g:link>
        <g:render template="listQuestions" model="[survey:survey]"/>
    </div>
  </div>
</body>
</html>