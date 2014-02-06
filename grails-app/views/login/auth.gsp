<html>
<head>
  <meta name='layout' content='catalogoSiyenMenu'/>
  <title><g:message code="springSecurity.login.title"/></title>
  <style type='text/css' media='screen'>
    .form-signin {
      max-width: 400px;
      padding: 19px 29px 29px;
      margin: 0 auto 20px;
      background-color: #fff;
      border: 1px solid #e5e5e5;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
      -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
      -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
      box-shadow: 0 1px 2px rgba(0,0,0,.05);
    }

    input {
      background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=);
      padding-right: 0px;
      background-attachment: scroll;
      cursor: auto;
      background-position: 100% 50%;
      background-repeat: no-repeat no-repeat;
    }

    .inner {
      font-size: 18px;
      font-weight: bold;
      padding: 25px 0 0 0;
      color: #c33;
    }

  </style>
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
  <script type='text/javascript'>
    <!--
    (function() {
      document.forms['loginForm'].elements['j_username'].focus();
    })();
  // -->
  </script>
</body>
</html>


