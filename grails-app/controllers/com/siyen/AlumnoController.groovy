package com.siyen

import grails.converters.*
import com.siyen.exceptions.BusinessException

class AlumnoController {

  static allowedMethods = [save : "POST", update : "PUT"]

  def notificacionService
  def springSecurityService

  def save(AlumnoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    Alumno alumno = new Alumno(
      nombreCompleto : cmd.nombreCompleto,
      observaciones : cmd.observaciones,
      tipoDePago : cmd.tipoDePago,
      monto : cmd.monto
    )

    CursoProgramado cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
    cursoProgramado.alumnosRestantes -= 1
    if(cursoProgramado.alumnosRestantes >= 0 && (cursoProgramado.fechaDeInicio > (new Date() - 15))) {
      cursoProgramado.save()
    } else {
      render(status:403, contentType: "text/json") {
        [ message : "No es posible agregar más alumnos a este curso" ]
      }
      return
    }

    alumno.cursoProgramado = cursoProgramado
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

    try {
      Alumno alumno = validarDatosDeMovimiento(cmd.id, cmd.cursoProgramado)
      def cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
      def authority = springSecurityService.currentUser.authorities.any { it.authority == 'ROLE_ADMIN' }
      if(!authority) {
        if(!(cursoProgramado.fechaDeInicio > (new Date() - 15))) {
          render (status : 403, contentType:"text/json") {
            [ message : "Contacte al administrador para verificar este cambio" ]
          }
          return
        }
      }
      alumno.cursoProgramado = CursoProgramado.get(cmd.cursoProgramado)
      alumno.nombreCompleto = cmd.nombreCompleto
      alumno.observaciones = cmd.observaciones
      alumno.tipoDePago = cmd.tipoDePago
      alumno.monto = cmd.monto
      alumno.save(failOnError:true)

      notificacionService.enviarNotificacion('cursoProgramado.alumno_edit', alumno.cursoProgramado)
      respuestaJson(alumno)
    }catch(ex) {
      render(status:409, contentType: "text/json") {
        [ message : ex.message ]
      }
      return
    }
  }

  def show() {
    respuestaJson(Alumno.get(params.id))
  }

  private def validarDatosDeMovimiento(alumnoId, cursoProgramadoId) {
    Alumno alumno = Alumno.get(alumnoId)

    CursoProgramado cursoOrigen = alumno.cursoProgramado
    CursoProgramado cursoDestino = CursoProgramado.get(cursoProgramadoId)

    if( cursoOrigen.instructor.id != cursoDestino.instructor.id ||
        cursoOrigen.puerto.id != cursoDestino.puerto.id ||
        cursoOrigen.fechaDeInicio.format('dd/MM/yyyy') != cursoDestino.fechaDeInicio.format('dd/MM/yyyy')) {
      throw new BusinessException("Los movimientos deben ser entre el mismo puerto, instructor y fecha de inicio", cursoOrigen)
    }

    alumno
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
    Integer numerosEnMatricula = 7
    String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)
    numeroDeControl
  }
}

class AlumnoUpdateCommad {
  Long id
  Long cursoProgramado
  String nombreCompleto
  String observaciones
  String tipoDePago
  Long monto

  static constraints = {
    id nullable: false
    cursoProgramado nullable: false
    nombreCompleto nullable: false
    tipoDePago nullable: false
  }

}

class AlumnoCommand {
  Long cursoProgramado
  String nombreCompleto
  String observaciones
  String tipoDePago
  Long monto

  static constraints = {
    cursoProgramado nullable: false
    nombreCompleto nullable: false
    tipoDePago nullable: false
  }
}
