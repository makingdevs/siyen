<%@ page import="com.siyen.User" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="list-user" class="content scaffold-list" role="main">
      <h1>Catálogo de usuarios</h1>
      <g:if test="${flash.message}">
      	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <table class="table table-condensed table-hover table-striped">
        <thead>
          <tr>
            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
            <g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" />
            <g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" />
            <g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />
            <g:sortableColumn property="passwordExpired" title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" />
            <th>Permisos</th>
          </tr>
        </thead>
        <tbody>
        <g:each in="${userInstanceList}" status="i" var="userInstance">
          <tr>
            <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
            <td><g:formatBoolean boolean="${userInstance.accountExpired}" /></td>
            <td><g:formatBoolean boolean="${userInstance.accountLocked}" /></td>
            <td><g:formatBoolean boolean="${userInstance.enabled}" /></td>
            <td><g:formatBoolean boolean="${userInstance.passwordExpired}" /></td>
            <td><g:link controller="userRole" action="permisos" id="${userInstance.id}">Asignar/Cambiar</g:link></td>
          </tr>
        </g:each>
        </tbody>
      </table>
      <div class="pagination">
        <g:paginate total="${userInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
