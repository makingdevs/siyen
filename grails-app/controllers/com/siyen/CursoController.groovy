package com.siyen

class CursoController {

  static scaffold = true

  def mostrar(Long id) {
    render(contentType:"text/json") {
      [ curso : Curso.get(id) ]
    }
  }

}
