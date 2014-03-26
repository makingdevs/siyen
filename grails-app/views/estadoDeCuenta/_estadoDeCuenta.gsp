<%@ page import="com.siyen.TipoDePago" %>

<h4> Cursos </h4>

<g:each in="${cursosProgramados}">
  <p> ${it.curso.clave} </p>

  <table class="table table-condensed table-striped table-hover">
    <thead>
      <tr>
        <th>Tipo de pago</th>
        <th>Monto</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${TipoDePago.values()}" var="tipoDePago">
        <tr>
          <td> ${tipoDePago} </td>
          <td> ${ it.alumnos.findAll { a -> a.tipoDePago == tipoDePago }.sum(0) { a -> a.monto } } </td>
        </tr>
      </g:each>
    </tbody>
  </table>
</g:each>

