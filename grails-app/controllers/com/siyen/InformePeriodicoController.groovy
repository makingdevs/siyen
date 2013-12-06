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
    def meses = []
    if(params?.meses){
      meses.addAll(params?.meses)
      meses = meses.sort()*.toLong()
    }
    def puerto = Puerto.findByClave( params.puerto )
    def cursosPorLibretas = Curso.findAllByLibreta( params.libreta )

    def c = CursoProgramado.createCriteria()
    def busquedaDeResultados = c.list {
      or {
        meses.each {
          def desde = Date.parse("dd/MM/yyyy", "01/${it}/${params.anios}")
          def hasta = Date.parse("dd/MM/yyyy", "31/${it}/${params.anios}")
          between("fechaDeInicio", desde, hasta)
        }
      }
      if (puerto) eq "puerto", puerto
      if (cursosPorLibretas) 'in' ( "curso", cursosPorLibretas )
    }

    def resultados = [:]
    if(!puerto && !cursosPorLibretas) {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.puerto.clave) ) {
          resultados.(cursoProgramado.puerto.clave) = 0
        }
        resultados.(cursoProgramado.puerto.clave) += 1
      }
    } else if(!cursosPorLibretas) {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.libreta) ) {
          resultados.(cursoProgramado.curso.libreta) = 0
        }
        resultados.(cursoProgramado.curso.libreta) += 1
      }
    } else {
      busquedaDeResultados.each { cursoProgramado ->
        if( !resultados.(cursoProgramado.curso.clave) ) {
          resultados.(cursoProgramado.curso.clave) = 0
        }
        resultados.(cursoProgramado.curso.clave) += 1
      }
    }

    render resultados.sort { it.key } as JSON
  }

}
