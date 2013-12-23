package com.siyen

class InformePeriodicoService {

  def datosDeGraficacion(anio) {
    def data = criteriaDeCrusoProgramado(anio)
    conteo(data, "puerto", "clave")
  }

  def datosDeGraficacion(anio, claveDelPuerto) {
    def puertoCriteria = criteriaDelPuerto(claveDelPuerto)

    def data = criteriaDeCrusoProgramado(anio, puertoCriteria)
    conteo(data, "curso", "libreta")
  }

  def datosDeGraficacion(anio, claveDelPuerto, libreta) {
    def puertoCriteria = criteriaDelPuerto(claveDelPuerto)

    def cursosPorLibreta = Curso.findAllByLibreta(libreta)
    def criteria = {
      puertoCriteria.delegate = delegate
      puertoCriteria()
      'in' ("curso", cursosPorLibreta)
    }

    def data = criteriaDeCrusoProgramado(anio, criteria)
    conteo(data, "curso", "clave")
  }

  private def criteriaDeCrusoProgramado(anio, criteria = null) {
    def cursoProgramadoCriteria = CursoProgramado.createCriteria()
    def resultados = cursoProgramadoCriteria.list {
      sqlRestriction "year(fecha_de_inicio) = ${anio}"

      criteria?.delegate = delegate
      criteria?.call()
    }

    resultados
  }

  private def criteriaDelPuerto(claveDelPuerto) {
    def puerto = Puerto.findByClave(claveDelPuerto)
    def puertoCriteria = {
      eq "puerto", puerto
    }
    puertoCriteria
  }

  private def conteo(data, relacion, propiedad) {
    def agrupamiento = [:]
    data.each { cursoProgramado ->
      if(!agrupamiento.(cursoProgramado."$relacion"."$propiedad")) {
        agrupamiento.(cursoProgramado."$relacion"."$propiedad") = 0
      }
      agrupamiento.(cursoProgramado."$relacion"."$propiedad") += 1
    }
    agrupamiento
  }
}
