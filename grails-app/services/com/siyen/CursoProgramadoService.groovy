package com.siyen

import grails.converters.*
import org.vertx.java.core.json.*

class CursoProgramadoService {

  def defaultPlatformManager
  def springSecurityService

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

    enviarNotificacionDeCursoCreado(cursoProgramado)

    cursoProgramado
  }

  private def enviarNotificacionDeCursoCreado(CursoProgramado cursoProgramado) {
    def vertx = defaultPlatformManager.vertx()
    def eventBus = vertx.eventBus()

    JsonObject jsonNotification = convertirCursoProgramadoAJsonObject(cursoProgramado)

    eventBus.publish('cursoProgramado.save', jsonNotification)
  }

  private JsonObject convertirCursoProgramadoAJsonObject(CursoProgramado cursoProgramado) {
    JsonObject jsonNotification = new JsonObject()
    jsonNotification.putValue( "id", cursoProgramado.id )
    jsonNotification.putValue( "fechaDeInicio", cursoProgramado.fechaDeInicio )
    jsonNotification.putString( "puerto", "${cursoProgramado.puerto.clave} - ${cursoProgramado.puerto.puerto}" )
    jsonNotification.putValue( "curso", cursoProgramado.curso.clave )
    jsonNotification.putValue( "instructor", cursoProgramado.instructor.nombre )
    jsonNotification.putValue( "alumnos", cursoProgramado.alumnos.size() )
    jsonNotification.putValue( "creadoPor", springSecurityService.currentUser.username )

    jsonNotification
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
