<%@ page import="com.siyen.User" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="create-user" class="content scaffold-create" role="main">
      <h1>Permisos de ${user.username}</h1>
      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${userInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${userInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
      </g:hasErrors>

      <g:form action="save" class="form-horizontal">

        <g:hiddenField name="id" value="${user.id}" />

        <div class="control-group">
          <label class="control-label" for="roles">
            <g:message code="user.roles.label" default="Roles" />
          </label>
          <div class="controls">
            <g:each in="${com.siyen.Role.list()}" var="role">
              <label class="checkbox">
                <g:if test="${user.authorities*.id.contains(role.id)}">
                  <input type='checkbox' name='authorities' checked="true" value="${role.id}"> ${role.authority}
                </g:if>
                <g:else>
                  <input type='checkbox' name='authorities' value="${role.id}"> ${role.authority}
                </g:else>
              </label>
              <br />
            </g:each>
          </div>
        </div>

        <fieldset class="buttons">
          <g:submitButton name="create" class="save" value="${message(code: 'default.button.assign.label', default: 'Asignar')}" />
        </fieldset>

      </g:form>

    </div>
  </body>
</html>