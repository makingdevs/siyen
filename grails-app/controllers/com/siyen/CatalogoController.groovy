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
    def cursos = Curso.list()
    def instructores = Instructor.list()
    def puertos = Puerto.list()
    def alumnos = Alumno.list()

    render(contentType:"text/json") {
      [ nombresDeCursos       : cursos*.nombre,
        clavesDeCursos        : cursos*.clave,
        nombresDeInstructores : instructores*.nombre,
        clavesDePuertos       : puertos*.clave,
        nombresDeAlumnos      : alumnos*.nombreCompleto,
        numerosDeControl      : alumnos*.numeroDeControl
      ]
    }
  }

}
