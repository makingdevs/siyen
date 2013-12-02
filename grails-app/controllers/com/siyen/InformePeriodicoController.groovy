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
    Date desde = Date.parse("dd/MMM/yyyy", params.desde)
    Date hasta = Date.parse("dd/MMM/yyyy", params.hasta)

    def busquedaDeResultados = searchableService.search({
      must( between("fechaDeInicio", desde, hasta, true) )
    })

    def resultados = [:]

    busquedaDeResultados.results.each { cursoProgramado ->
      if( !resultados.(cursoProgramado.curso.clave) ) {
        resultados.(cursoProgramado.curso.clave) = 0
      }
      resultados.(cursoProgramado.curso.clave) += cursoProgramado.alumnos.size()
    }

    render resultados as JSON
  }

}
