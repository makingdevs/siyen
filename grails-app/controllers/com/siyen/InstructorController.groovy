package com.siyen

import grails.converters.*

class InstructorController {

  static scaffold = Instructor

  def springSecurityService

  def jsonList() {
    def jsonResponse = [ instructores : springSecurityService.currentUser.instructores.findAll { it.activo } ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

  def view(Long id) {
    def jsonResponse = [ instructores : Instructor.get(id) ]
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

}
