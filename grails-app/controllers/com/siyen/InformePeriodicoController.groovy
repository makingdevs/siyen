package com.siyen

import grails.converters.JSON

class InformePeriodicoController {

  def searchableService
  def catalogoService

  def index() {

    def anios = CursoProgramado.executeQuery("SELECT SUBSTRING(da.fechaDeInicio, 1, 4) FROM CursoProgramado as da group by SUBSTRING(da.fechaDeInicio, 1, 4)")
    def cursos = catalogoService.obtenerCursos()
    def puertos = catalogoService.obtenerPuertos()
    def libretas = cursos.collect { it.libreta }.unique()

    [anios : anios, puertos : puertos, libretas : libretas, cursos : cursos]
  }

  def realizarInforme() {
    def meses = []
    meses.addAll(params.meses ?: 1..12)
    meses = meses.sort()*.toLong()
    
    def claveDelPuerto = params.puerto
    def libreta = params.libreta

    def cursoProgramadoQuery = CursoProgramado.where {
      year(fechaDeInicio) == params.anio

      if(claveDelPuerto) {
        puerto.clave == claveDelPuerto
      }

      if(libreta) {
        curso.libreta == libreta
      }
    }

    def busquedaDeResultados = cursoProgramadoQuery.findAll()

    def resultados = [:]
    if(meses.size() == 12){
      resultados = agrupamientoGeneral(busquedaDeResultados, claveDelPuerto, libreta)
    } else {
      resultados = agrupamientoPorMeses(busquedaDeResultados, claveDelPuerto, libreta, meses)
    }

    log.debug resultados

    render resultados.sort { it.key } as JSON
  }

  private def agrupamientoGeneral(busqueda, claveDelPuerto, libreta) {
    if(!claveDelPuerto && !libreta) {
      return agruparResultadosGenerales(busqueda, "puerto", "clave")
    } else if(!libreta) {
      return agruparResultadosGenerales(busqueda, "curso", "libreta")
    }

    return agruparResultadosGenerales(busqueda, "curso", "clave")
  }

  private def agrupamientoPorMeses(busqueda, claveDelPuerto, libreta, meses) {
    if(!claveDelPuerto && !libreta) {
      return agruparResultadosPorMes(busqueda, "puerto", "clave", meses)
    } else if(!libreta) {
      return agruparResultadosPorMes(busqueda, "curso", "libreta", meses)
    }

    return agruparResultadosPorMes(busqueda, "curso", "clave", meses)
  }

  private def agruparResultadosGenerales(busqueda, relacion, propiedad) {
    def resultados = [:]
    busqueda.groupBy { it."${relacion}"."${propiedad}" }.each {
      resultados.(it.key) = []
      resultados.(it.key) << it.value.size()
    }
    resultados
  }

  private def agruparResultadosPorMes(busqueda, relacion, propiedad, meses) {
    def resultados = [:]
    busqueda = busqueda.findAll { cursoProgramado ->
      meses.find {
        it == cursoProgramado.fechaDeInicio.format('MM').toInteger()
      }
    }.groupBy({it."${relacion}"."${propiedad}"}, {it.fechaDeInicio.format('MM')})

    busqueda.each { k, v ->
      resultados.("$k") = []
      v.each { l, valor ->
        resultados.("$k") << valor.size()
      }
    }
    resultados
  }

}
