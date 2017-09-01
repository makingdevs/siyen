package com.siyen

import io.vertx.core.json.JsonObject
import io.vertx.core.Vertx

class NotificacionService {

  def springSecurityService
  def vertx

  def enviarNotificacion(String bus, CursoProgramado cursoProgramado) {
    def eventBus = vertx.eventBus()

    JsonObject mensaje = convertirCursoProgramadoAJsonObject(cursoProgramado, bus)

    eventBus.publish(bus, mensaje)
  }

  def enviarNotificacionDeAlumno(String bus, Alumno alumno) {
    def eventBus = vertx.eventBus()

    JsonObject mensaje = convertirCursoProgramadoAJsonObject(alumno.cursoProgramado, bus)
    mensaje.put("accion", "${mensaje.getValue("accion")} ${alumno.numeroDeControl}")

    eventBus.publish(bus, mensaje)
  }

  private JsonObject convertirCursoProgramadoAJsonObject(CursoProgramado cursoProgramado, String bus) {
    JsonObject jsonNotification = new JsonObject()
    jsonNotification.put( "id", cursoProgramado.id )
    jsonNotification.put( "fechaDeAutorizacion", cursoProgramado.dateCreated.format("dd/MMMM/yyyy HH:mm") )
    jsonNotification.put( "fechaDeInicio", cursoProgramado.fechaDeInicio.format("dd/MMMM/yyyy") )
    jsonNotification.put( "puerto", "${cursoProgramado.puerto.clave} - ${cursoProgramado.puerto.puerto}" )
    jsonNotification.put( "curso", cursoProgramado.curso.clave )
    jsonNotification.put( "instructor", cursoProgramado.instructor.nombre )
    jsonNotification.put( "alumnos", cursoProgramado.alumnos.size() )
    jsonNotification.put( "creadoPor", springSecurityService.currentUser.username )

    Accion accion = obtenerAccionRealizada(bus)
    jsonNotification.put( "accion", accion.getValue() )

    jsonNotification
  }

  private Accion obtenerAccionRealizada(String bus) {
    def matcher = bus =~/\.\w+/
    String resultado = (matcher[0] - ".").toUpperCase()

    Accion.valueOf(resultado)
  }

  enum Accion {
    AUTORIZADO("Curso autorizado"),
    IMPRESION("Impresión de certificados"),
    ACTUALIZADO("Curso actualizado"),
    ALUMNO_ADD("Alumno agregado"),
    ALUMNO_EDIT("Alumno editado"),
    IMPRESION_DE("Impresion de")

    private final String value

    Accion(String value) {
      this.value = value
    }

    String getValue() {
      value
    }
  }

}
