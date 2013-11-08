package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    String busqueda = params.buscar.replace(',', " ").trim()
    def busquedaDeResultados = searchableService.search(busqueda, params)

    render template:"/cursoProgramado/list", model:[ busqueda : busqueda, totalResultados : busquedaDeResultados.total, lista : busquedaDeResultados.results]
  }

}
