<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <asset:javascript modules="bootstrap.js" />
    <asset:stylesheet src="logout.css"/>

    <g:layoutHead/>
  </head>

  <body>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">PIPE</a>
          <div class="nav-collapse collapse">
            <ul class="nav pull-right">
              <sec:ifNotLoggedIn>
                <li class="dropdown custom">
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#menu1">
                    Ingresa al PIPE
                    <b class="caret"></b>
                  </a>
                  <ul class="dropdown-menu">
                    <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]" class="navbar-form"/>
                  </ul>
                </li>
                <li class="custom">
                  <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]" class="navbar-form"/>
                </li>
              </sec:ifNotLoggedIn>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <hr>
    <footer>
      <div class="footer">
        <p>&copy; Siyen 2013</p>
      </div>
    </footer>

  </body>
</html>
