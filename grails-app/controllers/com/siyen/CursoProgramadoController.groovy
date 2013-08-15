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
    Map cursoProgramadoParams = params['curso_programado']
    Date fechaDeInicio = Date.parse("E. MMM. dd yyyy", cursoProgramadoParams.fechaDeInicio)

    CursoProgramado cursoProgramado = new CursoProgramado()
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cursoProgramadoParams.puerto.toLong())
    cursoProgramado.curso = Curso.get(cursoProgramadoParams.curso.toLong())
    cursoProgramado.instructor = Instructor.get(cursoProgramadoParams.instructor.toLong())
    cursoProgramado.fechaDeTermino = fechaDeInicio.plus( cursoProgramado.curso.duracion )

    cursoProgramado.save()

    render(status:200)
  }

}
