<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Show Question </title>
</head>
<body>
  <div class="container">
    <h1>Lista de preguntas</h1>
    <div class="row-fluid">
      <div class="span6">
        <g:if test="${listQuestion.size() > 0}">
          <ul>
          <g:each in="${listQuestion}" var="listaDePreguntas" status="i">
            <g:link controller="question" action="detail" id="${listaDePreguntas.id}"><li>${listaDePreguntas.description}</li></g:link>
          </g:each> 
          </ul>
        </g:if>
        <g:else>
          <p>No hay preguntas</p>
        </g:else>
      </div>
    </div>
  </div>
</body>
</html>