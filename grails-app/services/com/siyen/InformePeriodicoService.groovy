package com.siyen

class InformePeriodicoService {

  def datosDeGraficacion(def params) {
    def (relacion, propiedad) = seleccionarMetodoDeConteo(params.keySet())
    def cursoProgramadoCriteria = CursoProgramado.createCriteria()
    def listaCriteriaClosures = []

    params.keySet().each { key ->
      def value = params["${key}"]
      def criteriaBuilder = "criteriaBuilderFor${key.capitalize()}"(value)
      listaCriteriaClosures << {
        criteriaBuilder.delegate = delegate
        criteriaBuilder.call()
      }
    }

    def resultados = cursoProgramadoCriteria.list {
      listaCriteriaClosures*.delegate = delegate
      listaCriteriaClosures*.call()
    }

    conteo(resultados, relacion, propiedad)
  }

  private def criteriaBuilderForAnio(anio) {
    def criteriaBase = {
      sqlRestriction "year(fecha_de_inicio) = ${anio}"
    }
    criteriaBase
  }

  private def criteriaBuilderForPuerto(claveDelPuerto) {
    def puerto = Puerto.findByClave(claveDelPuerto)
    def puertoCriteria = {
      eq "puerto", puerto
    }
    puertoCriteria
  }

  private def criteriaBuilderForLibreta(libreta) {
    def cursosPorLibreta = Curso.findAllByLibreta(libreta)
    def libretaCriteria = {
      'in' ("curso", cursosPorLibreta)
    }
    libretaCriteria
  }

  private def criteriaBuilderForMes(mes) {
    def mesCriteria = {
      sqlRestriction "month(fecha_de_inicio) = ${mes}"
    }
    mesCriteria
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

  private def seleccionarMetodoDeConteo(def keySet) {
    if(keySet.contains('libreta'))
      return ["curso", "clave"]
    
    if(keySet.contains('puerto'))
      return ["curso", "libreta"]

    return ["puerto", "clave"]
  }

}
