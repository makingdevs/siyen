<%@ page import="com.siyen.User" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>

  <body>
    <div id="show-user" class="content scaffold-show" role="main">
      <h1> Datos del usuario ${userInstance?.username} </h1>
      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list user">
        <g:if test="${userInstance?.username}">
          <li class="fieldcontain">
            <span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
            <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.password}">
          <li class="fieldcontain">
            <span id="password-label" class="property-label"><g:message code="user.password.label" default="Password" /></span>
            <span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${userInstance}" field="password"/></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.accountExpired}">
          <li class="fieldcontain">
            <span id="accountExpired-label" class="property-label"><g:message code="user.accountExpired.label" default="Account Expired" /></span>
            <span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.accountLocked}">
          <li class="fieldcontain">
            <span id="accountLocked-label" class="property-label"><g:message code="user.accountLocked.label" default="Account Locked" /></span>
            <span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.enabled}">
          <li class="fieldcontain">
            <span id="enabled-label" class="property-label"><g:message code="user.enabled.label" default="Enabled" /></span>
            <span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${userInstance?.enabled}" /></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.instructores}">
          <li class="fieldcontain">
            <span id="instructores-label" class="property-label"><g:message code="user.instructores.label" default="Instructores" /></span>
            <g:each in="${userInstance.instructores}" var="i">
              <span class="property-value" aria-labelledby="instructores-label"><g:link controller="instructor" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
            </g:each>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.passwordExpired}">
          <li class="fieldcontain">
            <span id="passwordExpired-label" class="property-label"><g:message code="user.passwordExpired.label" default="Password Expired" /></span>
            <span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></span>
          </li>
        </g:if>
      
        <g:if test="${userInstance?.puertos}">
          <li class="fieldcontain">
            <span id="puertos-label" class="property-label"><g:message code="user.puertos.label" default="Puertos" /></span>
            <g:each in="${userInstance.puertos}" var="p">
              <span class="property-value" aria-labelledby="puertos-label"><g:link controller="puerto" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
            </g:each>
          </li>
        </g:if>
      </ol>

      <g:form>
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${userInstance?.id}" />
          <g:link class="edit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>

    </div>
  </body>
</html>
