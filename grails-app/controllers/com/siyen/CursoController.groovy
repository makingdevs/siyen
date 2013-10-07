package com.siyen

class CursoController {

  static scaffold = true

  def jsonList() {
    render(contentType:"text/json") {
      [ cursos : Curso.findAll { activo == true } ]
    }
  }

}
