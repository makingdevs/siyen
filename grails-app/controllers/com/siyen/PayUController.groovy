package com.siyen

class PayUController {

    def index() { 
      [ 
        cursos : Curso.findAll { activo == true }.collect{it.nombre},
        referenceCode : "PAYU_RC_${new Date().format('dd-MM-yyyy-HH-mm')}_${Math.abs(new Random().nextInt() % 600) + 1}"
      ]
    }

    def response(PayUResponseCommand payUResponseCommand){
      log.debug "respuesta del sistema payU --- ${payUResponseCommand}"
      render(view: "responsePayU", model: [payUResponse: payUResponseCommand])
    }

    def confirmation(PayUConfirmationCommand payUConfirmationCommand){
      log.debug "confirmación del sistema payU -- ${payUConfirmationCommand}"
    }

}
