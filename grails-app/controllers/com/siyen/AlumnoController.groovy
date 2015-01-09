package com.siyen

import grails.converters.*
import com.siyen.exceptions.BusinessException

class AlumnoController {

  static allowedMethods = [save : "POST", update : "PUT"]

  def notificacionService
  def springSecurityService
  def alumnoService

  def save(AlumnoCommand cmd) {
    log.debug "save AlumnoController"
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
      return
    }
    log.debug "inicio save por servicio"
    def alumno = alumnoService.saveAlumno(cmd)
    log.debug "paso save por servicio"

    if(alumno == 403){
      render(status:403, contentType: "text/json") {
        [ message : "No es posible agregar más alumnos a este curso" ]
      }
      return
    }
    log.debug "save hay cupo"
    if(!alumno){
      render(status:500, contentType: "text/json") {
        [ message : "El alumno no se creó. Intenta de nuevo" ]
      }
      return
    }
    log.debug "todo tuvo exito"
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
