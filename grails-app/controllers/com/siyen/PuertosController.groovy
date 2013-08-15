package com.siyen

class PuertosController {

  static allowedMethods = [list : "GET"]

  def list() {
    render(contentType:"text/json") {
      [ puertos : Puerto.list() ]
    }
  }

}
