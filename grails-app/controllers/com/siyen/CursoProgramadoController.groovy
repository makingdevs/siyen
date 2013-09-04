package com.siyen

import java.text.SimpleDateFormat
import grails.converters.*

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST"]

  def cursoProgramadoService

  def show() {
    def cursosProgramados = CursoProgramado.list()
    def listados = []

    cursosProgramados.each { cursoProgramado ->
      listados << [
        id : cursoProgramado.id,
        fechaDeInicio : cursoProgramado.fechaDeInicio,
        fechaDeTermino : cursoProgramado.fechaDeTermino,
        dateCreated : cursoProgramado.dateCreated,
        puerto : cursoProgramado.puerto.id,
        curso : cursoProgramado.curso.id,
        instructor : cursoProgramado.instructor.id,
        statusCurso : cursoProgramado.statusCurso.key,
        alumnos : cursoProgramado.alumnos ?: [] ]
    }


    render(contentType:"text/json") {
      [cursos_programados: listados, puertos:Puerto.list(), cursos: Curso.list(), instructores: Instructor.list()]
    }
  }

  def save(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    CursoProgramado cursoProgramado = cursoProgramadoService.crearCursoDesdeCommand(cmd)

    def jsonResponse = [:]
    jsonResponse.curso_programado = cursoProgramado

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
    alumnos nullable: false
  }
}