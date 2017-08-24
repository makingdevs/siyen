<%@ page import="com.siyen.TipoDePago" %>

<g:if test="${cursosProgramados.size() > 0}">
<h1> Del ${fechaDeInicio.format("dd 'de' MMMM")} al ${fechaDeTermino.format("dd 'de' MMMM 'del' yyyy")}</h1>
<h2> ${puerto.puerto}, ${puerto.estado} </h2>
<h3> Instructor : ${instructor.nombre} </h3>

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
    <tr class="info">
      <td></td>
      <td></td>
      <td><b>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.BECADO }.sum(0) { a -> a.monto?:0 } }</b></td>
      <td><b>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.DEPOSITO_BANCARIO }.sum(0) { a -> a.monto } }</b></td>
      <td><b>${ cursosProgramados*.alumnos.flatten().findAll { a -> a.tipoDePago == TipoDePago.EFECTIVO }.sum(0) { a -> a.monto } }</b></td>
      <td><b>${ cursosProgramados*.alumnos.flatten().sum(0) { a -> a.monto ?: 0 } }</td>
    <tr>
  </tbody>
</table>

<h1> Total : $<span id="total">${ cursosProgramados*.alumnos.flatten().sum(0) { a -> a.monto ?: 0 } }</span></h1>

<div>
  <div class="input-prepend input-append">
    <input class="span2" id="porcentaje" type="text" value="20">
    <span class="add-on">%</span>
    <button class="btn" id="calcular" type="button">Calcular porcentaje</button>
  </div>

  <div id="totalPorcentaje"></div>
</div>
</g:if>
<g:else>
  <div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <h4>Resultado vacío</h4>
    No se han encontrado resultados para tu búsqueda con los siguientes criterios:
    <lu>
      <li>Instructor : <strong>${instructor.nombre}</strong> </li>
      <li>${puerto.puerto}, <strong>${puerto.estado}</strong></li>
      <li>Del <strong>${fechaDeInicio.format("dd 'de' MMMM")}</strong> al <strong>${fechaDeTermino.format("dd 'de' MMMM 'del' yyyy")}</strong></li>
    </lu>
  </div>
</g:else>