package com.siyen

class InformePeriodicoService {

  def datosDeGraficacion(def params) {
    if( params.mes instanceof List ) {
      return conteoDeResultadosPorMeses(params)
    }

    conteoDeResultados( params )
  }

  private def conteoDeResultados(params, mes = null) {
    def (relacion, propiedad) = seleccionarMetodoDeConteo(params.keySet())
    def cursoProgramadoCriteria = CursoProgramado.createCriteria()
    def listaDeClosuresDeCriteria = []

    (params.keySet() - "agrupacion").each { key ->
      def value = params["${key}"]
      def criteriaBuilder = "criteriaBuilderFor${key.capitalize()}"(value)
      listaDeClosuresDeCriteria << {
        criteriaBuilder.delegate = delegate
        criteriaBuilder.call()
      }
    }

    if( mes ) {
      def criteriaBuilder = criteriaBuilderForMes(mes)
      listaDeClosuresDeCriteria << {
        criteriaBuilder.delegate = delegate
        criteriaBuilder.call()
      }
    }

    def resultados = cursoProgramadoCriteria.list {
      listaDeClosuresDeCriteria*.delegate = delegate
      listaDeClosuresDeCriteria*.call()
    }

    def acumulador = { 1 }
    if(params.agrupacion) {
      acumulador = { it.alumnos.size() }
    }

    conteo(resultados, relacion, propiedad, acumulador).withDefault { d -> 0 }
  }

  private def conteoDeResultadosPorMeses(params) {
    def conteoAgrupadoPorMeses = [:]
    params.mes.each { mes ->
      def listaDeLlavesSinMes = params.keySet() - "mes"
      def paramsSinMes = params.findAll { k, v -> k != "mes" }
      conteoAgrupadoPorMeses.("${mes}") = conteoDeResultados( paramsSinMes, mes )
    }

    conteoAgrupadoPorMeses*.value*.keySet().flatten().unique().each {
      conteoAgrupadoPorMeses*.value*.get( it )
    }

    def ordenamientoDeConteoAgrupadoPorMeses = [:]
    conteoAgrupadoPorMeses.each { k, v ->
      ordenamientoDeConteoAgrupadoPorMeses.("${k}") = v.sort { it.key }
    }

    ordenamientoDeConteoAgrupadoPorMeses
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

  private def conteo(data, relacion, propiedad, Closure acumulador) {
    def agrupamiento = [:]
    data.each { cursoProgramado ->
      if(!agrupamiento.(cursoProgramado."$relacion"."$propiedad")) {
        agrupamiento.(cursoProgramado."$relacion"."$propiedad") = 0
      }

      agrupamiento.(cursoProgramado."$relacion"."$propiedad") += acumulador(cursoProgramado)
    }
    agrupamiento.sort { it.key }
  }

  private def seleccionarMetodoDeConteo(def keySet) {
    if(keySet.contains('libreta'))
      return ["curso", "clave"]

    if(keySet.contains('puerto'))
      return ["curso", "libreta"]

    return ["puerto", "clave"]
  }

}
