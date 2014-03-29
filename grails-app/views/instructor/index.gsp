<%@ page import="com.siyen.Instructor" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'instructor.label', default: 'Instructor')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="list-instructor" class="content scaffold-list" role="main">
      <h1>Catálogo de instructores</h1>
      <g:if test="${flash.message}">
      	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <table class="table table-condensed table-hover table-striped">
        <thead>
          <tr>
            <g:sortableColumn property="nombre" title="${message(code: 'instructor.nombre.label', default: 'Nombre')}" />
            <g:sortableColumn property="numeroDeOficio" title="${message(code: 'instructor.numeroDeOficio.label', default: 'Numero De Oficio')}" />
            <g:sortableColumn property="activo" title="${message(code: 'instructor.activo.label', default: 'Activo')}" />
            <g:sortableColumn property="dateCreated" title="${message(code: 'instructor.dateCreated.label', default: 'Date Created')}" />
            <g:sortableColumn property="lastUpdated" title="${message(code: 'instructor.lastUpdated.label', default: 'Last Updated')}" />
          </tr>
        </thead>
        <tbody>
        <g:each in="${instructorInstanceList}" status="i" var="instructorInstance">
          <tr>
            <td><g:link action="show" id="${instructorInstance.id}">${fieldValue(bean: instructorInstance, field: "nombre")}</g:link></td>
            <td>${fieldValue(bean: instructorInstance, field: "numeroDeOficio")}</td>
            <td><g:formatBoolean boolean="${instructorInstance.activo}" /></td>
            <td><g:formatDate date="${instructorInstance.dateCreated}" /></td>
            <td><g:formatDate date="${instructorInstance.lastUpdated}" /></td>
          </tr>
        </g:each>
        </tbody>
      </table>
      <div class="pagination">
        <g:paginate total="${instructorInstanceCount ?: 0}" />
      </div>
    </div>
  </body>
</html>
