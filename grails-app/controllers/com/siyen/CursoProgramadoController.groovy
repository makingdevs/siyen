package com.siyen

import java.text.SimpleDateFormat

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST"]

  def show() {
    def cursosProgramados = CursoProgramado.list()
    def listados = []

    cursosProgramados.each { cursoProgramado ->
      listados << [ fechaDeInicio : cursoProgramado.fechaDeInicio,
        fechaDeTermino : cursoProgramado.fechaDeTermino,
        dateCreated : cursoProgramado.dateCreated,
        puerto : cursoProgramado.puerto.id,
        curso : cursoProgramado.curso.id,
        instructor : cursoProgramado.instructor.id,
        statusCurso : cursoProgramado.statusCurso.key ]
    }


    render(contentType:"text/json") {
      [curso_programados: listados, puertos:Puerto.list(), cursos: Curso.list(), instructors: Instructor.list() ]
    }
  }

  def save() {
    CursoProgramadoCommand cursoProgramadoCommand = new CursoProgramadoCommand( params['curso_programado'] )

    log.debug cursoProgramadoCommand.fechaDeInicio.getClass()
    log.debug cursoProgramadoCommand.puerto.getClass()

  }

}

class CursoProgramadoCommand {

  String fechaDeInicio // Vie. Ago. 30 2013 00:00:00 GMT-0500
  String fechaDeTermino // Mar. Sep. 03 2013 00:00:00 GMT-0500

  String puerto // 1L
  String curso // 1L
  String instructor // 1L

  String statusCurso // NUEVO

  static constraints = {
    fechaDeInicio nullable : false
    puerto nullable : false
    curso nullable : false
    instructor nullable : false
    statusCurso nullable : false
  }

  Date getFechaDeInicio() {
    Date.parse("E. MMM. dd yyyy", fechaDeInicio)
  }

  Date getFechaDeTermino() {
    new Date(fechaDeTermino)
  }

  Long getPuerto() {
    puerto.toLong()
  }

  Long getCurso() {
    curso.toLong()
  }

  Long getInstructor() {
    instructor.toLong()
  }

}
