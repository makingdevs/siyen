package com.siyen

class EstadoDeCuentaController {

  def index() {
    [ puertos : Puerto.findAll { it.activo }, instructor : Instructor.findAll { it.activo } ]
  }

  def generarEstadoDeCuenta(BusquedaEstadoCuentaCommand cmd) {
    if(cmd.hasErrors()){
      render(text: "<div class='alert alert-error'><strong>Son requeridos todos los criterios de busqueda</strong></div>", contentType: "text/html", encoding: "UTF-8")
      return
    }
    Date fechaDeInicio = Date.parse("dd/MMMMM/yyyy", cmd.fechaDeInicio)
    Date fechaDeTermino = Date.parse("dd/MMMM/yyyy", cmd.fechaDeTermino)
    def instructor = Instructor.get(cmd.instructor)
    def puerto = Puerto.get(cmd.puerto)
    def c = CursoProgramado.createCriteria()
    def cursosProgramados = c.listDistinct{
      between("fechaDeInicio", fechaDeInicio, fechaDeTermino)
      eq 'instructor.id',instructor.id
      eq 'puerto.id',puerto.id
    }

    render template:'estadoDeCuenta', model : [ cursosProgramados : cursosProgramados, fechaDeInicio : fechaDeInicio, fechaDeTermino : fechaDeTermino, puerto : puerto, instructor : instructor ]
  }
}

class BusquedaEstadoCuentaCommand {
  String fechaDeInicio
  String fechaDeTermino
  Long instructor
  Long puerto

  static constraints = {
    fechaDeInicio nullable: false
    fechaDeTermino nullable: false
    instructor nullable: false
    puerto nullable: false
  }
}