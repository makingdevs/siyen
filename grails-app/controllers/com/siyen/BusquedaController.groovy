package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    log.debug params.buscar
    log.debug params.cursos
    log.debug params.puertos
    log.debug params.instructores

    String busqueda = params.buscar.replace(',', " ").trim()
    String cursos = params.cursos?.replace(',', " ")?.trim()
    String puertos = params.puertos?.replace(',', " ")?.trim()
    String instructores = params.instructores?.replace(',', " ")?.trim()

    def busquedaDeResultados = searchableService.search({
      must(queryString(busqueda))

      if(cursos) {
        must(queryString(cursos, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(puertos) {
        must(queryString(puertos, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(instructores) {
        must(queryString(instructores, [useAndDefaultOperator: false, defaultSearchProperty: "nombre"]))
      }

    }, params)
    render template:"/cursoProgramado/list", model:[ busqueda : busqueda, cursos : cursos, puertos : puertos, instructores : instructores, totalResultados : busquedaDeResultados.total, lista : busquedaDeResultados.results]
  }

}
