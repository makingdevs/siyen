<%@ page import="com.siyen.TipoDePago" %>

<h1> Del ${fechaDeInicio.format("dd 'de' MMMM")} al ${fechaDeTermino.format("dd 'de' MMMM 'del' yyyy")}</h1>
<h2> ${puerto.puerto}, ${puerto.estado} </h2>
<h3> Usuario : ${instructor.nombre} </h3>

<table class="table table-condensed table-striped table-hover">
  <thead>
    <tr>
      <th>Curso</th>
      <th>Fecha</th>
      <th>Becado</th>
      <th>Depósito Bancario</th>
      <th>Efectivo</th>
      <th>Subtotal</th>
    </tr>
  </thead>
  <tbody>
    <g:each in="${cursosProgramados}">
      <tr>
        <td> ${it.curso.clave} </td>
        <td> ${it.dateCreated.format('dd/MM/yyyy')} </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.BECADO }.sum(0) { a -> a.monto } } </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.DEPOSITO_BANCARIO }.sum(0) { a -> a.monto } } </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.EFECTIVO }.sum(0) { a -> a.monto } } </td>
        <td> ${ it.alumnos.sum(0) { a -> a.monto } } </td>
      </tr>
    </g:each>
  </tbody>
</table>
