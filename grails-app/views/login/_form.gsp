<%@ page import="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils" %>
<form action='${request.contextPath}${SpringSecurityUtils.securityConfig.apf.filterProcessesUrl}' method='POST' id='loginForm' autocomplete='off'>
 <fieldset class='textbox' style="padding:10px">
   <input type="text" name='j_username' id='username' placeholder="Usuario / correo" style="margin-top: 8px">
   <input type="password" placeholder="Password" name='j_password' id='password' style="margin-top: 8px">
   <label class="checkbox">
      <input type="checkbox" value="remember-me" name='${SpringSecurityUtils.securityConfig.rememberMe.parameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if> /> Remember me
    </label>
    <button class="btn btn-primary" type="submit" name="commit">
      ${message(code: "springSecurity.login.button")}
    </button>
 </fieldset>
</form>