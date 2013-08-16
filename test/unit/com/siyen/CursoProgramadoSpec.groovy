package com.siyen

import grails.test.mixin.*
import spock.lang.Specification

@TestFor(CursoProgramado)
@Mock([Puerto, Curso, Instructor, Alumno])
class CursoProgramadoSpec extends Specification {

	void "Crear nuevo curso con un alumno"() {
    setup : "Inicializando catálogos"
      Puerto puerto = new Puerto().save(validate:false)
      Curso curso = new Curso().save(validate:false)
      Instructor instructor = new Instructor().save(validate:false)

    and : "Creando un alumno"
      Alumno alumno = new Alumno(nombreCompleto:"Roger Waters", observaciones:"PULSE")

    when :
      CursoProgramado cursoProgramado = new CursoProgramado(
        fechaDeInicio : fechaDeInicio_,
        fechaDeTermino : fechaDeTermino_,
        puerto : puerto,
        curso : curso,
        instructor : instructor)

      cursoProgramado.addToAlumnos(alumno)
      cursoProgramado.save()

    then :
      assert cursoProgramado.id
      assert cursoProgramado.alumnos
      assert cursoProgramado.alumnos.size() == 1

    where :
      fechaDeInicio_ | fechaDeTermino_      || totalDeAlumnos
      new Date()     | new Date().plus(1)   || 1

	}

}