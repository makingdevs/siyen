package com.siyen

class ParticipanteController {

  def index() {
    [ participante : Alumno.findByNumeroDeControl(params.matricula) ]
  }

}