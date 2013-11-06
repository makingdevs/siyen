package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    String busqueda = params.buscar.replace(',', " ").trim()
    def busquedaDeResultados = searchableService.search(busqueda)
    log.debug "total : ${busquedaDeResultados.total}"
    log.debug "size  : ${busquedaDeResultados.results.size()}"

    render template:"/cursoProgramado/list", model:[lista : busquedaDeResultados.results]
  }

}
