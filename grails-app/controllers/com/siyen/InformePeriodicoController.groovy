package com.siyen

import grails.converters.JSON

class InformePeriodicoController {

  def catalogoService
  def informePeriodicoService

  def index() {

    def anios = CursoProgramado.executeQuery("SELECT SUBSTRING(da.fechaDeInicio, 1, 4) FROM CursoProgramado as da group by SUBSTRING(da.fechaDeInicio, 1, 4)")
    def cursos = catalogoService.obtenerCursos()
    def puertos = catalogoService.obtenerPuertos()
    def libretas = cursos.collect { it.libreta }.unique()

    [anios : anios, puertos : puertos, libretas : libretas, cursos : cursos]
  }

  def realizarInforme() {
    if( params.mes instanceof Object[] ) {
      def meses = []
      meses.addAll( params.mes )
      params.mes = meses
    }

    def paramsFiltrado = params.findAll { k, v -> k != "action" && k != "controller" && v }
    def resultados = informePeriodicoService.datosDeGraficacion(paramsFiltrado)
    render resultados as JSON
  }

}
