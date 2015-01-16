package com.siyen

import java.text.SimpleDateFormat
import grails.converters.*

import com.siyen.exceptions.BusinessException

class CursoProgramadoController {

  static allowedMethods = [show : "GET", save : "POST", update : "PUT"]

  def springSecurityService
  def cursoProgramadoService
  def notificacionService

  def searchToEdit(){
    render view:"search"
  }

  def show() {
    if(params.id) {
      def cursoProgramado = CursoProgramado.get( params.id )
      def jsonResponse = [:]
      jsonResponse.cursos_programados = cursoProgramado
      jsonResponse.puertos = springSecurityService.currentUser.puertos.findAll { it.activo }
      jsonResponse.cursos = Curso.findAll { activo == true }
      jsonResponse.instructores = springSecurityService.currentUser.instructores.findAll { it.activo }
      jsonResponse.alumnos = cursoProgramado.alumnos

      JSON.use('siyen') {
        render jsonResponse as JSON
      }
      return
    }

    def cursosProgramados = CursoProgramado.findAll {
      gt "fechaDeInicio", (new Date() - 15)
      eq "user", springSecurityService.currentUser
    }

    renderResponseWithCursosProgramados(cursosProgramados)
  }

  def save(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    try {
      CursoProgramado cursoProgramado = cursoProgramadoService.crearCursoDesdeCommand(cmd)
      notificacionService.enviarNotificacion('cursoProgramado.autorizado', cursoProgramado)
      renderResponseWithCursosProgramados(cursoProgramado)
    }catch(BusinessException ex) {
      render(status:409, contentType: "text/json") {
        [
          message : ex.message,
          fechaDeInicio : ex.data.fechaDeInicio,
          fechaDeTermino : ex.data.fechaDeTermino,
          instructor : ex.data.instructor.nombre,
          curso : ex.data.curso.clave,
          puerto : ex.data.puerto.clave
        ]
      }
    }
  }

  def update(CursoProgramadoCommand cmd) {
    if(cmd.hasErrors()) {
      render (status : 400, contentType:"text/json") {
        [ errors : cmd.errors ]
      }
    }

    CursoProgramado cursoProgramado = cursoProgramadoService.actualizarCursoProgramado(params)
    renderResponseWithCursosProgramados(cursoProgramado)
  }

  private renderResponseWithCursosProgramados(def cursosProgramados) {
    def jsonResponse = [:]
    jsonResponse.cursos_programados = cursosProgramados
    jsonResponse.puertos = springSecurityService.currentUser.puertos.findAll { it.activo }
    jsonResponse.cursos = Curso.findAll { activo == true }
    jsonResponse.instructores = springSecurityService.currentUser.instructores.findAll { it.activo }
    jsonResponse.alumnos = cursosProgramados*.alumnos.flatten()

    JSON.use('siyen') {
      render jsonResponse as JSON
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
    alumnos validator: {
      !it.isEmpty()
    }
  }
}
