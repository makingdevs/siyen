<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="catalogoSiyenMenu"/>
  <title>Create questionary</title>
</head>
<body>
  <div class="container">
    <div class="jumbotron">
      <h1>PIPE Pago</h1>
      <p class="lead">Ahora puedes pagar tus cursos desde la comodidad de tu hogar u obten un cupón de pago para pagos en efectivos</p>
    </div>
    <hr>
    <div class="row-fluid">
      <div class="span6">
        <h2>Medios de pagos</h2>
        <div class="bs-docs-example">
          <dl class="dl-horizontal">
            <dt>Tarjeta de débito</dt>
            <dd>Paga con tu tarjeta Visa o MasterCard</dd>
            <dt>Tarjeta de crédito</dt>
            <dd>Paga con tu tarjeta Visa, MasterCard o AmericanExpress</dd>
            <dt>Cupón de pago</dt>
            <dd>Elige los siguientes puntos de pagos:</dd>
            <dd>OXXO</dd>
            <dd>Bancomer</dd>
            <dd>Farmacias del Ahorro</dd>
            <dd>IXE Banco</dd>
            <dd>Scotiabank</dd>
            <dd>Super Farmacia</dd>
            <dd>7 Eleven</dd>
            <dd>Banco Santander</dd>
            <dd>Extra</dd>
            <dd>24 puntos de pagos adicionales...</dd>
          </dl>
        </div>
     </div>
      <div class="span6">
        <div class="hero-unit">
          <h2>Paga tu curso</h2>
          <form class="form-horizontal" method="post" action="https://stg.gateway.payulatam.com/ppp-web-gateway/">
            <input name="merchantId"    type="hidden"  value="${grailsApplication.config.grails.app.payu.merchantId}">
            <input name="accountId"     type="hidden"  value="${grailsApplication.config.grails.app.payu.accountId}">
            <input name="referenceCode" type="hidden"  value="TestPayU">
            <input name="amount"        type="hidden"  value="600">
            <input name="tax"           type="hidden"  value="0">
            <input name="taxReturnBase" type="hidden"  value="0">
            <input name="currency"      type="hidden"  value="${grailsApplication.config.grails.app.payu.currency}">
            <input name="signature"     type="hidden"  value="${grailsApplication.config.grails.app.payu.signature}">
            <input name="test"          type="hidden"  value="${grailsApplication.config.grails.app.payu.test}">
            <input name="responseUrl"    type="hidden"  value="${createLink(controller:'payU', action:'response')}">
            <input name="confirmationUrl"    type="hidden"  value="${createLink(controller:'payU', action:'confirmation')}">
            <div class="control-group">
              <label class="control-label" for="inputEmail">Nombre de curso</label>
              <div class="controls">
                <g:select name="description" from="${['Pesca','Seguridad','Primeros auxilios']}" value="${description}" noSelection="['':'-Elige un curso-']"/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Nombre</label>
              <div class="controls">
                <input type="text" name="payerFullName" placeholder="Alumno">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="inputEmail">Email</label>
              <div class="controls">
                <input type="text" name="buyerEmail" value="test@test.com">
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="inputEmail" >Precio MXN</label>
              <div class="controls">
                <input type="text" value="$600" disabled="disbaled">
              </div>
            </div>
            <div class="control-group">
              <div class="controls">
                <button type="submit" class="btn">Enviar</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    </div>
</body>
</html>