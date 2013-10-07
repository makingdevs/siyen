package com.siyen

import grails.converters.*

class InstructorController {

  static scaffold = true

  def springSecurityService

  def jsonList() {
    def jsonResponse = [ instructores : springSecurityService.currentUser.instructores.findAll { it.activo } ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

}
