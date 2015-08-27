<%@ page import="com.siyen.Curso" %>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'clave', 'error')} required">
  <label class="control-label" for="clave">
    <g:message code="curso.clave.label" default="Clave" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="clave" maxlength="30" required="" value="${cursoInstance?.clave}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'nombre', 'error')} required">
  <label class="control-label" for="nombre">
    <g:message code="curso.nombre.label" default="Nombre" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textArea name="nombre" cols="40" rows="5" maxlength="255" required="" value="${cursoInstance?.nombre}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'duracion', 'error')} required">
  <label class="control-label" for="duracion">
    <g:message code="curso.duracion.label" default="Duracion" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:field name="duracion" type="number" max="5" value="${cursoInstance.duracion}" required=""/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'libreta', 'error')} required">
  <label class="control-label" for="libreta">
    <g:message code="curso.libreta.label" default="Libreta" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="libreta" maxlength="1" required="" value="${cursoInstance?.libreta}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'activo', 'error')} ">
  <label class="control-label" for="activo">
    <g:message code="curso.activo.label" default="Activo" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="activo" value="${cursoInstance?.activo}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'ingles', 'error')} ">
  <label class="control-label" for="ingles">
    <g:message code="curso.ingles.label" default="Ingles" />
  </label>
  <div class="controls">
    <label class="checkbox">
      <g:checkBox name="ingles" value="${cursoInstance?.ingles}" />
    </label>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'englishName', 'error')}">
  <label class="control-label" for="englishName">
    <g:message code="curso.englishName.label" default="Nombre en inglés" />
  </label>
  <div class="controls">
    <g:textArea name="englishName" cols="40" rows="5" value="${cursoInstance?.englishName}"/>
  </div>
</div>

<div class="fieldcontain ${hasErrors(bean: cursoInstance, field: 'description', 'error')}">
  <label class="control-label" for="description">
    <g:message code="curso.description.label" default="Descripción (Ambos idiomas)" />
  </label>
  <div class="controls">
    <g:textArea name="description" cols="40" rows="5" value="${cursoInstance?.description}"/>
  </div>
</div>
