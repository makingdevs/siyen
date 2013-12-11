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

    if(meses.size() != 12) {
      busquedaDeResultados = busquedaDeResultados.findAll { cursoProgramado ->
        meses.find {
          it == cursoProgramado.fechaDeInicio.format('MM').toInteger()
        }
      }.groupBy({it.puerto.clave}, {it.fechaDeInicio.format('MM')})
    }

    def resultados = [:]
    if(!claveDelPuerto && !libreta) {
      if(meses.size() == 12) {
        busquedaDeResultados.groupBy { it.puerto.clave }.each {
          resultados.(it.key) = []
          resultados.(it.key) << it.value.size()
        }
      } else {
        busquedaDeResultados.each { k, v ->
          resultados.("$k") = []
          v.each { l, valor ->
            resultados.("$k") << valor.size()
          }
        }
      }
    } else if(!libreta) {
      busquedaDeResultados.groupBy { it.curso.libreta }.each {
        resultados.(it.key) = []
        resultados.(it.key) << it.value.size()
      }
    } else {
      busquedaDeResultados.groupBy { it.curso.clave }.each {
        resultados.(it.key) = []
        resultados.(it.key) << it.value.size()
      }
    }

    log.debug resultados

    render resultados.sort { it.key } as JSON
  }

}
