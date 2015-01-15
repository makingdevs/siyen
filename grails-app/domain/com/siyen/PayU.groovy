package com.siyen

class PayU {
  
  String merchantId
  String description
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
  //campos extras por confirmacion PayU
  String state_pol
  String signConfirmation
  String payment_method
  String payment_method_type
  String transaction_date
  String test
  String account_number_ach
  String account_type_ach
  String attempts
  String bank_id
  String commision_pol
  String commision_pol_currency
  String customer_number
  String date
  String error_code_bank
  String error_message_bank
  String payment_method_id
  String payment_request_state
  String response_message_pol
  String transaction_bank_id


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

    state_pol blank: true, nullable: true
    signConfirmation blank: true, nullable: true
    payment_method blank: true, nullable: true
    payment_method_type blank: true, nullable: true
    transaction_date blank: true, nullable: true
    test blank: true, nullable: true
    account_number_ach blank: true, nullable: true
    account_type_ach blank: true, nullable: true
    attempts blank: true, nullable: true
    bank_id blank: true, nullable: true
    commision_pol blank: true, nullable: true
    commision_pol_currency blank: true, nullable: true
    customer_number blank: true, nullable: true
    date blank: true, nullable: true
    error_code_bank blank: true, nullable: true
    error_message_bank blank: true, nullable: true
    payment_method_id blank: true, nullable: true
    payment_request_state blank: true, nullable: true
    response_message_pol blank: true, nullable: true
    transaction_bank_id blank: true, nullable: true
    description blank: true, nullable: true
    signature blank: true, nullable: true
  }
}