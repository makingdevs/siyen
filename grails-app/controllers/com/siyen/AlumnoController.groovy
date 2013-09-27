package com.siyen

import grails.converters.*

class AlumnoController {

  static allowedMethods = [save : "POST"]


  def save(AlumnoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    Alumno alumno = new Alumno( nombreCompleto : cmd.nombreCompleto, observaciones : cmd.observaciones )
    alumno.cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
    alumno.save(failOnError:true)
    alumno.numeroDeControl = generarNumeroDeControl(alumno.id)
    alumno.save(failOnError:true)

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

class AlumnoCommand {
  Long cursoProgramado
  String nombreCompleto
  String observaciones

  static constraints = {
    cursoProgramado nullable: false
    nombreCompleto nullable: false
  }
}