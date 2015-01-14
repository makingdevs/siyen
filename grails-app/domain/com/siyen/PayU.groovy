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

  static contraints = {
    transactionState nullable:true
    reference_pol nullable:true
    polPaymentMethod nullable:true
    polPaymentMethodType nullable:true
    installmentsNumber nullable:true
    tx_value nullable:true
    tx_tax nullable:true
    buyerEmail nullable:true
    processingDate nullable:true
    currency nullable:true
    lapResponseCode nullable:true
    lapPaymentMethodType nullable:true
    lapTransactionState nullable:true
    message nullable:true
    authorizationCode nullable:true
    transactionId nullable:true
    trazabilityCode nullable:true
    tx_administrative_fee nullable:true
    tx_tax_administrative_fee nullable:true
    tx_tax_administrative_fee_return_base nullable:true
  }
}