package com.siyen

class SurveyableController {

  def show(Long id) {
    render view:'show', model:[alumno : Alumno.get(id)]
  }

}