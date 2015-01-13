package com.siyen

@grails.validation.Validateable
class PayUResponseCommand {
    String merchantId
    String transactionState
    String risk
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
    String cus
    String pseBank
    String lng
    String description
    String lapResponseCode
    String lapPaymentMethodType
    String lapTransactionState
    String message
    String extra1
    String extra2
    String extra3
    String authorizationCode
    String merchant_address
    String merchant_name
    String merchant_url
    String orderLanguage
    String pseCycle
    String pseReference1
    String pseReference2
    String pseReference3
    String telephone
    String transactionId
    String trazabilityCode
    String TX_ADMINISTRATIVE_FEE
    String TX_TAX_ADMINISTRATIVE_FEE
    String TX_TAX_ADMINISTRATIVE_FEE_RETURN_BASE
    String action_code_description
    String cc_holder
    String cc_number
    String processing_date_time
    String request_number

    static constraints = {
    }
}