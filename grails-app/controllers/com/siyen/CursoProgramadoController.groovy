package com.siyen

import java.text.SimpleDateFormat
import grails.converters.*

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST", update : "PUT"]

  def cursoProgramadoService

  def show() {
    def cursosProgramados = CursoProgramado.list()
    renderResponseWithCursosProgramados(cursosProgramados)
  }

  def save(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    CursoProgramado cursoProgramado = cursoProgramadoService.crearCursoDesdeCommand(cmd)
    renderResponseWithCursosProgramados(cursoProgramado)
  }

  def update(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    CursoProgramado cursoProgramado = CursoProgramado.get(params.id)
    cursoProgramado.curso = Curso.get(params.curso)
    cursoProgramado.save(failOnError:true)
    renderResponseWithCursosProgramados(cursoProgramado)
  }

  private renderResponseWithCursosProgramados(def cursosProgramados) {
    def jsonResponse = [:]
    jsonResponse.cursos_programados = cursosProgramados
    jsonResponse.puertos = Puerto.list()
    jsonResponse.cursos = Curso.list()
    jsonResponse.instructores = Instructor.list()
    jsonResponse.alumnos = Alumno.list()

    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

}

class CursoProgramadoCommand {
  String fechaDeInicio
  Long puerto
  Long curso
  Long instructor
  List alumnos

  static constraints = {
    fechaDeInicio nullable: false
    puerto nullable: false
    curso nullable: false
    instructor nullable: false
    alumnos validator: {
      !it.isEmpty()
    }
  }
}