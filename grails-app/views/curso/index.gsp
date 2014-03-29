<%@ page import="com.siyen.Curso" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'curso.label', default: 'Curso')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="list-curso" class="content scaffold-list" role="main">
      <h1>Catálogo de cursos</h1>
      <g:if test="${flash.message}">
      	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <table class="table table-condensed table-hover table-striped">
        <thead>
          <tr>
            <g:sortableColumn property="clave" title="${message(code: 'curso.clave.label', default: 'Clave')}" />
            <g:sortableColumn property="nombre" title="${message(code: 'curso.nombre.label', default: 'Nombre')}" />
            <g:sortableColumn property="duracion" title="${message(code: 'curso.duracion.label', default: 'Duracion')}" />
            <g:sortableColumn property="libreta" title="${message(code: 'curso.libreta.label', default: 'Libreta')}" />
            <g:sortableColumn property="activo" title="${message(code: 'curso.activo.label', default: 'Activo')}" />
            <g:sortableColumn property="dateCreated" title="${message(code: 'curso.dateCreated.label', default: 'Date Created')}" />
          </tr>
        </thead>
        <tbody>
        <g:each in="${cursoInstanceList}" status="i" var="cursoInstance">
          <tr>
            <td><g:link action="show" id="${cursoInstance.id}">${fieldValue(bean: cursoInstance, field: "clave")}</g:link></td>
            <td>${fieldValue(bean: cursoInstance, field: "nombre")}</td>
            <td>${fieldValue(bean: cursoInstance, field: "duracion")}</td>
            <td>${fieldValue(bean: cursoInstance, field: "libreta")}</td>
            <td><g:formatBoolean boolean="${cursoInstance.activo}" /></td>
            <td><g:formatDate date="${cursoInstance.dateCreated}" /></td>
          </tr>
        </g:each>
        </tbody>
      </table>
      <div class="pagination">
				<g:paginate total="${cursoInstanceCount ?: 0}" />
      </div>
    </div>
  </body>
</html>
