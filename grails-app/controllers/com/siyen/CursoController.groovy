package com.siyen

import grails.converters.*

class CursoController {

  static scaffold = true

  def jsonList() {
    def jsonResponse = [ cursos : Curso.findAll { activo == true } ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

}
