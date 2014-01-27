<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
  <head>
    <style type="text/css">
      body {
        font-family : Helvetica;
        text-align : justify;
        padding-top : 200px;
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
        width : 690px;
        margin-left:auto;
        margin-right:auto;
        font-size : 15px;
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
        line-height:20%;
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

      <table>
        <thead>
          <tr>
            <th>Curso</th>
            <th>Fecha Inicio</th>
            <th>Fecha Fin</th>
            <th>Nombre de Curso</th>
            <th>Clave</th>
            <th>Participantes</th>
          </tr>
        </thead>
        <tbody>
          <g:each in="${data.cursos?.sort({ it.id })}" var="it" status="i">
            <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
              <td> ${it.id} </td>
              <td> ${it.fechaDeInicio.format('dd/MMMM/yyyy')} </td>
              <td> ${it.fechaDeTermino.format('dd/MMMM/yyyy')} </td>
              <td> ${it.curso.nombre} </td>
              <td> ${it.curso.clave} </td>
              <td> ${it.alumnos.size()} </td>
            </tr>
          </g:each>
        </tbody>
      </table>
    </div>


    <div>
      <p> De los cuales adjuntamos las constancias que amparan la participación de los tripulantes para su entrega </p>

      <table>
        <thead>
          <tr>
            <th>Curso</th>
            <th>No. Control</th>
            <th>Nombre</th>
          </tr>
        </thead>
        <tbody>
          <g:each in="${data.cursos*.alumnos.flatten().sort({it.numeroDeControl})}" var="it" status="i">
            <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
              <td style="width:10%"> ${it.cursoProgramado.id} </td>
              <td style="width:10%"> ${it.numeroDeControl} </td>
              <td> ${it.nombreCompleto} </td>
            </tr>
          </g:each>
        </tbody>
      </table>
      <p> Agradeciendo de antemano sus atenciones me reitero con un atento saludo. </p>
    </div>

    <div class="center">
      <p> ${data.deParteDe} </p>
      <p> INSTRUCTOR </p>
    </div>

    <footer>
      <p> c.c.p. Dirección General de Marina Mercante </p>
      <p> c.c.p. Instructor </p>
      <p> c.c.p. Expediente </p>
    </footer>

  </body>
</html>
