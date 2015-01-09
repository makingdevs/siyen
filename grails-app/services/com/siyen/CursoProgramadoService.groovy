package com.siyen

import grails.converters.*
import org.vertx.java.core.json.*
import com.siyen.exceptions.BusinessException

class CursoProgramadoService {

  def springSecurityService
  def notificacionService
  def searchableService
  def alumnoService

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = validaTraslapeDeCursos(cmd)
    cursoProgramado.fechaDeTermino = cursoProgramado.fechaDeInicio.clone().plus( (cursoProgramado.curso.duracion - 1) )
    cursoProgramado.user = springSecurityService.currentUser
    cursoProgramado.save()
    cmd.alumnos.each { alumnoData ->
      alumnoData.cursoProgramado = cursoProgramado.id
      if(alumnoData.numeroDeControl) {
        alumnoService.updateAlumno(alumnoData)
      } else {
        alumnoService.saveAlumno(alumnoData)
      }
    }
    cursoProgramado.save()
    cursoProgramado
  }

  def actualizarCursoProgramado(def params) {
    CursoProgramado cursoProgramado = CursoProgramado.get(params.id)
    cursoProgramado.curso = Curso.get(params.curso)
    cursoProgramado.save(failOnError:true)

    notificacionService.enviarNotificacion('cursoProgramado.actualizado', cursoProgramado)

    cursoProgramado
  }

  private Alumno generarAlumnoConParams( def alumnoData ) {
    Alumno alumno =  new Alumno(
      nombreCompleto : alumnoData.nombreCompleto,
      observaciones : alumnoData.observaciones,
      tipoDePago : alumnoData.tipoDePago,
      monto : alumnoData.monto)
    alumno
  }

  private def validaTraslapeDeCursos(CursoProgramadoCommand cmd) {
    Date fechaDeInicio = Date.parse("dd/MM/yyyy", cmd.fechaDeInicio)
    Puerto puerto = Puerto.get(cmd.puerto)
    Curso curso = Curso.get(cmd.curso)
    Instructor instructor = Instructor.get(cmd.instructor)

    CursoProgramado cursoProgramado = CursoProgramado.createCriteria().get {
      between "fechaDeTermino", fechaDeInicio, fechaDeInicio.clone().plus(curso.duracion)
      eq "puerto", puerto
      eq "curso", curso
      eq "instructor", instructor
    }

    if(cursoProgramado) {
      throw new BusinessException("Información duplicada", cursoProgramado)
    }

    new CursoProgramado( fechaDeInicio : fechaDeInicio, puerto : puerto, curso : curso, instructor : instructor )
  }

}
