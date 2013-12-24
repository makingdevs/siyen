package com.siyen

import grails.plugin.spock.IntegrationSpec

class InformePeriodicoServiceSpec extends IntegrationSpec {

  def informePeriodicoService

  def "Obteniendo los datos de graficación para los puertos por año"() {
    setup : "Asignando los valores a graficar"
      def params = ['anio':2012]

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

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

  def "Obteniendo los datos de graficación para las libretas por puerto y año"() {
    setup : "Asignando los valores a graficar"
      def params = [:]
      params.anio = 2012
      params.puerto = "GYS"

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          'A' : 154,
          'B' : 169,
          'C' : 36,
          'D' : 1
        ]
      ]
  }

  def "Obteniendo los datos de graficación para el tipo de libreta por año y puerto"() {
    setup : "Asignando los valores a graficar"
      def params = [:]
      params.anio = 2012
      params.puerto = "GYS"
      params.libreta = "A"

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          'CAPACO3234' : 7,
          'CAPCAM311'  : 8,
          'CAPCOC312'  : 5,
          'CAPCON322'  : 11,
          'CAPMAY313'  : 4,
          'CAPMOT331'  : 7,
          'CAPMOT333'  : 1,
          'CAPTIM321'  : 11,
          'COURSE2_09' : 1,
          'FAMBT1'     : 25,
          'INICIA'     : 8,
          'INICIA1'    : 13,
          'STCW95'     : 46,
          'STCW95_1'   : 6,
          'STCW95_2'   : 1
        ]
      ]
  }

  def "Obteniendo los datos de graficación para los puertos por año en un mes"() {
    setup : "Asignando los valores a graficar"
      def params = [:]
      params.anio = 2012
      params.mes = 3

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          '0'     :  2,
          'ACG'   : 10,
          'ATL'   :  1,
          'CSL'   : 10,
          'CULS'  :  1,
          'DF'    :  8,
          'ENS'   : 39,
          'GYS'   : 30,
          'LCM'   :  1,
          'LPB'   : 17,
          'MZO'   :  9,
          'MZS'   :105,
          'PZM'   :  1,
          'SBN'   :  2,
          'SCO'   : 31,
          'TOP'   :  3,
          'ZIH'   : 10
        ]
      ]
  }

  def "Obteniendo los datos de graficación para las libretas por puerto, año y mes"() {
    setup : "Asignando los valores a graficar"
      def params = [:]
      params.anio = 2012
      params.puerto = "GYS"
      params.mes = 3

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          'A' : 17,
          'B' : 9,
          'C' : 4
        ]
      ]
  }

  def "Obteniendo los datos de graficación para el tipo de libreta por año, puerto y mes"() {
    setup : "Asignando los valores a graficar"
      def params = [:]
      params.anio = 2012
      params.puerto = "GYS"
      params.libreta = "A"
      params.mes = 3

    when : "Llamando al servicio de graficación"
      def resultados = informePeriodicoService.datosDeGraficacion(params)

    then :
      resultados.size() == datosAGraficar.size()
      resultados == datosAGraficar

    where :
      datosAGraficar << [
        [
          CAPACO3234 : 2,
          CAPCAM311 : 2,
          CAPCOC312 : 1,
          CAPCON322 : 3,
          CAPMOT331 : 1,
          FAMBT1 : 2,
          STCW95 : 3,
          STCW95_1 : 3
        ]
      ]
  }
}
