<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
  <head>
    <style type="text/css">
      body {
        font-family : Helvetica;
        text-align : justify;
        padding-top : 170px;
      }

      div.right {
        text-align : right;
      }

      div.center {
        text-align : center;
      }

      span {
        font-weight:bold;
      }

      table {
        border-collapse:collapse;
        width : 100%;
        margin-left:auto;
        margin-right:auto;
        font-size : 15px;
        margin-bottom:10px;
      }

      table th {
        font-weight : bold;
        border-bottom : 1px solid black;
        text-align  : left;
      }

      table td {
        padding : 5px;
      }

      .odd {
        background-color: #ECECEC
      }

      .even {
        background-color: #FFFFFF
      }

      footer {
        font-size : 12px;
      }
    </style>
  </head>

  <body>
    <div>
      <h3> ${data.dirigidoA.toUpperCase()} </h3>
      <h3> ${data.puesto.toUpperCase()} </h3>
      <h3> ${data.direccion.toUpperCase()} </h3>
      <div class="right">
        <p> ${data.fechaActual} </p>
        <p> ${data.puertoFechaAbbr} </p>
      </div>
    </div>


    <div>
      <p> Distinguido Capitán de Puerto</p>
      <p> El <span> Instituto de Educación Náutica y Portuaria Océano Pacífico S.A. de C.V.</span>, impartió en <span>${data.puerto}</span> del <span>${data.desde} al ${data.hasta}</span> los curso de : </p>

      <g:each in="${data.cursos}">
        <div style="border-top:1px dashed black; border-bottom:1px solid black; text-align:left">
          <h3>${it.key.split('-')[0]} <br /><small>${it.key.split('-')[1]}</small></h3>
        </div>
        <g:each in="${it.value.sort({it.id})}" var="cursoProgramado">
          <div>
            <p>Con número de curso <strong>${cursoProgramado.id}</strong> realizado del ${cursoProgramado.fechaDeInicio.format("dd 'de' MMMM")} al ${cursoProgramado.fechaDeTermino.format("dd 'de' MMMM 'del' yyyy")}, con los siguientes participantes </p>
          </div>
          <ul>
            <g:each in="${cursoProgramado.alumnos.sort({it.numeroDeControl})}" var="alumno" status="i">
              <li> ${alumno.numeroDeControl} - ${alumno.nombreCompleto} </li>
            </g:each>
          </ul>
        </g:each>
      </g:each>
    </div>

    <div>
      <p> Agradeciendo de antemano sus atenciones me reitero con un atento saludo. </p>
      <br />
      <br />
    </div>

    <div class="center">
      <p> ${data.deParteDe} </p>
      <p> INSTRUCTOR </p>
    </div>

    <footer>
      <div> c.c.p. Dirección General de Marina Mercante </div>
      <div> c.c.p. Instructor </div>
      <div> c.c.p. Expediente </div>
      <div> c.c.p. Capitanía de Puerto </div>
    </footer>

  </body>
</html>
