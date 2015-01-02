package com.siyen

import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(Puerto)
class PuertoSpec extends Specification {

  void "Validando constraints"() {
    setup:
    def puerto = new Puerto(
      clave : clave_,
      puerto : puerto_,
      estado : estado_,
      direccion : direccion_)

    when:
      puerto.save()

    then:
      assert puerto.errors.allErrors*.code == expected

    where:
    clave_ | puerto_ | estado_ | direccion_ || expected
    null   | null    | null    | null       || ["nullable"] * 4
    ""     | ""      | ""      | ""         || ["nullable"] * 4
    "1"*5  | "1"*36  | "1"*31  | "1"*501    || ["size.toobig"] * 4
    "1"*5  | "1"*36  | "1"*31  | ""         || ["size.toobig"] * 3 + ["nullable"]
  }

  void "Validando unique constraint"() {
    setup:
    def puerto = new Puerto(
      clave : clave_,
      puerto : puerto_,
      estado : estado_,
      direccion : direccion_)
    mockForConstraintsTests(Puerto, [puerto])

    def puerto2 = new Puerto(
      clave : clave_,
      puerto : puerto_,
      estado : estado_,
      direccion : direccion_)

    when:
      puerto2.save()

    then:
      assert puerto2.errors.allErrors*.code == expected

    where:
    clave_ | puerto_ | estado_ | direccion_ || expected
    "1"*4  | "1"*35  | "1"*30  | "1"        || ["unique"]
  }

  void "Validando unique constraint"() {
    setup:
    def puerto = new Puerto(
      clave : clave_,
      puerto : puerto_,
      estado : estado_,
      direccion : direccion_)
    mockForConstraintsTests(Puerto, [puerto])

    when:
      puerto.save()

    then:
      assert puerto.errors.allErrors*.code == expected

    where:
    clave_ | puerto_           | estado_   | direccion_                                                                             || expected
    "PVJ"  | "Puerto Vallarta" | "Jalisco" | "BLVD.FCO.MEDINA ASCENCIO. KM. 4.6 TERMINAL MARITIMA PUERTO VALLARTA, JAL. C.P. 48302" || []
    "PVJ"  | "Puerto Vallarta" | "Jalisco" | ""                                                                                     || ["nullable"]
  }



}