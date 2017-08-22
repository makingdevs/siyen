<%@ page import="com.siyen.Curso" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'curso.label', default: 'Curso')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#show-curso" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="show-curso" class="content scaffold-show" role="main">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list curso">

        <g:if test="${cursoInstance?.clave}">
        <li class="fieldcontain">
          <span id="clave-label" class="property-label"><g:message code="curso.clave.label" default="Clave" /></span>

            <span class="property-value" aria-labelledby="clave-label"><g:fieldValue bean="${cursoInstance}" field="clave"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.nombre}">
        <li class="fieldcontain">
          <span id="nombre-label" class="property-label"><g:message code="curso.nombre.label" default="Nombre" /></span>

            <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${cursoInstance}" field="nombre"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.duracion}">
        <li class="fieldcontain">
          <span id="duracion-label" class="property-label"><g:message code="curso.duracion.label" default="Duracion" /></span>

            <span class="property-value" aria-labelledby="duracion-label"><g:fieldValue bean="${cursoInstance}" field="duracion"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.libreta}">
        <li class="fieldcontain">
          <span id="libreta-label" class="property-label"><g:message code="curso.libreta.label" default="Libreta" /></span>

            <span class="property-value" aria-labelledby="libreta-label"><g:fieldValue bean="${cursoInstance}" field="libreta"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.englishName}">
        <li class="fieldcontain">
          <span id="englishName-label" class="property-label"><g:message code="curso.englishName.label" default="English Name" /></span>

            <span class="property-value" aria-labelledby="englishName-label"><g:fieldValue bean="${cursoInstance}" field="englishName"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.description}">
        <li class="fieldcontain">
          <span id="description-label" class="property-label"><g:message code="curso.description.label" default="Description" /></span>

            <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${cursoInstance}" field="description"/></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.activo}">
        <li class="fieldcontain">
          <span id="activo-label" class="property-label"><g:message code="curso.activo.label" default="Activo" /></span>

            <span class="property-value" aria-labelledby="activo-label"><g:formatBoolean boolean="${cursoInstance?.activo}" /></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.dateCreated}">
        <li class="fieldcontain">
          <span id="dateCreated-label" class="property-label"><g:message code="curso.dateCreated.label" default="Date Created" /></span>

            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${cursoInstance?.dateCreated}" /></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.ingles}">
        <li class="fieldcontain">
          <span id="ingles-label" class="property-label"><g:message code="curso.ingles.label" default="Ingles" /></span>

            <span class="property-value" aria-labelledby="ingles-label"><g:formatBoolean boolean="${cursoInstance?.ingles}" /></span>

        </li>
        </g:if>

        <g:if test="${cursoInstance?.lastUpdated}">
        <li class="fieldcontain">
          <span id="lastUpdated-label" class="property-label"><g:message code="curso.lastUpdated.label" default="Last Updated" /></span>

            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${cursoInstance?.lastUpdated}" /></span>

        </li>
        </g:if>

      </ol>
      <g:form url="[resource:cursoInstance, action:'delete']" method="DELETE">
        <fieldset class="buttons">
          <g:link class="edit" action="edit" resource="${cursoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
