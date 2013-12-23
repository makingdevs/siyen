package com.siyen

class InformePeriodicoService {

  def datosDeGraficacion(anio) {
    def data = criteriaDeCursoProgramado(anio)
    conteo(data, "puerto", "clave")
  }

  def datosDeGraficacion(anio, claveDelPuerto) {
    def puertoCriteria = criteriaDelPuerto(claveDelPuerto)

    def data = criteriaDeCursoProgramado(anio, puertoCriteria)
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

    def data = criteriaDeCursoProgramado(anio, criteria)
    conteo(data, "curso", "clave")
  }

  def datosDeGraficacionParaElMes(anio, mes) {
    def mesCriteria = {
      sqlRestriction "month(fecha_de_inicio) = ${mes}"
    }

    def data = criteriaDeCursoProgramado(anio, mesCriteria)
    conteo(data, "puerto", "clave")
  }

  def datosDeGraficacionParaElMes(anio, claveDelPuerto, mes) {
    def puertoCriteria = criteriaDelPuerto(claveDelPuerto)
    def mesCriteria = {
      sqlRestriction "month(fecha_de_inicio) = ${mes}"
      puertoCriteria.delegate = delegate
      puertoCriteria()
    }

    def data = criteriaDeCursoProgramado(anio, mesCriteria)
    conteo(data, "curso", "libreta")
  }

  def datosDeGraficacionParaElMes(anio, claveDelPuerto, libreta, mes) {
    def puertoCriteria = criteriaDelPuerto(claveDelPuerto)
    def cursosPorLibreta = Curso.findAllByLibreta(libreta)

    def mesCriteria = {
      sqlRestriction "month(fecha_de_inicio) = ${mes}"
      puertoCriteria.delegate = delegate
      puertoCriteria()
      'in' ("curso", cursosPorLibreta)
    }

    def data = criteriaDeCursoProgramado(anio, mesCriteria)
    conteo(data, "curso", "clave")
  }

  private def criteriaDeCursoProgramado(anio, criteria = null) {
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
