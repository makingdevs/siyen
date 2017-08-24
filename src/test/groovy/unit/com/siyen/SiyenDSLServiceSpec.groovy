package com.siyen

import spock.lang.*
import grails.test.mixin.*

 @TestFor(SiyenDSLService)
 class SiyenDSLServiceSpec extends Specification {

    def "La llamada al DSL en años debe regresa un mapa con enteros"(){
      when:
        def result = service.dataGraph {
          forYear 2012
        }
      then:
        result instanceof Map
        result*.key*.every { c -> c instanceof String }
        result*.value*.every { c -> c instanceof Integer }
    }

    def "La llamada al DSL en años debe regresa un mapa con una lista de enteros"(){
      when:
        def result = service.dataGraph {
          forYear 2012
          inMonths 3
        }
      then:
        result instanceof Map
        result*.key*.every { c -> c instanceof String }
        result*.value*.every { c -> c instanceof List }
    }
 }
