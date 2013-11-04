package com.siyen

class CatalogoController {

  def catalogoService

  def obtenerDatosDeCatalogos() {
    def instructoresDisponibles = catalogoService.obtenerInstructores()
    def cursosDisponibles = catalogoService.obtenerCursos()
    def puertosDisponibles = catalogoService.obtenerPuertos()

    render(contentType:"text/json") {
      [instructoresDisponibles : instructoresDisponibles,
             cursosDisponibles : cursosDisponibles,
            puertosDisponibles : puertosDisponibles]
    }
  }

  def obtenerDatosDeBusqueda() {
    def cursos = Curso.findAll { id > 0 }
    def instructores = Instructor.findAll { id > 0 }
    def puertos = Puerto.findAll { id > 0 }

    def datosDelInstructor = []
    instructores.each { instructor ->
      datosDelInstructor << ["id" : instructor.id, "nombre" : instructor.nombre]
    }

    render(contentType:"text/json") {
      [ cursos : cursos*.clave,
        puertos : puertos*.clave,
        instructores : datosDelInstructor ]
    }
  }

}
