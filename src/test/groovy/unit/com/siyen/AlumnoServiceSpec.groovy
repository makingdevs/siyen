package com.siyen

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(AlumnoService)
@Mock([CursoProgramado,Puerto,Curso,Instructor,Alumno])
class AlumnoServiceSpec extends Specification {

  def "Guardar alumno en un curso programado"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date().format('dd/MM/yyyy')

      def cursoProgramado = new CursoProgramado(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1
      )
      cursoProgramado.save(validate:false)
    and:
      def alumnoData = [:]
        alumnoData.nombreCompleto = "student name"
        alumnoData.observaciones = "new student"
        alumnoData.tipoDePago = TipoDePago.EFECTIVO
        alumnoData.monto = 100
        alumnoData.cursoProgramado = 1
    when:
      def alumno = service.saveAlumno(alumnoData)
    then:
      alumno.id > 0
      cursoProgramado.alumnos != null
      cursoProgramado.alumnos.size() == 1
  }    
  
  def "Intentar guardar alumno cuando el curso tiene 10 alumnos"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date().format('dd/MM/yyyy')

      def cursoProgramado = new CursoProgramado(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1,
        alumnosRestantes : 0
      )
      cursoProgramado
        .addToAlumnos(new Alumno(numeroDeControl:"II1234501").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234502").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234503").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234504").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234505").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234506").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234507").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234508").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234509").save(validate:false))
        .addToAlumnos(new Alumno(numeroDeControl:"II1234510").save(validate:false))
        .save(validate:false)
    and:
      def alumnoData = [:]
        alumnoData.nombreCompleto = "student name"
        alumnoData.observaciones = "new student"
        alumnoData.tipoDePago = TipoDePago.EFECTIVO
        alumnoData.monto = 100
        alumnoData.cursoProgramado = 1
    when:
      def alumno = service.saveAlumno(alumnoData)
    then:
      alumno == 403
      cursoProgramado.alumnos != null
      cursoProgramado.alumnos.size() == 10
  }

  def "Actualizar alumno en un curso programado"() {
    setup:
      def puerto = new Puerto().save(validate:false)
      def curso = new Curso(id:1, duracion:2).save(validate:false)
      def instructor = new Instructor().save(validate:false)
      def fechaDeInicio = new Date().format('dd/MM/yyyy')

      def cursoProgramado = new CursoProgramado(
        fechaDeInicio : fechaDeInicio,
        puerto : 1,
        curso : 1,
        instructor : 1
      )

      def alumnoEnBD = new Alumno(
        nombreCompleto : "---",
        observaciones : "----",
        tipoDePago : TipoDePago.BECADO,
        monto : 100
        )
      alumnoEnBD.save(validate:false)
      cursoProgramado.addToAlumnos(alumnoEnBD)
      cursoProgramado.save(validate:false)
    and:
      def alumnoData = [:]
      alumnoData.numeroDeControl = alumnoEnBD.numeroDeControl
      alumnoData.cursoProgramado = 1
    when:
      def alumno = service.updateAlumno(alumnoData)
    then:
      alumno.id == alumnoEnBD.id
      alumno.numeroDeControl == alumnoEnBD.numeroDeControl
      cursoProgramado.alumnos != null
      cursoProgramado.alumnos.size() == 1
  }

}
