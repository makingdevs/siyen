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

    if(cmd.hasErrors()) {
      render (status : 400)
    }

    CursoProgramado cursoProgramado = new CursoProgramado()
    Date fechaDeInicio = Date.parse("dd/MMM/yyyy", cmd.fechaDeInicio)
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cmd.puerto)
    cursoProgramado.curso = Curso.get(cmd.curso)
    cursoProgramado.instructor = Instructor.get(cmd.instructor)
    cursoProgramado.fechaDeTermino = fechaDeInicio.clone().plus( cursoProgramado.curso.duracion )

    cmd.alumnos.each {
      Alumno alumno = new Alumno( nombreCompleto : it.nombre_completo, observaciones : it.observaciones )
      cursoProgramado.addToAlumnos(alumno)
    }

    cursoProgramado.save()

    render(status:200)
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