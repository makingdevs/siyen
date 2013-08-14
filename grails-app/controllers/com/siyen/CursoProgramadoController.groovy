package com.siyen

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
    log.debug "salvando"
    log.debug "params : ${params['curso_programado']}"
  }

}
