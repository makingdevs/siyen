package com.siyen

import grails.converters.*

class AlumnoController {

  static allowedMethods = [save : "POST", update : "PUT"]

  def notificacionService

  def save(AlumnoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    Alumno alumno = new Alumno(
      nombreCompleto : cmd.nombreCompleto,
      observaciones : cmd.observaciones,
      monto : cmd.monto
    )
    alumno.cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
    alumno.save(failOnError:true)

    alumno.numeroDeControl = generarNumeroDeControl(alumno.id)
    alumno.save(failOnError:true)

    notificacionService.enviarNotificacion('cursoProgramado.alumno_add', alumno.cursoProgramado)
    respuestaJson(alumno)
  }

  def update(AlumnoUpdateCommad cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    Alumno alumno = Alumno.get(cmd.id)
    alumno.cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
    alumno.nombreCompleto = cmd.nombreCompleto
    alumno.observaciones = cmd.observaciones
    alumno.monto = cmd.monto
    alumno.save(failOnError:true)

    notificacionService.enviarNotificacion('cursoProgramado.alumno_edit', alumno.cursoProgramado)

    respuestaJson(alumno)
  }

  private void respuestaJson(Alumno alumno) {
    def jsonResponse = [:]
    jsonResponse.alumno = alumno
    JSON.use('siyen') {
      render jsonResponse as JSON
    }
  }

  private String generarNumeroDeControl(def id) {
    String prefijo = "II"
    Integer numerosEnMatricula = 6
    String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)
    numeroDeControl
  }
}

class AlumnoUpdateCommad {
  Long id
  Long cursoProgramado
  String nombreCompleto
  String observaciones
  Long monto

  static constraints = {
    id nullable: false
    cursoProgramado nullable: false
    nombreCompleto nullable: false
  }

}

class AlumnoCommand {
  Long cursoProgramado
  String nombreCompleto
  String observaciones
  Long monto

  static constraints = {
    cursoProgramado nullable: false
    nombreCompleto nullable: false
  }
}
