package com.siyen

class EstadoDeCuentaController {

  def index() {
    def puertos = [ puertos : Puerto.findAll { it.activo } ]
    def instructores = [ instructores : Instructor.findAll { it.activo } ]
    [ instructores : instructores, puertos : puertos ]
  }

}
