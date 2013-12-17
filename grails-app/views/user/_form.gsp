<%@ page import="com.siyen.User" %>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
  <label class="control-label" for="username">
    <g:message code="user.username.label" default="Username" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="username" required="" value="${userInstance?.username}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
  <label class="control-label" for="password">
    <g:message code="user.password.label" default="Password" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:field type="password" name="password" required="" value="${userInstance?.password}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
  <label class="control-label" for="accountExpired">
    <g:message code="user.accountExpired.label" default="Account Expired" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
  <label class="control-label" for="accountLocked">
    <g:message code="user.accountLocked.label" default="Account Locked" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
  <label class="control-label" for="enabled">
    <g:message code="user.enabled.label" default="Enabled" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="enabled" value="${userInstance?.enabled}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'instructores', 'error')} ">
  <label class="control-label" for="instructores">
    <g:message code="user.instructores.label" default="Instructores" />
  </label>
  <div class="controls">
    <g:select name="instructores" from="${com.siyen.Instructor.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.instructores*.id}" class="many-to-many"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
  <label class="control-label" for="passwordExpired">
    <g:message code="user.passwordExpired.label" default="Password Expired" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'puertos', 'error')} ">
  <label class="control-label" for="puertos">
    <g:message code="user.puertos.label" default="Puertos" />
  </label>
  <div class="controls">
    <g:select name="puertos" from="${com.siyen.Puerto.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.puertos*.id}" class="many-to-many"/>
  </div>
</div>

