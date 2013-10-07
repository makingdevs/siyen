package com.siyen

class InstructorController {

  static scaffold = true

  def jsonList() {
    render(contentType:"text/json") {
      [ instructores : Instructor.findAll { activo == true } ]
    }
  }

}
