package com.siyen

class PayUController {

  def payUService
  def springSecurityService

  def index() { 
    [ 
      username : springSecurityService.currentUser.username,
      cursos : Curso.findAll { activo == true }.collect{it.nombre},
      referenceCode : "PAYU_RC_${new Date().format('dd-MM-yyyy-HH-mm')}_${Math.abs(new Random().nextInt() % 600) + 1}"
    ]
  }

  def response(PayUResponseCommand payUResponseCommand){

    if(payUResponseCommand.hasErrors()){
      render (status : 400, contentType:"text/json") {
        [ errors : payUResponseCommand.properties ]
      }
      return
    }

    def payU = payUService.guardarRespuestaPayU(payUResponseCommand)

    if(!payU){
      render (status : 500, contentType:"text/json") {
        [ errors : "no se guardaron datos de la transaccion" ]
      }
      return
    }

    render(view: "responsePayU", model: [payUResponse: payUResponseCommand])
  }

  def confirmation(PayUConfirmationCommand payUConfirmationCommand){

    if(payUConfirmationCommand.hasErrors()){
      render (status : 400, contentType:"text/json") {
        [ errors : "bad request" ]
      }
      return
    }

    def payU = payUService.actualizarConfirmacionPayU(payUConfirmationCommand)

    if(!payU){
      render (status : 500, contentType:"text/json") {
        [ errors : "no se guardaron datos de la transaccion" ]
      }
      return
    }

    render (status : 200, contentType:"text/json") {
      [ success : "Datos almacenados" ]
    }
  }

}
