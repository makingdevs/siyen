package com.siyen

import grails.plugin.spock.IntegrationSpec

class InformePeriodicoServiceSpec extends IntegrationSpec {

  def informePeriodicoService

  def "Obteniendo los datos de graficación para los puertos por año"() {
    setup : "Asignando los valores a graficar"
      def anio = 2012

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.agrupar(anio, "puerto", "clave")

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          '0'     : 12,
          'ACG'   : 206,
          'ATL'   : 5,
          'BABC'  : 2,
          'BTBC'  : 1,
          'CHJ'   : 8,
          'CHX'   : 11,
          'CSL'   : 38,
          'CULS'  : 2,
          'DF'    : 41,
          'EJMC'  : 1,
          'ENS'   : 387,
          'GJJ'   : 2,
          'GNBC'  : 7,
          'GYS'   : 360,
          'ICBC'  : 9,
          'LCM'   : 24,
          'LIBC'  : 2,
          'LPB'   : 193,
          'MZO'   : 174,
          'MZS'   : 1480,
          'PMCH'  : 13,
          'PPS'   : 21,
          'PVJ'   : 43,
          'PZM'   : 4,
          'RIN'   : 4,
          'SBN'   : 40,
          'SCO'   : 235,
          'SFBC'  : 13,
          'TOP'   : 57,
          'VBEM'  : 4,
          'YAS'   : 6,
          'YUR'   : 1,
          'ZIH'   : 36
        ]
      ]
  }

  def "Obteniendo los datos de graficación para los puertos por año y meses"() {
    setup : "Asignando los valores a graficar"
      def anio = 2012
      def puerto = "GYS"

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.agrupar(anio, puerto, "curso", "libreta")

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          A : 154,
          B : 169,
          C : 36,
          D : 1
        ]
      ]
  }

}
