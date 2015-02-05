package com.siyen

class EstadoDeCuentaController {

  def index() {
    [ puertos : Puerto.findAll { it.activo }, instructor : Instructor.findAll { it.activo } ]
  }

  def generarEstadoDeCuenta() {
    Date fechaDeInicio = Date.parse("dd/MMMMM/yyyy", params.fechaDeInicio)
    Date fechaDeTermino = Date.parse("dd/MMMM/yyyy", params.fechaDeTermino)
    def instructor = Instructor.get(params.instructor)
    def puerto = Puerto.get(params.puerto)
    def c = CursoProgramado.createCriteria()
    def cursosProgramados = c.listDistinct{
      between("fechaDeInicio", fechaDeInicio, fechaDeTermino)
      eq 'instructor.id',instructor.id
      eq 'puerto.id',puerto.id
    }
    log.debug"datos de CursoProgramado **** ${cursosProgramados}"
    render template:'estadoDeCuenta', model : [ cursosProgramados : cursosProgramados, fechaDeInicio : fechaDeInicio, fechaDeTermino : fechaDeTermino, puerto : puerto, instructor : instructor ]
  }
}
