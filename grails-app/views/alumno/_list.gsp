<p class="text-info"> Para la búsqueda :
  <span id="totalResultados" class="badge badge-info">${busqueda}</span>
  se han encontrado :
  <span id="totalResultados" class="badge badge-info">${totalResultados} </span> resultados
</p>

<table class="table table-condensed table-striped table-hover">
  <thead>
    <tr>
      <th>Número de control</th>
      <th>Nombre completo</th>
      <th>Observaciones</th>
      <th>Monto</th>
      <th>Número de curso</th>
      <th>Clave del curso</th>
    </tr>
  </thead>
  <tbody>
    <g:each in="${lista}">
      <tr>
        <td>${it.numeroDeControl}</td>
        <td>${it.nombreCompleto}</td>
        <td>${it.observaciones}</td>
        <td>${it.monto}</td>
        <td>${it.cursoProgramado.id}</td>
        <td>${it.cursoProgramado.curso.clave}</td>
        <td>
          <a href="#/alumnos/${it.id}" class="btn btn-primary"><i class="icon-edit icon-white"></i></a>
          <button id="impresionDeAlumno" class="btn btn-success" name="${it.id}"><i class="icon-print icon-white"></i></button>
        </td>
      </tr>
    </g:each>
  </tbody>
</table>

<div class="pagination pagination-centered">
  <ul>
    <li>
      <g:paginate total="${totalResultados}" params="[buscar : busqueda]" />
    </li>
  </ul>
</div>
