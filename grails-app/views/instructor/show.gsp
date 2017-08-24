<%@ page import="com.siyen.Instructor" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'instructor.label', default: 'Instructor')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#show-instructor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="show-instructor" class="content scaffold-show" role="main">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list instructor">

        <g:if test="${instructorInstance?.nombre}">
        <li class="fieldcontain">
          <span id="nombre-label" class="property-label"><g:message code="instructor.nombre.label" default="Nombre" /></span>

            <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${instructorInstance}" field="nombre"/></span>

        </li>
        </g:if>

        <g:if test="${instructorInstance?.numeroDeOficio}">
        <li class="fieldcontain">
          <span id="numeroDeOficio-label" class="property-label"><g:message code="instructor.numeroDeOficio.label" default="Numero De Oficio" /></span>

            <span class="property-value" aria-labelledby="numeroDeOficio-label"><g:fieldValue bean="${instructorInstance}" field="numeroDeOficio"/></span>

        </li>
        </g:if>

        <g:if test="${instructorInstance?.activo}">
        <li class="fieldcontain">
          <span id="activo-label" class="property-label"><g:message code="instructor.activo.label" default="Activo" /></span>

            <span class="property-value" aria-labelledby="activo-label"><g:formatBoolean boolean="${instructorInstance?.activo}" /></span>

        </li>
        </g:if>

        <g:if test="${instructorInstance?.dateCreated}">
        <li class="fieldcontain">
          <span id="dateCreated-label" class="property-label"><g:message code="instructor.dateCreated.label" default="Date Created" /></span>

            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${instructorInstance?.dateCreated}" /></span>

        </li>
        </g:if>

        <g:if test="${instructorInstance?.lastUpdated}">
        <li class="fieldcontain">
          <span id="lastUpdated-label" class="property-label"><g:message code="instructor.lastUpdated.label" default="Last Updated" /></span>

            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${instructorInstance?.lastUpdated}" /></span>

        </li>
        </g:if>

      </ol>
      <g:form url="[resource:instructorInstance, action:'delete']" method="DELETE">
        <fieldset class="buttons">
          <g:link class="edit" action="edit" resource="${instructorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
