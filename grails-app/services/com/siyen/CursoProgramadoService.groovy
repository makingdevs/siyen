package com.siyen

import grails.converters.*
import org.vertx.java.core.json.*
import com.siyen.exceptions.BusinessException

class CursoProgramadoService {

  def springSecurityService
  def notificacionService
  def searchableService

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = validaTraslapeDeCursos(cmd)
    cursoProgramado.fechaDeTermino = cursoProgramado.fechaDeInicio.clone().plus( (cursoProgramado.curso.duracion - 1) )
    cursoProgramado.user = springSecurityService.currentUser

    cmd.alumnos.each { alumnoData ->
      if(alumnoData.numeroDeControl) {
        def alumno = Alumno.findByNumeroDeControl(alumnoData.numeroDeControl)
        def tempCursoProgramado = alumno.cursoProgramado
        tempCursoProgramado.removeFromAlumnos(alumno)
        tempCursoProgramado.save()
        cursoProgramado.addToAlumnos(alumno)
      } else {
        Alumno alumno = generarAlumnoConParams(alumnoData)
        cursoProgramado.addToAlumnos(alumno)
      }
    }

    cursoProgramado.save(failOnError:true)

    cursoProgramado.alumnos.each { alumno ->
      if(!alumno.numeroDeControl) {
        alumno.numeroDeControl = generarNumeroDeControl(alumno.id)
        alumno.save(failOnError:true)
      }
    }

    notificacionService.enviarNotificacion('cursoProgramado.autorizado', cursoProgramado)

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

  private String generarNumeroDeControl(def id) {
    String prefijo = "II"
    Integer numerosEnMatricula = 7
    String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)
    numeroDeControl
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
