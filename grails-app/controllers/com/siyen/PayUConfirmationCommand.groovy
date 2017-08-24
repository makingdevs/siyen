package com.siyen

import grails.validation.Validateable

class PayUConfirmationCommand implements Validateable {

  def grailsApplication
  def payUService

  String merchant_id
  String state_pol
  String response_code_pol
  String reference_sale
  String reference_pol
  String sign
  String payment_method
  String payment_method_type
  String installments_number
  String value
  String tax
  String transaction_date
  String currency
  String email_buyer
  String test
  String description
  String account_number_ach
  String account_type_ach
  String administrative_fee
  String administrative_fee_base
  String administrative_fee_tax
  String attempts
  String authorization_code
  String bank_id
  String commision_pol
  String commision_pol_currency
  String customer_number
  String date
  String error_code_bank
  String error_message_bank
  String nickname_buyer
  String nickname_seller
  String payment_method_id
  String payment_request_state
  String response_message_pol
  String transaction_bank_id
  String transaction_id

  static constraints = {
    merchant_id blank: false, validator: {val, obj -> val == obj.grailsApplication.config.grails.app.payu.merchantId}
    reference_sale blank: false, nullable: false
    value blank: false, nullable: false
    currency blank: false, nullable: false
    state_pol blank: false, nullable: false
    sign blank: false, validator: {val, obj -> obj.payUService.validateSignature(obj.value,obj.reference_sale,obj.currency,obj.state_pol,val)}
  }
}
