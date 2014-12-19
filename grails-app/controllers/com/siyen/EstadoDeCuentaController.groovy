package com.siyen

class EstadoDeCuentaController {

  def index() {
    [ puertos : Puerto.findAll { it.activo }, usuario : User.findAll { it.enabled } ]
  }

  def generarEstadoDeCuenta() {
    Date fechaDeInicio = Date.parse("dd/MMMMM/yyyy", params.fechaDeInicio)
    Date fechaDeTermino = Date.parse("dd/MMMM/yyyy", params.fechaDeTermino)
    def user = User.get(params.usuario)
    def puerto = Puerto.get(params.puerto)
    def c = CursoProgramado.createCriteria()
    def cursosProgramados = c.listDistinct{
      alumnos{
        between('dateCreated',fechaDeInicio,fechaDeTermino)
      }
      eq 'user.id',user.id
      eq 'puerto.id',puerto.id
    }
    render template:'estadoDeCuenta', model : [ cursosProgramados : cursosProgramados, fechaDeInicio : fechaDeInicio, fechaDeTermino : fechaDeTermino, puerto : puerto, user : user ]
  }
}
