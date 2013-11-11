package com.siyen

class BusquedaController {

  def searchableService

  def realizarBusqueda() {
    String busqueda = params.buscar.replace(',', " ").trim()
    String cursos = params.cursos?.replace(',', " ")?.trim()
    String puertos = params.puertos?.replace(',', " ")?.trim()
    String instructores = params.instructores?.replace(',', " ")?.trim()

    def busquedaDeResultados = searchableService.search({
      if(busqueda) {
        must(queryString(busqueda))
      }

      if(cursos) {
        must(queryString(cursos, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(puertos) {
        must(queryString(puertos, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(instructores) {
        must(queryString(instructores, [useAndDefaultOperator: false, defaultSearchProperty: "nombre"]))
      }

      if(params.desde) {
        Date desde = Date.parse("dd/MMM/yyyy", params.desde)
        Date hasta = params.hasta ? Date.parse("dd/MMM/yyyy", params.hasta) : new Date()
        must( between("fechaDeInicio", desde, hasta, true) )
      }

    }, params)
    render template:"/cursoProgramado/list", model:[ busqueda : busqueda, cursos : cursos, puertos : puertos, instructores : instructores,  desde : params.desde, hasta : params.hasta, totalResultados : busquedaDeResultados.total, lista : busquedaDeResultados.results]
  }

}
