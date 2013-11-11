<p class="text-info"> Para la búsqueda :
  <span id="totalResultados" class="badge badge-info">${busqueda}</span>
  <span id="totalResultados" class="badge badge-info">${cursos}</span>
  <span id="totalResultados" class="badge badge-info">${puertos}</span>
  <span id="totalResultados" class="badge badge-info">${instructores}</span>
  <span id="totalResultados" class="badge badge-info">${desde}</span>
  <span id="totalResultados" class="badge badge-info">${hasta}</span>
  se han encontrado :
  <span id="totalResultados" class="badge badge-info">${totalResultados} </span> resultados
</p>

<table class="table table-condensed table-striped table-hover">
  <thead>
    <tr>
      <th>Numero de curso</th>
      <th>Fecha de inicio</th>
      <th>Fecha de termino</th>
      <th>Puerto</th>
      <th>Curso</th>
      <th>Instructor</th>
      <th>Participantes</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <g:each in="${lista}">
      <tr>
        <td>${it.id}</td>
        <td><g:formatDate format="dd/MMMM/yyyy" date="${it.fechaDeInicio}"/></td>
        <td><g:formatDate format="dd/MMMM/yyyy" date="${it.fechaDeTermino}"/></td>
        <td>${it.puerto.clave} - ${it.puerto.puerto}</td>
        <td>${it.curso.clave}</td>
        <td>${it.instructor.nombre}</td>
        <td>${it.alumnos.size()}</td>
        <td></td>
      </tr>
    </g:each>
  </tbody>
</table>

<div class="pagination pagination-centered">
  <ul>
    <li>
      <g:paginate total="${totalResultados}" params="[buscar : busqueda, cursos : cursos, puertos : puertos, instructores : instructores, desde : desde, hasta : hasta]" />
    </li>
  </ul>
</div>