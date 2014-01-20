package com.siyen

import org.vertx.java.core.json.*

class NotificacionService {

  def springSecurityService
  def defaultPlatformManager

  def enviarNotificacion(String bus, CursoProgramado cursoProgramado) {
    def vertx = defaultPlatformManager.vertx()
    def eventBus = vertx.eventBus()

    JsonObject mensaje = convertirCursoProgramadoAJsonObject(cursoProgramado, bus)

    eventBus.publish(bus, mensaje)
  }

  def enviarNotificacionDeAlumno(String bus, Alumno alumno) {
    def vertx = defaultPlatformManager.vertx()
    def eventBus = vertx.eventBus()

    JsonObject mensaje = convertirCursoProgramadoAJsonObject(alumno.cursoProgramado, bus)
    mensaje.putString("accion", "${mensaje.getValue("accion")} ${alumno.numeroDeControl}")

    eventBus.publish(bus, mensaje)
  }

  private JsonObject convertirCursoProgramadoAJsonObject(CursoProgramado cursoProgramado, String bus) {
    JsonObject jsonNotification = new JsonObject()
    jsonNotification.putValue( "id", cursoProgramado.id )
    jsonNotification.putString( "fechaDeAutorizacion", cursoProgramado.dateCreated.format("dd/MMMM/yyyy HH:mm") )
    jsonNotification.putString( "fechaDeInicio", cursoProgramado.fechaDeInicio.format("dd/MMMM/yyyy") )
    jsonNotification.putString( "puerto", "${cursoProgramado.puerto.clave} - ${cursoProgramado.puerto.puerto}" )
    jsonNotification.putValue( "curso", cursoProgramado.curso.clave )
    jsonNotification.putValue( "instructor", cursoProgramado.instructor.nombre )
    jsonNotification.putValue( "alumnos", cursoProgramado.alumnos.size() )
    jsonNotification.putValue( "creadoPor", springSecurityService.currentUser.username )

    Accion accion = obtenerAccionRealizada(bus)
    jsonNotification.putString( "accion", accion.getValue() )

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
