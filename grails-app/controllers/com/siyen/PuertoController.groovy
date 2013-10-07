package com.siyen

class PuertoController {

  static scaffold = true

  def jsonList() {
    render(contentType:"text/json") {
      [ puertos : Puerto.findAll { activo == true } ]
    }
  }

}
