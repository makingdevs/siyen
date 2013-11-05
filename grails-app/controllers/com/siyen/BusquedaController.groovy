package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    String busqueda = params.buscar.replace(',', " ").trim()
    log.debug busqueda

    def busquedaDeResultados = searchableService.search(busqueda)

    log.debug "total : ${busquedaDeResultados.total}"
    log.debug "size  : ${busquedaDeResultados.results.size()}"
  }

}
