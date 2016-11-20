package com.siyen

import grails.converters.*
import org.vertx.java.core.json.*
import com.siyen.exceptions.BusinessException

class CursoProgramadoService {

  def springSecurityService
  def notificacionService
  def searchableService
  def alumnoService

  static final int FIVE_YEARS_IN_DAYS = 365 * 5

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = validaTraslapeDeCursos(cmd)
    cursoProgramado.fechaDeTermino = cursoProgramado.fechaDeInicio.clone().plus( (cursoProgramado.curso.duracion - 1) )
    cursoProgramado.expirationDate = cursoProgramado.fechaDeInicio.clone().plus(FIVE_YEARS_IN_DAYS)
    cursoProgramado.user = springSecurityService.currentUser
    cursoProgramado.alumnosRestantes = cmd.alumnos.size() + 5
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

  def buscarCursosProgramados(params){

    String busqueda = params.buscar?.replace(',', " ")?.trim()
    String cursos = params.cursos?.replace(',', " ")?.trim()
    String puertos = params.puertos?.replace(',', " ")?.trim()
    String instructores = params.instructores?.replace(',', " ")?.trim()

    def busquedaDeResultados = searchableService.search({
      mustNot(term("alias", "Alumno"))
      if(busqueda) {
        must(queryString(busqueda))
      }

      if(cursos) {
        must(queryString(cursos){
          useAndDefaultOperator()
          setDefaultSearchProperty("clave")
        })
      }

      if(puertos) {
        must(queryString(puertos){
          useAndDefaultOperator()
          setDefaultSearchProperty("clave")
        })
      }

      if(instructores) {
        must(queryString(instructores){
          useAndDefaultOperator()
          setDefaultSearchProperty("nombre")
        })
      }

      if(params.desde) {
        Date desde = Date.parse("dd/MM/yyyy", params.desde)
        Date hasta = params.hasta ? Date.parse("dd/MM/yyyy", params.hasta) : new Date()
        must( between("fechaDeInicio", desde, hasta, true) )
      }

    }, params)

    busquedaDeResultados
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
