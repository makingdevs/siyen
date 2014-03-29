package com.siyen

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(Instructor)
class InstructorSpec extends Specification {

  void "Validando constraints"() {
    setup:
    def instructor = new Instructor(
      nombre : nombre_,
      numeroDeOficio : numeroDeOficio_ )

    when:
      instructor.save()

    then:
      assert instructor.errors.allErrors*.code == expected

    where:
      nombre_         | numeroDeOficio_           || expected
      null            | null                 || ["nullable"]*2
      ""              | ""                   || ["nullable"]*2
      "1"*256         | "1"*51               || ["size.toobig"]*2
      "Cap. Altamira" | "XXX.XXX/XXXX-XXXX"  || []
  }

}
