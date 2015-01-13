package com.siyen

class PayUController {

    def index() { }

    def response(PayUResponseCommand payUResponseCommand){
      log.debug "respuesta del sistema payU --- ${payUResponseCommand}"
      render(view: "responsePayU", model: [payUResponse: payUResponseCommand])
    }

    def confirmation(PayUConfirmationCommand payUConfirmationCommand){
      log.debug "confirmación del sistema payU -- ${payUConfirmationCommand}"
    }

}
