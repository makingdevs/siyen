package com.siyen

class CursosController {

  static allowedMethods = [list : "GET"]

  def list() {
    render(contentType:"text/json") {
      [ cursos : Curso.list() ]
    }
  }

}
