package com.siyen

import grails.transaction.Transactional

@Transactional
class PayUService {

  def grailsApplication

    def guardarRespuestaPayU(payUResponseCommand) {
      def payU = PayU.findByReferenceCode(payUResponseCommand.referenceCode)
      if(!payU){
        payU = new PayU()
        payU.merchantId = payUResponseCommand.merchantId
        payU.description = payUResponseCommand.description
        payU.transactionState = payUResponseCommand.transactionState
        payU.referenceCode = payUResponseCommand.referenceCode
        payU.reference_pol = payUResponseCommand.reference_pol
        payU.signature = payUResponseCommand.signature
        payU.polPaymentMethod = payUResponseCommand.polPaymentMethod
        payU.polPaymentMethodType = payUResponseCommand.polPaymentMethodType
        payU.installmentsNumber = payUResponseCommand.installmentsNumber
        payU.tx_value = payUResponseCommand.TX_VALUE
        payU.tx_tax = payUResponseCommand.TX_TAX
        payU.buyerEmail = payUResponseCommand.buyerEmail
        payU.processingDate = payUResponseCommand.processingDate
        payU.currency = payUResponseCommand.currency
        payU.lapResponseCode = payUResponseCommand.lapResponseCode
        payU.lapPaymentMethodType = payUResponseCommand.lapPaymentMethodType
        payU.lapTransactionState = payUResponseCommand.lapTransactionState
        payU.message = payUResponseCommand.message
        payU.authorizationCode = payUResponseCommand.authorizationCode
        payU.transactionId = payUResponseCommand.transactionId
        payU.trazabilityCode = payUResponseCommand.trazabilityCode
        payU.tx_administrative_fee = payUResponseCommand.TX_ADMINISTRATIVE_FEE
        payU.tx_tax_administrative_fee = payUResponseCommand.TX_TAX_ADMINISTRATIVE_FEE
        payU.tx_tax_administrative_fee_return_base = payUResponseCommand.TX_TAX_ADMINISTRATIVE_FEE_RETURN_BASE
        payU.save()
      }
      payU
    }

  def actualizarConfirmacionPayU(payUConfirmationCommand){
    log.debug "confirmación del sistema payU -- ${payUConfirmationCommand}"
    def payU = PayU.findByReferenceCode(payUConfirmationCommand.reference_sale)
    
    if(!payU){
      payU = new PayU()
    }
    
    payU.merchantId = payUConfirmationCommand.merchant_id
    payU.state_pol = payUConfirmationCommand.state_pol
    payU.referenceCode = payUConfirmationCommand.reference_sale
    payU.reference_pol = payUConfirmationCommand.reference_pol
    payU.signConfirmation = payUConfirmationCommand.sign
    payU.payment_method = payUConfirmationCommand.payment_method
    payU.payment_method_type = payUConfirmationCommand.payment_method_type
    payU.installmentsNumber = payUConfirmationCommand.installments_number
    payU.tx_value = payUConfirmationCommand.value
    payU.tx_tax = payUConfirmationCommand.tax
    payU.transaction_date = payUConfirmationCommand.transaction_date
    payU.currency = payUConfirmationCommand.currency
    payU.buyerEmail = payUConfirmationCommand.email_buyer
    payU.test = payUConfirmationCommand.test
    payU.description = payUConfirmationCommand.description
    payU.account_number_ach = payUConfirmationCommand.account_number_ach
    payU.account_type_ach = payUConfirmationCommand.account_type_ach
    payU.tx_administrative_fee = payUConfirmationCommand.administrative_fee
    payU.tx_tax_administrative_fee_return_base = payUConfirmationCommand.administrative_fee_base
    payU.tx_tax_administrative_fee = payUConfirmationCommand.administrative_fee_tax
    payU.attempts = payUConfirmationCommand.attempts
    payU.authorizationCode = payUConfirmationCommand.authorization_code
    payU.bank_id = payUConfirmationCommand.bank_id
    payU.commision_pol = payUConfirmationCommand.commision_pol
    payU.commision_pol_currency = payUConfirmationCommand.commision_pol_currency
    payU.customer_number = payUConfirmationCommand.customer_number
    payU.date = payUConfirmationCommand.date
    payU.error_code_bank = payUConfirmationCommand.error_code_bank
    payU.error_message_bank = payUConfirmationCommand.error_message_bank
    payU.payment_method_id = payUConfirmationCommand.payment_method_id
    payU.payment_request_state = payUConfirmationCommand.payment_request_state
    payU.response_message_pol = payUConfirmationCommand.response_message_pol
    payU.transaction_bank_id = payUConfirmationCommand.transaction_bank_id
    payU.transactionId = payUConfirmationCommand.transaction_id
    payU.save()
    payU
  }
  /*
  * Validación de firma como lo pide la documentación de PayU
  */
  def validateSignature(value,reference_sale,currency,state_pol,sign){

    def arrayValue = value.split("\\.")
    def entero = arrayValue[0]
    def amount = "${entero}.0"

    if(arrayValue.size() > 1){
      amount = arrayValue[1].toInteger() > 0 ?"${entero}.${arrayValue[1]}":amount
    }

    def signature = grailsApplication.config.grails.app.payu.apiKey+"~"+
          grailsApplication.config.grails.app.payu.merchantId+"~"+
          reference_sale+"~"+amount+"~"+currency+"~"+state_pol

    log.debug "comparacion de firmas ---> ${sign} == ${signature.encodeAsMD5()} >>> ${sign == signature.encodeAsMD5()}"
    
    sign == signature.encodeAsMD5()
  }
}
