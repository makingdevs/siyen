<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="catalogoSiyenMenu">
    <g:set var="entityName" value="${message(code: 'puerto.label', default: 'Puerto')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#list-puerto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="list-puerto" class="content scaffold-list" role="main">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
      </g:if>
      <f:table collection="${puertoList}" />

      <div class="pagination">
        <g:paginate total="${puertoCount ?: 0}" />
      </div>
    </div>
  </body>
</html>
