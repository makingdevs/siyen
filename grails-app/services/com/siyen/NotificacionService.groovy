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

    def accion = bus =~/\.\w+/
    jsonNotification.putString( "accion", (accion[0] - ".").capitalize() )

    jsonNotification
  }

}