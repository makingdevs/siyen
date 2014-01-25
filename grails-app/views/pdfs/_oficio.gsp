<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
  <head>
  </head>

  <body>
    <div>
      <h3> ${data.dirigidoA.toUpperCase()} </h3>
      <h3> ${data.puesto.toUpperCase()} </h3>
      <h3> ${data.direccion.toUpperCase()} </h3>
      <p> ${data.fechaActual} </p>
      <p> ${data.puertoFechaAbbr} </p>
    </div>


    <div>
      <p> Distinguido Capitán de Puerto</p>
      <p> El Instituto de Educación Náutica y Portuaria Océano Pacífico S.A. de C.V., impartió en ${data.puerto} del ${data.desde} al ${data.hasta} los curso de : </p>

      <ul>
        <g:each in="${data.cursos}">
          <li> ${it.id} - ${it.fechaDeInicio} - ${it.curso.nombre} </li>
        </g:each>
      </ul>
    </div>


    <div>
      <p> De los cuales adjuntamos las constancias que amparan la participación de los tripulantes para su entrega </p>

      <ul>
        <g:each in="${data.cursos*.alumnos.flatten()}">
          <li> ${it.cursoProgramado.id} - ${it.nombreCompleto} </li>
        </g:each>
      </ul>
    </div>

  </body>
</html>
