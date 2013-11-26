<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width" />
    <title>. : Bienvenido a Siyen - <g:layoutTitle default="Principal"/> : .</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">


    <r:require modules="bootstrap" />

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }

      /* NAVIGATION MENU */
      th {
        background-color: #efefef;
        background-image: -moz-linear-gradient(top, #ffffff, #eaeaea);
        background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #ffffff), color-stop(1, #eaeaea));
            filter: progid:DXImageTransform.Microsoft.gradient(startColorStr = '#ffffff', EndColorStr = '#eaeaea');
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#eaeaea')";
        color: #666666;
        font-weight: bold;
        line-height: 1.7em;
        padding: 0.2em 0.6em;
      }

      thead th {
        white-space: nowrap;
      }

      th a {
        display: block;
        text-decoration: none;
      }

      th a:link, th a:visited {
        color: #666666;
      }

      th a:hover, th a:focus {
        color: #333333;
        text-decoration: none;
      }

      th.sortable a {
        background-position: right;
        background-repeat: no-repeat;
        padding-right: 1.1em;
      }

      th.asc a {
        background-image: url(../images/skin/sorted_asc.gif);
      }

      th.desc a {
        background-image: url(../images/skin/sorted_desc.gif);
      }

      /* PAGINATION */
      .pagination {
        border-top: 0;
        margin: 0;
        padding: 0.3em 0.2em;
        text-align: center;
           -moz-box-shadow: 0 0 3px 1px #AAAAAA;
        -webkit-box-shadow: 0 0 3px 1px #AAAAAA;
                box-shadow: 0 0 3px 1px #AAAAAA;
        background-color: #EFEFEF;
      }

      .pagination a,
      .pagination .currentStep {
        color: #666666;
        display: inline-block;
        margin: 0 0.1em;
        padding: 0.25em 0.7em;
        text-decoration: none;
           -moz-border-radius: 0.3em;
        -webkit-border-radius: 0.3em;
                border-radius: 0.3em;
      }

      .pagination a:hover, .pagination a:focus,
      .pagination .currentStep {
        background-color: #999999;
        color: #ffffff;
        outline: none;
        text-decoration: none;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.8);
      }

      .no-borderradius .pagination a:hover, .no-borderradius .pagination a:focus,
      .no-borderradius .pagination .currentStep {
        background-color: transparent;
        color: #444444;
        text-decoration: underline;
      }

    </style>

    <g:layoutHead/>
    <r:layoutResources />
  </head>

  <body>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="/#">Siyen</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <!-- BEGIN: Menu de opciones -->
                <li>
                  <g:link controller="puerto">Puerto</g:link>
                </li>
              <!-- END: Menu de opciones -->
            </ul>
            <sec:ifLoggedIn>
              <ul class="nav pull-right">
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                    <sec:loggedInUserInfo field="username"/>
                    <b class="caret"></b>
                  </a>
                  <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                    <li>
                      <g:link controller="logout" tabindex="-1">
                        Logout
                      </g:link>
                    </li>
                  </ul>
                </li>
              </ul>
            </sec:ifLoggedIn>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">
      <g:layoutBody />
      <hr>
      <footer>
        <div class="footer">
          <p>&copy; Siyen 2013</p>
        </div>
      </footer>
      <r:layoutResources />
    </div>
  </body>
</html>