package com.siyen

import grails.converters.JSON

class InformePeriodicoController {

  def searchableService

  def index() { }

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
