package com.siyen

import grails.transaction.Transactional

@Transactional
class PayUService {

    def guardarRespuestaPayU(payUResponseCommand) {
      def payU = PayU.findByReferenceCode(payUResponseCommand.referenceCode)
      if(!payU){
        payU = new PayU()
        payU.merchantId = payUResponseCommand.merchantId
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

    def actualizarConfirmacionPayU(){

    }
}
