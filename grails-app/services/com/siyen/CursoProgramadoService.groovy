package com.siyen

import grails.converters.*
import org.vertx.java.core.json.*

class CursoProgramadoService {

  def springSecurityService
  def notificacionService

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = new CursoProgramado()
    Date fechaDeInicio = Date.parse("dd/MMM/yyyy", cmd.fechaDeInicio)
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cmd.puerto)
    cursoProgramado.curso = Curso.get(cmd.curso)
    cursoProgramado.instructor = Instructor.get(cmd.instructor)
    cursoProgramado.fechaDeTermino = fechaDeInicio.clone().plus( cursoProgramado.curso.duracion )
    cursoProgramado.user = springSecurityService.currentUser

    cmd.alumnos.each { alumnoData ->
      Alumno alumno = generarAlumnoConParams(alumnoData)
      cursoProgramado.addToAlumnos(alumno)
    }

    cursoProgramado.save(failOnError:true)

    cursoProgramado.alumnos.each { alumno ->
      alumno.numeroDeControl = generarNumeroDeControl(alumno.id)
      alumno.save(failOnError:true)
    }

    notificacionService.enviarNotificacion('cursoProgramado.autorizado', cursoProgramado)

    cursoProgramado
  }

  private Alumno generarAlumnoConParams( def alumnoData ) {
    Alumno alumno = new Alumno( nombreCompleto : alumnoData.nombreCompleto, observaciones : alumnoData.observaciones )
    alumno
  }

  private String generarNumeroDeControl(def id) {
    String prefijo = "II"
    Integer numerosEnMatricula = 6
    String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)
    numeroDeControl
  }

}
