package com.siyen

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(Curso)
class CursoSpec extends Specification {

  void "Validando constraints"() {
    setup:
      def curso = new Curso(
        clave : clave_,
        nombre : nombre_,
        duracion : duracion_,
        libreta : libreta_
      )

    when:
      curso.save()

    then:
      assert curso.errors.allErrors*.code == expected

    where:
    clave_ | nombre_ | duracion_ | libreta_   || expected
    null   | null    | null      | null       || ["nullable"] * 4
    ""     | ""      | 1         | ""         || ["nullable"] * 3
    "1"*31 | "1"*256 | 1         | "12"       || ["size.toobig"] * 3
    "1"    | "10"    | 6         | "1"        || ["max.exceeded"]
    "1"    | "10"    | 5         | "1"        || []
  }

}
