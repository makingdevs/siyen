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
    def desde = Date.parse("dd/MM/yyyy", "01/01/${params.anios}")
    def hasta = Date.parse("dd/MM/yyyy", "31/12/${params.anios}")
    def curso = params.curso
    def puerto = params.puerto
    def libreta = params.libreta
    def graficacion = params.graficacion

    def busquedaDeResultados = searchableService.search({
      must( between("fechaDeInicio", desde, hasta, true) ) // puertos

      if(puerto) {
        must(queryString(puerto, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(libreta) {
        must(queryString(libreta, [useAndDefaultOperator: false, defaultSearchProperty: "libreta"]))
      }

      if(curso) {
        must(queryString(curso, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

    }, params)

    def resultados = [:]
    if(!curso && !puerto && !libreta) {
      busquedaDeResultados.results.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.puerto.clave) ) {
          resultados.(cursoProgramado.puerto.clave) = 0
        }
        resultados.(cursoProgramado.puerto.clave) += 1
      }
    }

    // def resultados = [:]
    // busquedaDeResultados.results.each { cursoProgramado ->
    //   if( !resultados.(cursoProgramado.curso.clave) ) {
    //     resultados.(cursoProgramado.curso.clave) = 0
    //   }
    //   resultados.(cursoProgramado.curso.clave) += cursoProgramado.alumnos.size()
    // }
    log.debug resultados

    render resultados as JSON
  }

}
