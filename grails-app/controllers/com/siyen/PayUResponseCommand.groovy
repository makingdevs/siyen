package com.siyen

@grails.validation.Validateable
class PayUResponseCommand {
  def grailsApplication

  String merchantId
  String transactionState
  String referenceCode
  String reference_pol
  String signature
  String polPaymentMethod
  String polPaymentMethodType
  String installmentsNumber
  String TX_VALUE
  String TX_TAX
  String buyerEmail
  String processingDate
  String currency
  String description
  String lapResponseCode
  String lapPaymentMethodType
  String lapTransactionState
  String message
  String authorizationCode
  String merchant_address
  String merchant_name
  String orderLanguage
  String telephone
  String transactionId
  String trazabilityCode
  String TX_ADMINISTRATIVE_FEE
  String TX_TAX_ADMINISTRATIVE_FEE
  String TX_TAX_ADMINISTRATIVE_FEE_RETURN_BASE

  static constraints = {
    merchantId blank: false, validator: {val, obj -> val == obj.grailsApplication.config.grails.app.payu.merchantId}
    referenceCode blank: false
    signature blank: false
  }
}