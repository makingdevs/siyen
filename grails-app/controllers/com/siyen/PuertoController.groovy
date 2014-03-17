package com.siyen

import grails.converters.*

class PuertoController {

  static scaffold = true

  def springSecurityService

  def jsonList() {
    def jsonResponse = [ puertos : springSecurityService.currentUser.puertos.findAll { it.activo } ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

  def view(Long id) {
    def jsonResponse = [ puertos : Puerto.get(id) ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

}
