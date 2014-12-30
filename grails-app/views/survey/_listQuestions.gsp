<dl>
  <g:if test="${survey?.questions.size()==0}">
    <dt>
      Este cuestionario aun no tiene preguntas
    </dt>
  </g:if>
  <g:else>
    <dt>
      Este cuestionario tiene las siguientes preguntas : 
    </dt>
    <g:each in="${survey.questions}" var="pregunta">
      <dd>
        ${pregunta.description} 
      </dd>
    </g:each>
  </g:else>
</dl>