package com.siyen

class EstadoDeCuentaController {

  def index() {
    [ puertos : Puerto.findAll { it.activo }, instructores : Instructor.findAll { it.activo } ]
  }

  def generarEstadoDeCuenta() {
    Date fechaDeInicio = Date.parse("dd/MMMMM/yyyy", params.fechaDeInicio)
    Date fechaDeTermino = Date.parse("dd/MMMM/yyyy", params.fechaDeTermino)
    def instructor = Instructor.get(params.instructor)
    def puerto = Puerto.get(params.puerto)
    def cursosProgramados = CursoProgramado.findAllByInstructorAndPuertoAndDateCreatedBetween(instructor, puerto, fechaDeInicio, fechaDeTermino)

    render template:'estadoDeCuenta', model : [cursosProgramados : cursosProgramados]
  }
}
