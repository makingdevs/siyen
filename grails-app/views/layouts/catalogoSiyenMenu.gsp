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

      /* GENERAL */
      .content {
      }

      .content h1 {
        border-bottom: 1px solid #CCCCCC;
        margin: 0.8em 1em 0.3em;
        padding: 0 0.25em;
      }

      .scaffold-list h1 {
        border: none;
      }
      /* NAVIGATION MENU */
      .nav ul {
        overflow: hidden;
        padding-left: 0;
        zoom: 1;
      }

      .nav li {
        display: block;
        float: left;
        list-style-type: none;
        margin-right: 0.5em;
        padding: 0;
      }

      .nav a {
        color: #666666;
        display: block;
        padding: 0.25em 0.7em;
        text-decoration: none;
           -moz-border-radius: 0.3em;
        -webkit-border-radius: 0.3em;
                border-radius: 0.3em;
      }

      .nav a:active, .nav a:visited {
        color: #666666;
      }

      .nav a:focus, .nav a:hover {
        text-decoration: none;
        background-color: #999999;
        color: #ffffff;
        outline: none;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.8);
      }

      .no-borderradius .nav a:focus, .no-borderradius .nav a:hover {
        background-color: transparent;
        color: #444444;
        text-decoration: underline;
      }

      .nav a.home, .nav a.list, .nav a.create {
        background-position: 0.7em center;
        background-repeat: no-repeat;
        text-indent: 25px;
      }

      .nav a.home {
        background-image: url(/images/skin/house.png);
      }

      .nav a.list {
        background-image: url(/images/skin/database_table.png);
      }

      .nav a.create {
        background-image: url(/images/skin/database_add.png);
      }
      /* CREATE/EDIT FORMS AND SHOW PAGES */
      fieldset,
      .property-list {
        margin: 0.6em 1.25em 0 1.25em;
        padding: 0.3em 1.8em 1.25em;
        position: relative;
        zoom: 1;
        border: none;
      }

      .property-list .fieldcontain {
        list-style: none;
        overflow: hidden;
        zoom: 1;
      }

      .fieldcontain {
        margin-top: 1em;
      }

      .fieldcontain label,
      .fieldcontain .property-label {
        color: #666666;
        text-align: right;
        width: 25%;
      }

      .fieldcontain .property-label {
        float: left;
      }

      .fieldcontain .property-value {
        display: block;
        margin-left: 27%;
      }

      label {
        cursor: pointer;
        display: inline-block;
        margin: 0 0.25em 0 0;
      }

      input, select, textarea {
        background-color: #fcfcfc;
        border: 1px solid #cccccc;
        font-size: 1em;
        padding: 0.2em 0.4em;
      }

      select {
        padding: 0.2em 0.2em 0.2em 0;
      }

      select[multiple] {
        vertical-align: top;
      }

      textarea {
        width: 250px;
        height: 150px;
        overflow: auto; /* IE always renders vertical scrollbar without this */
        vertical-align: top;
      }

      input[type=checkbox], input[type=radio] {
        background-color: transparent;
        border: 0;
        padding: 0;
      }

      input:focus, select:focus, textarea:focus {
        background-color: #ffffff;
        border: 1px solid #eeeeee;
        outline: 0;
           -moz-box-shadow: 0 0 0.5em #ffffff;
        -webkit-box-shadow: 0 0 0.5em #ffffff;
                box-shadow: 0 0 0.5em #ffffff;
      }

      .required-indicator {
        color: #48802C;
        display: inline-block;
        font-weight: bold;
        margin-left: 0.3em;
        position: relative;
        top: 0.1em;
      }

      ul.one-to-many {
        display: inline-block;
        list-style-position: inside;
        vertical-align: top;
      }

      .ie6 ul.one-to-many, .ie7 ul.one-to-many {
        display: inline;
        zoom: 1;
      }

      ul.one-to-many li.add {
        list-style-type: none;
      }

      /* EMBEDDED PROPERTIES */

      fieldset.embedded {
        background-color: transparent;
        border: 1px solid #CCCCCC;
        margin-left: 0;
        margin-right: 0;
        padding-left: 0;
        padding-right: 0;
           -moz-box-shadow: none;
        -webkit-box-shadow: none;
                box-shadow: none;
      }

      fieldset.embedded legend {
        margin: 0 1em;
      }

      /* MESSAGES AND ERRORS */

      .errors,
      .message {
        font-size: 0.8em;
        line-height: 2;
        margin: 1em 2em;
        padding: 0.25em;
      }

      .message {
        background: #f3f3ff;
        border: 1px solid #b2d1ff;
        color: #006dba;
           -moz-box-shadow: 0 0 0.25em #b2d1ff;
        -webkit-box-shadow: 0 0 0.25em #b2d1ff;
                box-shadow: 0 0 0.25em #b2d1ff;
      }

      .errors {
        background: #fff3f3;
        border: 1px solid #ffaaaa;
        color: #cc0000;
           -moz-box-shadow: 0 0 0.25em #ff8888;
        -webkit-box-shadow: 0 0 0.25em #ff8888;
                box-shadow: 0 0 0.25em #ff8888;
      }

      .errors ul,
      .message {
        padding: 0;
      }

      .errors li {
        list-style: none;
        background: transparent url(../images/skin/exclamation.png) 0.5em 50% no-repeat;
        text-indent: 2.2em;
      }

      .message {
        background: transparent url(../images/skin/information.png) 0.5em 50% no-repeat;
        text-indent: 2.2em;
      }

      /* form fields with errors */

      .error input, .error select, .error textarea {
        background: #fff3f3;
        border-color: #ffaaaa;
        color: #cc0000;
      }

      .error input:focus, .error select:focus, .error textarea:focus {
           -moz-box-shadow: 0 0 0.5em #ffaaaa;
        -webkit-box-shadow: 0 0 0.5em #ffaaaa;
                box-shadow: 0 0 0.5em #ffaaaa;
      }

      /* same effects for browsers that support HTML5 client-side validation (these have to be specified separately or IE will ignore the entire rule) */

      input:invalid, select:invalid, textarea:invalid {
        background: #fff3f3;
        border-color: #ffaaaa;
        color: #cc0000;
      }

      input:invalid:focus, select:invalid:focus, textarea:invalid:focus {
           -moz-box-shadow: 0 0 0.5em #ffaaaa;
        -webkit-box-shadow: 0 0 0.5em #ffaaaa;
                box-shadow: 0 0 0.5em #ffaaaa;
      }

      /* TABLES */

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

      /* ACTION BUTTONS */
      .buttons {
        background-color: #efefef;
        overflow: hidden;
        padding: 0.3em;
           -moz-box-shadow: 0 0 3px 1px #aaaaaa;
        -webkit-box-shadow: 0 0 3px 1px #aaaaaa;
                box-shadow: 0 0 3px 1px #aaaaaa;
        margin: 0.1em 0 0 0;
        border: none;
      }

      .buttons input,
      .buttons a {
        background-color: transparent;
        border: 0;
        color: #666666;
        cursor: pointer;
        display: inline-block;
        margin: 0 0.25em 0;
        overflow: visible;
        padding: 0.25em 0.7em;
        text-decoration: none;

           -moz-border-radius: 0.3em;
        -webkit-border-radius: 0.3em;
                border-radius: 0.3em;
      }

      .buttons input:hover, .buttons input:focus,
      .buttons a:hover, .buttons a:focus {
        background-color: #999999;
        color: #ffffff;
        outline: none;
        text-decoration: none;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.8);
           -moz-box-shadow: none;
        -webkit-box-shadow: none;
                box-shadow: none;
      }

      .no-borderradius .buttons input:hover, .no-borderradius .buttons input:focus,
      .no-borderradius .buttons a:hover, .no-borderradius .buttons a:focus {
        background-color: transparent;
        color: #444444;
        text-decoration: underline;
      }

      .buttons .delete, .buttons .edit, .buttons .save {
        background-position: 0.7em center;
        background-repeat: no-repeat;
        text-indent: 25px;
      }

      .ie6 .buttons input.delete, .ie6 .buttons input.edit, .ie6 .buttons input.save,
      .ie7 .buttons input.delete, .ie7 .buttons input.edit, .ie7 .buttons input.save {
        padding-left: 36px;
      }

      .buttons .delete {
        background-image: url(/images/skin/database_delete.png);
      }

      .buttons .edit {
        background-image: url(/images/skin/database_edit.png);
      }

      .buttons .save {
        background-image: url(/images/skin/database_save.png);
      }

      a.skip {
        position: absolute;
        left: -9999px;
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
              <li class="dropdown">
                <a data-toggle="dropdown" class="dropdown-toggle" role="button" href="#" id="drop10">
                  Puertos<b class="caret"></b>
                </a>
                <ul aria-labelledby="drop10" role="menu" class="dropdown-menu">
                  <li>
                    <g:link class="list" action="list"> Listado de puertos </g:link>
                  </li>
                  <li>
                    <li>
                      <g:link class="create" action="create"> Nuevo puerto </g:link>
                    </li>
                  </li>
                </ul>
              </li>
              <!-- END: Menu de opciones -->
            </ul>
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