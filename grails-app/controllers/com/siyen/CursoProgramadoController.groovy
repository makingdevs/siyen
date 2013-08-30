package com.siyen

import java.text.SimpleDateFormat
import grails.converters.*

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST"]

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
      [curso_programados: listados, puertos:Puerto.list(), cursos: Curso.list(), instructores: Instructor.list(), alumnos : Alumno.list() ]
    }
  }

  def save(CursoProgramadoCommand cmd) {
    log.debug "Salvando cursoProgramado"
    log.debug params as JSON

    log.debug cmd.hasErrors()
    log.debug cmd.errors
    // Map cursoProgramadoParams = params['curso_programado']
    // Date fechaDeInicio = Date.parse("E. MMM. dd yyyy", cursoProgramadoParams.fechaDeInicio)
    // CursoProgramado cursoProgramado = new CursoProgramado()
    // cursoProgramado.fechaDeInicio = fechaDeInicio
    // cursoProgramado.puerto = Puerto.get(cursoProgramadoParams.puerto.toLong())
    // cursoProgramado.curso = Curso.get(cursoProgramadoParams.curso.toLong())
    // cursoProgramado.instructor = Instructor.get(cursoProgramadoParams.instructor.toLong())
    // cursoProgramado.fechaDeTermino = fechaDeInicio.plus( cursoProgramado.curso.duracion )
    // cursoProgramado.save()
    // render(status:200)
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