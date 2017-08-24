<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Respuesta PayU</title>
</head>
<body>
  <div class="container">
    <div class="well">
      Transacción realizada para el curso <strong>${payUResponse.description}</strong>.
    </div>
    <h4>Detalles del pago</h4>
    <hr/>
    <div class="row">
      <div class="span5">
        <table class="table">
          <thead>
            <tr>
              <th>${payUResponse.description}</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Subtotal</td>
              <td>${payUResponse.TX_VALUE}</td>
            </tr>
            <tr>
              <td>Impuesto</td>
              <td>${payUResponse.TX_TAX}</td>
            </tr>
            <tr>
              <td>Total ${payUResponse.currency}</td>
              <td>${payUResponse.TX_VALUE}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="span3">
        <address>
          <strong>${payUResponse.merchant_name}</strong>
          <br>
          <br>${payUResponse.merchant_address}<br>
          <abbr title="Phone">P:</abbr> ${payUResponse.telephone}
        </address>
      </div>
      <div class="span4">
        <address>
          <strong>Código de Referencia</strong><br>${payUResponse.referenceCode}<br>
        </address>
        <address>
          <strong>Estado de la transacción</strong><br>${payUResponse.message}<br>
        </address>
        <p>
          <a href="${createLink(controller:'payU')}"class="btn btn-primary pull-right" type="button">Realizar otro pago</a>
        </p>
      </div>
    </div>
</body>
</html>