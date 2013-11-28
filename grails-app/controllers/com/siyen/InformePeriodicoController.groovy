package com.siyen

class InformePeriodicoController {

  def searchableService

  def index() { }

  def realizarInfome() {
    Date desde = Date.parse("dd/MMM/yyyy", params.desde)
    Date hasta = Date.parse("dd/MMM/yyyy", params.hasta)

    def busquedaDeResultados = searchableService.search({
      must( between("fechaDeInicio", desde, hasta, true) )
    })

    log.debug busquedaDeResultados.total
    log.debug busquedaDeResultados.results

    log.debug busquedaDeResultados.results.fechaDeInicio
    log.debug busquedaDeResultados.results.fechaDeTermino

    busquedaDeResultados.results
  }

}
