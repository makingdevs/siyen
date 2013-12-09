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

    log.debug busquedaDeResultados.groupBy { it.puerto.clave }.collect { [(it.key) : it.value.size()] }

    def resultados = [:]
    if(!claveDelPuerto && !libreta) {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.puerto.clave) ) {
          resultados.(cursoProgramado.puerto.clave) = 0
        }
        resultados.(cursoProgramado.puerto.clave) += 1
      }
    } else if(!libreta) {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.libreta) ) {
          resultados.(cursoProgramado.curso.libreta) = 0
        }
        resultados.(cursoProgramado.curso.libreta) += 1
      }
    } else {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.clave) ) {
          resultados.(cursoProgramado.curso.clave) = 0
        }
        resultados.(cursoProgramado.curso.clave) += 1
      }
    }

    log.debug resultados
    render resultados.sort { it.key } as JSON
  }

}
