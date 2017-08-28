<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="list-user" class="content scaffold-list" role="main">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
      </g:if>

      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <th> ${message(code: 'user.username.label', default: 'Username')} </th>
            <th> ${message(code: 'user.accountExpired.label', default: 'Account Expired')} </th>
            <th> ${message(code: 'user.accountLocked.label', default: 'Account Locked')} </th>
            <th> ${message(code: 'user.enabled.label', default: 'Enabled')} </th>
            <th> ${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" </th>
            <th>Permisos</th>
          </tr>
        </thead>
        <tbody>
          <g:each in="${userList}" var="userInstance">
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
    </div>

    <div class="pagination">
      <g:paginate total="${userCount ?: 0}" />
    </div>
    </div>
  </body>
</html>
