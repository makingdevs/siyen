<%@ page import="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils" %>
<form action='${request.contextPath}${SpringSecurityUtils.securityConfig.apf.filterProcessesUrl}' method='POST' id='loginForm' autocomplete='off'>
 <fieldset class='textbox' style="padding:10px">
   <input type="text" name='j_username' id='username' placeholder="Correo" style="margin-top: 8px">
   <input type="password" placeholder="Contraseña" name='j_password' id='password' style="margin-top: 8px">
    <button class="btn btn-primary" type="submit" name="commit">
      ${message(code: "springSecurity.login.button")}
    </button>
 </fieldset>
</form>
