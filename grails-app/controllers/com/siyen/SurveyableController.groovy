package com.siyen

class SurveyableController {

  def show(Long id) {
    render template:'show', model:[alumno : Alumno.get(id)]
  }

}
