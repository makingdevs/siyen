<%@ page import="com.siyen.Instructor" %>

<div class="fieldcontain ${hasErrors(bean: instructorInstance, field: 'nombre', 'error')} required">
  <label class="control-label" for="nombre">
    <g:message code="instructor.nombre.label" default="Nombre" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textArea name="nombre" cols="40" rows="5" maxlength="255" required="" value="${instructorInstance?.nombre}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: instructorInstance, field: 'numeroDeOficio', 'error')} required">
  <label class="control-label" for="numeroDeOficio">
    <g:message code="instructor.numeroDeOficio.label" default="Numero De Oficio" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="numeroDeOficio" maxlength="50" required="" value="${instructorInstance?.numeroDeOficio}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: instructorInstance, field: 'activo', 'error')} ">
  <label class="control-label" for="activo">
    <g:message code="instructor.activo.label" default="Activo" />
  </label>
  <div class="controls">
    <g:checkBox name="activo" value="${instructorInstance?.activo}" />
  </div>
</div>

