<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <r:require modules="bootstrap, emberjs, application" />
    <g:layoutHead/>
    <r:layoutResources />

  </head>

  <body>
    <script type="text/x-handlebars" data-template-name="application">
      <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">Siyen</a>
            <div class="nav-collapse collapse">
              <ul class="nav">
                <!-- BEGIN: Menu de opciones -->
                  <li>
                    {{#linkTo "registros" }}Cursos programados{{/linkTo}}
                  </li>
                <!-- END: Menu de opciones -->
              </ul>
            </div><!--/.nav-collapse -->
          </div>
        </div>
      </div>

      <div class="container">
        {{ outlet }}

        <hr>
        <footer>
          <div class="footer">
            <p>&copy; Siyen 2013</p>
          </div>
        </footer>

      </div>
    </script>
    
    <r:layoutResources />
  </body>
</html>