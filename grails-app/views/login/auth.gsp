<html>
  <head>
    <meta name='layout' content='catalogoSiyenMenu'/>
    <title><g:message code="springSecurity.login.title"/></title>

    <asset:stylesheet src="auth/form.css"/>
  </head>

  <body>
    <form action='${postUrl}' method='POST' id='loginForm' class='form-signin' autocomplete='off'>
      <h3 class="form-signin-heading"><g:message code="springSecurity.login.header"/></h3>

      <input type="text" class="input-block-level" name='j_username' id='username' placeholder="Correo" autocomplete="off" keyev="true" clickev="true">
      <input type="password" class="input-block-level" name='j_password' id='password' placeholder="Contraseña" autocomplete="off" keyev="true" clickev="true">

      <button class="btn btn-large btn-primary" type="submit">${message(code: "springSecurity.login.button")}</button>
      <div class='inner'>
        <g:if test='${flash.message}'>
        <div class='login_message'>${flash.message}</div>
        </g:if>
      </div>
    </form>
    <asset:javascript src="auth/form.js"/>
  </body>
</html>


