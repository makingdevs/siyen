package com.siyen

import java.text.SimpleDateFormat
import grails.converters.*

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST"]

  def cursoProgramadoService

  def show() {

    def jsonResponse = [:]
    jsonResponse.cursos_programados = CursoProgramado.list()
    jsonResponse.puertos = Puerto.list()
    jsonResponse.cursos = Curso.list()
    jsonResponse.instructores = Instructor.list()

    JSON.use('siyen') {
      render jsonResponse as JSON
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