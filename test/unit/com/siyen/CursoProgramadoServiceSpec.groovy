package com.siyen

import grails.test.mixin.*
import org.junit.*
import spock.lang.Specification

import com.siyen.exceptions.BusinessException
import grails.plugins.springsecurity.SpringSecurityService

@TestFor(CursoProgramadoService)
@Mock([CursoProgramado, Alumno, NotificacionService, Puerto, Curso, Instructor, User])
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
          [ nombreCompleto : "uno", tipoDePago : "EFECTIVO" ]
        ]
      )

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
        instructor : 1
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

}
