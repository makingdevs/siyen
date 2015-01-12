package com.siyen

class PayUController {

    def index() { }

    def response(){
      log.debug "respuesta del sistema payU --- ${params}"
    }

    def confirmation(){
      log.debug "confirmación del sistema payU -- ${params}"
    }

}
