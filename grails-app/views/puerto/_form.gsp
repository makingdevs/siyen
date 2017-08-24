<%@ page import="com.siyen.Puerto" %>

<div class="fieldcontain ${hasErrors(bean: puertoInstance, field: 'clave', 'error')} required">
  <label for="clave">
    <g:message code="puerto.clave.label" default="Clave" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="clave" maxlength="4" required="" value="${puertoInstance?.clave}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: puertoInstance, field: 'puerto', 'error')} required">
  <label for="puerto">
    <g:message code="puerto.puerto.label" default="Puerto" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="puerto" maxlength="35" required="" value="${puertoInstance?.puerto}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: puertoInstance, field: 'estado', 'error')} required">
  <label for="estado">
    <g:message code="puerto.estado.label" default="Estado" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="estado" maxlength="30" required="" value="${puertoInstance?.estado}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: puertoInstance, field: 'direccion', 'error')} required">
  <label for="direccion">
    <g:message code="puerto.direccion.label" default="Direccion" />
    <span class="required-indicator">*</span>
  </label>
  <g:textArea name="direccion" cols="40" rows="5" maxlength="500" required="" value="${puertoInstance?.direccion}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: puertoInstance, field: 'activo', 'error')} ">
  <label for="activo">
    <g:message code="puerto.activo.label" default="Activo" />

  </label>
  <g:checkBox name="activo" value="${puertoInstance?.activo}" />

</div>

