<%@ page import="com.siyen.Curso" %>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'clave', 'error')} required">
  <label for="clave">
    <g:message code="curso.clave.label" default="Clave" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="clave" maxlength="30" required="" value="${cursoInstance?.clave}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'nombre', 'error')} required">
  <label for="nombre">
    <g:message code="curso.nombre.label" default="Nombre" />
    <span class="required-indicator">*</span>
  </label>
  <g:textArea name="nombre" cols="40" rows="5" maxlength="255" required="" value="${cursoInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'duracion', 'error')} required">
  <label for="duracion">
    <g:message code="curso.duracion.label" default="Duracion" />
    <span class="required-indicator">*</span>
  </label>
  <g:field name="duracion" value="${fieldValue(bean: cursoInstance, field: 'duracion')}" required="" placeholder="0,0"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'libreta', 'error')} required">
  <label for="libreta">
    <g:message code="curso.libreta.label" default="Libreta" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="libreta" maxlength="1" required="" value="${cursoInstance?.libreta}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'englishName', 'error')} ">
  <label for="englishName">
    <g:message code="curso.englishName.label" default="English Name" />

  </label>
  <g:textArea name="englishName" cols="40" rows="5" maxlength="10000" value="${cursoInstance?.englishName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'description', 'error')} ">
  <label for="description">
    <g:message code="curso.description.label" default="Description" />

  </label>
  <g:textArea name="description" cols="40" rows="5" maxlength="10000" value="${cursoInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'activo', 'error')} ">
  <label for="activo">
    <g:message code="curso.activo.label" default="Activo" />

  </label>
  <g:checkBox name="activo" value="${cursoInstance?.activo}" />

</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'ingles', 'error')} ">
  <label for="ingles">
    <g:message code="curso.ingles.label" default="Ingles" />

  </label>
  <g:checkBox name="ingles" value="${cursoInstance?.ingles}" />

</div>

