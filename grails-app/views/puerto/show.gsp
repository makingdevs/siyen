<%@ page import="com.siyen.Puerto" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'puerto.label', default: 'Puerto')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>

  <body>
    <a href="#create-puerto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div class="nav" role="navigation">
      <ul>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
      </ul>
    </div>
    <div id="show-puerto" class="content scaffold-show" role="main">
      <h1> Datos del puerto ${puertoInstance?.clave} </h1>
      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list puerto">
        <g:if test="${puertoInstance?.clave}">
          <li class="fieldcontain">
            <span id="clave-label" class="property-label"><g:message code="puerto.clave.label" default="Clave" /></span>
              <span class="property-value" aria-labelledby="clave-label"><g:fieldValue bean="${puertoInstance}" field="clave"/></span>
          </li>
        </g:if>
      
        <g:if test="${puertoInstance?.puerto}">
          <li class="fieldcontain">
            <span id="puerto-label" class="property-label"><g:message code="puerto.puerto.label" default="Puerto" /></span>
              <span class="property-value" aria-labelledby="puerto-label"><g:fieldValue bean="${puertoInstance}" field="puerto"/></span>
          </li>
        </g:if>
      
        <g:if test="${puertoInstance?.estado}">
          <li class="fieldcontain">
            <span id="estado-label" class="property-label"><g:message code="puerto.estado.label" default="Estado" /></span>
              <span class="property-value" aria-labelledby="estado-label"><g:fieldValue bean="${puertoInstance}" field="estado"/></span>
          </li>
        </g:if>
      
        <g:if test="${puertoInstance?.direccion}">
          <li class="fieldcontain">
            <span id="direccion-label" class="property-label"><g:message code="puerto.direccion.label" default="Direccion" /></span>
              <span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${puertoInstance}" field="direccion"/></span>
          </li>
        </g:if>
      
        <g:if test="${puertoInstance?.activo}">
          <li class="fieldcontain">
            <span id="activo-label" class="property-label"><g:message code="puerto.activo.label" default="Activo" /></span>
              <span class="property-value" aria-labelledby="activo-label"><g:formatBoolean boolean="${puertoInstance?.activo}" /></span>
          </li>
        </g:if>
      
        <g:if test="${puertoInstance?.dateCreated}">
          <li class="fieldcontain">
            <span id="dateCreated-label" class="property-label"><g:message code="puerto.dateCreated.label" default="Date Created" /></span>
              <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${puertoInstance?.dateCreated}" /></span>
            
        </li>
        </g:if>
      
        <g:if test="${puertoInstance?.lastUpdated}">
          <li class="fieldcontain">
            <span id="lastUpdated-label" class="property-label"><g:message code="puerto.lastUpdated.label" default="Last Updated" /></span>
              <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${puertoInstance?.lastUpdated}" /></span>
          </li>
        </g:if>
      </ol>

      <g:form>
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${puertoInstance?.id}" />
          <g:link class="edit" action="edit" id="${puertoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>

    </div>
  </body>
</html>
