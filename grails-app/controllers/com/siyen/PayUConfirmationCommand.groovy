package com.siyen

@grails.validation.Validateable
class PayUConfirmationCommand {

  String merchant_id
  String state_pol
  String risk
  String response_code_pol
  String reference_sale
  String reference_pol
  String sign
  String extra1
  String extra2
  String payment_method
  String payment_method_type
  String installments_number
  String value
  String tax
  String additional_value
  String transaction_date
  String currency
  String email_buyer
  String cus
  String pse_bank
  String test
  String description
  String billing_address
  String shipping_address
  String phone
  String office_phone
  String account_number_ach
  String account_type_ach
  String administrative_fee
  String administrative_fee_base
  String administrative_fee_tax
  String airline_code
  String attempts
  String authorization_code
  String bank_id
  String billing_city
  String billing_country
  String commision_pol
  String commision_pol_currency
  String customer_number
  String date
  String error_code_bank
  String error_message_bank
  String exchange_rate
  String ip
  String nickname_buyer
  String nickname_seller
  String payment_method_id
  String payment_request_state
  String pseReference1
  String pseReference2
  String pseReference3
  String response_message_pol
  String shipping_city
  String shipping_country
  String transaction_bank_id
  String transaction_id
  
  static constraints = {}
}