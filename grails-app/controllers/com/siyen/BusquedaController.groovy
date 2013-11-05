package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    String busqueda = params.buscar.replace(',', " ").trim()
    def busquedaDeResultados = searchableService.search(busqueda)
    log.debug "total : ${busquedaDeResultados.total}"
    log.debug "size  : ${busquedaDeResultados.results.size()}"

    render(contentType:"text/json") {
      [totalResultados : busquedaDeResultados.total,
            resultados : busquedaDeResultados.results]
    }
  }

}
