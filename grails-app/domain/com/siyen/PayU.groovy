package com.siyen

class PayU {
  
  String merchantId
  String transactionState
  String referenceCode
  String reference_pol
  String signature
  String polPaymentMethod
  String polPaymentMethodType
  String installmentsNumber
  String tx_value
  String tx_tax
  String buyerEmail
  String processingDate
  String currency
  String lapResponseCode
  String lapPaymentMethodType
  String lapTransactionState
  String message
  String authorizationCode
  String transactionId
  String trazabilityCode
  String tx_administrative_fee
  String tx_tax_administrative_fee
  String tx_tax_administrative_fee_return_base

  static constraints = {
    transactionState blank: true, nullable: true
    reference_pol blank: true, nullable: true
    polPaymentMethod blank: true, nullable: true
    polPaymentMethodType blank: true, nullable: true
    installmentsNumber blank: true, nullable: true
    tx_value blank: true, nullable: true
    tx_tax blank: true, nullable: true
    buyerEmail blank: true, nullable: true
    processingDate blank: true, nullable: true
    currency blank: true, nullable: true
    lapResponseCode blank: true, nullable: true
    lapPaymentMethodType blank: true, nullable: true
    lapTransactionState blank: true, nullable: true
    message blank: true, nullable: true
    authorizationCode blank: true, nullable: true
    transactionId blank: true, nullable: true
    trazabilityCode blank: true, nullable: true
    tx_administrative_fee blank: true, nullable: true
    tx_tax_administrative_fee blank: true, nullable: true
    tx_tax_administrative_fee_return_base blank: true, nullable: true
  }
}