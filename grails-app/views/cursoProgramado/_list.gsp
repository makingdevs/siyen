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