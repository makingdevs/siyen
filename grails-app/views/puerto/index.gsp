<%@ page import="com.siyen.Puerto" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'puerto.label', default: 'Puerto')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#list-puerto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="list-puerto" class="content scaffold-list" role="main">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>
      <table class="table table-condensed table-hover table-striped">
      <thead>
          <tr>

            <g:sortableColumn property="clave" title="${message(code: 'puerto.clave.label', default: 'Clave')}" />

            <g:sortableColumn property="puerto" title="${message(code: 'puerto.puerto.label', default: 'Puerto')}" />

            <g:sortableColumn property="estado" title="${message(code: 'puerto.estado.label', default: 'Estado')}" />

            <g:sortableColumn property="direccion" title="${message(code: 'puerto.direccion.label', default: 'Direccion')}" />

            <g:sortableColumn property="activo" title="${message(code: 'puerto.activo.label', default: 'Activo')}" />

            <g:sortableColumn property="dateCreated" title="${message(code: 'puerto.dateCreated.label', default: 'Date Created')}" />

          </tr>
        </thead>
        <tbody>
        <g:each in="${puertoInstanceList}" status="i" var="puertoInstance">
          <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show" id="${puertoInstance.id}">${fieldValue(bean: puertoInstance, field: "clave")}</g:link></td>

            <td>${fieldValue(bean: puertoInstance, field: "puerto")}</td>

            <td>${fieldValue(bean: puertoInstance, field: "estado")}</td>

            <td>${fieldValue(bean: puertoInstance, field: "direccion")}</td>

            <td><g:formatBoolean boolean="${puertoInstance.activo}" /></td>

            <td><g:formatDate date="${puertoInstance.dateCreated}" /></td>

          </tr>
        </g:each>
        </tbody>
      </table>
      <div class="pagination">
        <g:paginate total="${puertoInstanceCount ?: 0}" />
      </div>
    </div>
  </body>
</html>
