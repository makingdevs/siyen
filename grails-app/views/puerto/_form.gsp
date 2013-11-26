<%@ page import="com.siyen.Puerto" %>

<div class="control-group fieldcontain ${hasErrors(bean: puertoInstance, field: 'clave', 'error')} required">
  <label class="control-label" for="clave">
    <g:message code="puerto.clave.label" default="Clave" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="clave" maxlength="4" required="" value="${puertoInstance?.clave}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: puertoInstance, field: 'puerto', 'error')} required">
  <label class="control-label" for="puerto">
    <g:message code="puerto.puerto.label" default="Puerto" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="puerto" maxlength="35" required="" value="${puertoInstance?.puerto}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: puertoInstance, field: 'estado', 'error')} required">
  <label class="control-label" for="estado">
    <g:message code="puerto.estado.label" default="Estado" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
  	<g:textField name="estado" maxlength="30" required="" value="${puertoInstance?.estado}"/>
	</div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: puertoInstance, field: 'direccion', 'error')} ">
  <label class="control-label" for="direccion">
    <g:message code="puerto.direccion.label" default="Direccion" />
  </label>
  <div class="controls">
  	<g:textArea name="direccion" cols="40" rows="5" maxlength="500" value="${puertoInstance?.direccion}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: puertoInstance, field: 'activo', 'error')} ">
  <label class="control-label" for="activo">
    <g:message code="puerto.activo.label" default="Activo" />
  </label>
  <div class="controls">
  	<label class="checkbox">
  		<g:checkBox name="activo" value="${puertoInstance?.activo}" />
  	</label>
  </div>
</div>

