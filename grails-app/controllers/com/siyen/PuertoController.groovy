package com.siyen

class PuertoController {

  static scaffold = true

  def mostrar(Long id) {
    render(contentType:"text/json") {
      [ puerto : Puerto.get(id) ]
    }
  }

}
