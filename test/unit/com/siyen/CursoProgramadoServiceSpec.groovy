package com.siyen

import grails.test.mixin.*
import org.junit.*
import spock.lang.Specification

import com.siyen.exceptions.BusinessException
import grails.plugins.springsecurity.SpringSecurityService

@TestFor(CursoProgramadoService)
@Mock([CursoProgramado, Alumno, NotificacionService, AlumnoService, Puerto, Curso, Instructor, User])
class CursoProgramadoServiceSpec extends Specification {

  def "Validando generación de cursos"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date().format('dd/MM/yyyy')

      def cmd = new CursoProgramadoCommand(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1,
        alumnos : [
          [ nombreCompleto : "uno", observaciones : "nada", monto : 100, tipoDePago : TipoDePago.EFECTIVO ]
        ]
      )

    and :
      def springSecurityServiceMock = mockFor(SpringSecurityService)
      springSecurityServiceMock.demand.getCurrentUser { ->
        new User().save(validate:false)
      }
      service.springSecurityService = springSecurityServiceMock.createMock()

      def alumnoServiceMock = mockFor(AlumnoService)
      alumnoServiceMock.demand.saveAlumno {alumnoData ->

      }
      service.alumnoService = alumnoServiceMock.createMock()

    when :
      def cursoProgramado = service.crearCursoDesdeCommand( cmd )

    then:
      cursoProgramado.id > 0
  }

  def "Validando generación de cursos con alumno a actualizar"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date().format('dd/MM/yyyy')

      def cmd = new CursoProgramadoCommand(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1,
        alumnos : [
          [ nombreCompleto : "uno", observaciones : "nada", monto : 100, tipoDePago : TipoDePago.EFECTIVO, numeroDeControl : "II236789"]
        ]
      )

    and :
      def springSecurityServiceMock = mockFor(SpringSecurityService)
      springSecurityServiceMock.demand.getCurrentUser { ->
        new User().save(validate:false)
      }
      service.springSecurityService = springSecurityServiceMock.createMock()

      def alumnoServiceMock = mockFor(AlumnoService)
      alumnoServiceMock.demand.updateAlumno {alumnoData ->

      }
      service.alumnoService = alumnoServiceMock.createMock()

    when :
      def cursoProgramado = service.crearCursoDesdeCommand( cmd )

    then:
      cursoProgramado.id > 0
  }

  def "Validando generacion de curso con fecha diferente en el mismo puerto para el mismo instructor y con el mismo curso"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date()

      def cmd = new CursoProgramadoCommand(
        fechaDeInicio : fechaDeInicio.format('dd/MM/yyyy'),
        puerto : 1,
        curso : 1,
        instructor : 1,
        alumnos: []
        )
    and : "guardando curso programado"
      new CursoProgramado(
        fechaDeInicio : fechaDeInicio.clearTime() - 5,
        fechaDeTermino : fechaDeInicio.clearTime() - 3,
        puerto : puerto,
        curso : curso,
        instructor : instructor
      ).save(validate:false)

    and :
      def springSecurityServiceMock = mockFor(SpringSecurityService)
      springSecurityServiceMock.demand.getCurrentUser { ->
        new User().save(validate:false)
      }
      service.springSecurityService = springSecurityServiceMock.createMock()

      def notificacionServiceMock = mockFor(NotificacionService)
      notificacionServiceMock.demand.enviarNotificacion { bus, data ->
      }
      service.notificacionService = notificacionServiceMock.createMock()

    when :
      def cursoProgramado = service.crearCursoDesdeCommand( cmd )

    then:
      cursoProgramado.id > 0
  }

  def "Validando cursos traslapados"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:duracion).save(validate:false)
      def instructor = new Instructor().save(validate:false)

      def cmd = new CursoProgramadoCommand(
        fechaDeInicio : fechaDeInicioCmd.format('dd/MM/yyyy'),
        puerto : 1,
        curso : 1,
        instructor : 1
        )
    and : "guardando curso programado"
      def c = new CursoProgramado(
        fechaDeInicio : fechaDeInicioCurso.clearTime(),
        fechaDeTermino : fechaDeInicioCurso.clearTime().clone().plus(duracion),
        puerto : puerto,
        curso : curso,
        instructor : instructor
      ).save(validate:false)

    and :
      def springSecurityServiceMock = mockFor(SpringSecurityService)
      springSecurityServiceMock.demand.getUser { ->
        new User()
      }
      service.springSecurityService = springSecurityServiceMock.createMock()

    when :
      def cursoProgramado = service.crearCursoDesdeCommand( cmd )

    then:
      BusinessException be = thrown()
      be.data
      be.data.fechaDeInicio.format("dd/MM/yyyy")
      be.message == "Información duplicada"

    where :
      fechaDeInicioCmd  | fechaDeInicioCurso | duracion
        new Date()      | new Date()         | 1
        new Date() + 1  | new Date()         | 2
        new Date() + 2  | new Date()         | 2
  }

  def "Validando generación de fecha de expiracion"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      String fechaDeInicioString = "19/11/2016 00:00:00"
      def fechaDeInicio = new Date().parse("dd/MM/yyyy HH:mm:ss", fechaDeInicioString).format('dd/MM/yyyy')
      def expirationDate = new Date().parse("dd/MM/yyyy HH:mm:ss", "18/11/2021 00:00:00")

      def cmd = new CursoProgramadoCommand(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1,
        alumnos : [
          [ nombreCompleto : "uno", observaciones : "nada", monto : 100, tipoDePago : TipoDePago.EFECTIVO ]
        ]
      )

    and :
      def springSecurityServiceMock = mockFor(SpringSecurityService)
      springSecurityServiceMock.demand.getCurrentUser { ->
        new User().save(validate:false)
      }
      service.springSecurityService = springSecurityServiceMock.createMock()

      def alumnoServiceMock = mockFor(AlumnoService)
      alumnoServiceMock.demand.saveAlumno {alumnoData ->

      }
      service.alumnoService = alumnoServiceMock.createMock()

    when :
      def cursoProgramado = service.crearCursoDesdeCommand( cmd )

    then:
      cursoProgramado.id > 0
      cursoProgramado.expirationDate.format('dd/MM/yyyy') == expirationDate.format('dd/MM/yyyy')
  }

}
