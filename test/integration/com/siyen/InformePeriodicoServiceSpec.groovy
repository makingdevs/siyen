package com.siyen

import grails.plugin.spock.IntegrationSpec

class InformePeriodicoServiceSpec extends IntegrationSpec {

  def informePeriodicoService

  def "Obteniendo los datos de graficación"() {
    setup : "Asignando los valores a graficar"
      def anio = "2012"

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.obtenerDatosDeGraficacion(anio:anio)

    then :
      resultados
  }

}
