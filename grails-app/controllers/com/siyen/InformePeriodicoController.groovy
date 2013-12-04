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
    def puerto = params.puerto
    def libreta = params.libreta
    def curso = params.curso
    def graficacion = params.graficacion

    def busquedaDeResultados = searchableService.search({
      must( between("fechaDeInicio", desde, hasta, true) ) // puertos

      if(puerto || libreta) {
        must(queryString(puerto, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

      if(curso) {
        must(queryString(curso, [useAndDefaultOperator: false, defaultSearchProperty: "clave"]))
      }

    }, params)

    def resultados = [:]
    if(!puerto && !libreta && !curso) {
      busquedaDeResultados.results.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.puerto.clave) ) {
          resultados.(cursoProgramado.puerto.clave) = 0
        }
        resultados.(cursoProgramado.puerto.clave) += 1
      }
    } else if(!libreta && !curso) {
      busquedaDeResultados.results.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.libreta) ) {
          resultados.(cursoProgramado.curso.libreta) = 0
        }
        resultados.(cursoProgramado.curso.libreta) += 1
      }
    } else {
      def resultadosPorLibreta = busquedaDeResultados.results.findAll { it.curso.libreta == libreta }

      resultadosPorLibreta.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.clave) ) {
          resultados.(cursoProgramado.curso.clave) = 0
        }
        resultados.(cursoProgramado.curso.clave) += 1
      }
    }

    log.debug resultados.sort { it.key }

    render resultados.sort { it.key } as JSON
  }

}
