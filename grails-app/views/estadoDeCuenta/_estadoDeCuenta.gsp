<%@ page import="com.siyen.TipoDePago" %>

<h1> Del ${fechaDeInicio.format("dd 'de' MMMM")} al ${fechaDeTermino.format("dd 'de' MMMM 'del' yyyy")}</h1>
<h2> ${puerto.puerto}, ${puerto.estado} </h2>
<h3> Usuario : ${user.username} </h3>

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
        <td> ${ it.curso.clave } </td>
        <td> ${ it.dateCreated.format('dd/MM/yyyy') } </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.BECADO }.sum(0) { a -> a.monto ?: 0 } } </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.DEPOSITO_BANCARIO }.sum(0) { a -> a.monto } } </td>
        <td> ${ it.alumnos.findAll { a -> a.tipoDePago == TipoDePago.EFECTIVO }.sum(0) { a -> a.monto } } </td>
        <td> ${ it.alumnos.sum(0) { a -> a.monto ?: 0 } } </td>
      </tr>
    </g:each>
    <tr>
      <td></td>
      <td></td>
      <td>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.BECADO }.sum(0) { a -> a.monto } }</td>
      <td>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.DEPOSITO_BANCARIO }.sum(0) { a -> a.monto } }</td>
      <td>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.EFECTIVO }.sum(0) { a -> a.monto } }</td>
      <td>${ cursosProgramados*.alumnos.flatten().sum(0) { a -> a.monto ?: 0 } }</td>
    <tr>
  </tbody>
</table>

<h1 id="total"> Total : ${ cursosProgramados*.alumnos.flatten().sum(0) { a -> a.monto ?: 0 } } </td>

<div>
  <div class="input-prepend input-append">
    <input class="span2" id="porcentaje" type="text" value="20">
    <span class="add-on">%</span>
    <button class="btn" type="button">Calcular porcentaje</button>
  </div>
</div>
