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
      [cursos_programados: listados, puertos:Puerto.list(), cursos: Curso.list(), instructores: Instructor.list()]
    }
  }

  def save(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    CursoProgramado cursoProgramado = new CursoProgramado()
    Date fechaDeInicio = Date.parse("dd/MMM/yyyy", cmd.fechaDeInicio)
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cmd.puerto)
    cursoProgramado.curso = Curso.get(cmd.curso)
    cursoProgramado.instructor = Instructor.get(cmd.instructor)
    cursoProgramado.fechaDeTermino = fechaDeInicio.clone().plus( cursoProgramado.curso.duracion )

    cmd.alumnos.each {
      String prefijo = "II"
      Integer numerosEnMatricula = 6

      Integer id = (Alumno.createCriteria().get {
        projections {
            max "id"
        }
      } ?: 0) + 1
      String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)

      Alumno alumno = new Alumno( numeroDeControl:numeroDeControl, nombreCompleto : it.nombre_completo, observaciones : it.observaciones )
      cursoProgramado.addToAlumnos(alumno)
    }

    cursoProgramado.save(failOnError:true)

    def listado = [:]
    listado.id = cursoProgramado.id
    listado.fechaDeInicio = cursoProgramado.fechaDeInicio
    listado.fechaDeTermino = cursoProgramado.fechaDeTermino
    listado.dateCreated = cursoProgramado.dateCreated
    listado.puerto = cursoProgramado.puerto.id
    listado.curso = cursoProgramado.curso.id
    listado.instructor = cursoProgramado.instructor.id
    listado.statusCurso = cursoProgramado.statusCurso.key
    listado.alumnos = cursoProgramado.alumnos

    render(contentType:"text/json") {
      [curso_programado: listado, puertos:Puerto.list(), cursos: Curso.list(), instructores: Instructor.list()]
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