<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils" %>

<form action='${request.contextPath}/login/authenticate' method='POST' id='loginForm' autocomplete='off'>
  <fieldset class='textbox' style="padding:10px">
    <input type="text" name='username' id='username' placeholder="Correo" style="margin-top: 8px">
    <input type="password" placeholder="Contraseña" name='password' id='password' style="margin-top: 8px">
    <button class="btn btn-primary" type="submit" name="commit">
      ${message(code: "springSecurity.login.button")}
    </button>
  </fieldset>
</form>
