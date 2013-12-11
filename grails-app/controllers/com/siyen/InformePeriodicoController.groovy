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
    if(!claveDelPuerto && !libreta) {
      if(meses.size() == 12) {
        resultados = agruparResultadosGenerales(busquedaDeResultados, "puerto", "clave")
      } else {
        resultados = agruparResultadosPorMes(busquedaDeResultados, "puerto", "clave", meses)
      }
    } else if(!libreta) {
      if(meses.size() == 12) {
        resultados = agruparResultadosGenerales(busquedaDeResultados, "curso", "libreta")
      } else {
        resultados = agruparResultadosPorMes(busquedaDeResultados, "curso", "libreta", meses)
      }
    } else {
      if(meses.size() == 12) {
        resultados = agruparResultadosGenerales(busquedaDeResultados, "curso", "clave")
      } else {
        resultados = agruparResultadosPorMes(busquedaDeResultados, "curso", "clave", meses)
      }
    }

    log.debug resultados

    render resultados.sort { it.key } as JSON
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
