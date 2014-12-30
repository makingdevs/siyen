
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>List Survey</title>
</head>
<body>
  <div class="container">
    <h1>Encuestas</h1>
    <div class="row-fluid">
      <div class="span6">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Titulo</th>
              <th>Descripción</th>
              <th>N. preguntas</th>
              <th>CodeName</th>
            </tr>
          </thead>
          <tbody>
            <g:each in="${survey?}" var="surveys" status="i">
            <tr>
              <td>
                <g:link controller="survey" action="showSurvey" id="${surveys.id}">${surveys.title}</g:link>
              </td>
              <td>${surveys.description}</td>
              <td>${surveys.questions.size()}</td>
              <td>${surveys.codeName}</td>
            </tr>
          </g:each> 
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>