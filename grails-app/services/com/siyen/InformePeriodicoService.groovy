package com.siyen

class InformePeriodicoService {

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

  private def criteriaPorMes(mes) {
    def mesCriteria = {
      sqlRestriction "month(fecha_de_inicio) = ${mes}"
    }
    mesCriteria
  }

  def datosDeGraficacion(anio, puerto = null, libreta = null) {
    def cursoProgramadoCriteria = CursoProgramado.createCriteria()
    String relacion = "puerto"
    String propiedad = "clave"

    def criteriaForAnio = criteriaBuilderForAnio(anio)
    def criteriaForPuerto = null
    def criteriaForLibreta = null

    if(puerto) {
      criteriaForPuerto = criteriaBuilderForPuerto(puerto)
      relacion = "curso"
      propiedad = "libreta"
    }

    if(libreta) {
      criteriaForLibreta = criteriaBuilderForLibreta(libreta)
      relacion = "curso"
      propiedad = "clave"
    }

    def resultados = cursoProgramadoCriteria.list {
      criteriaForAnio?.delegate = delegate
      criteriaForAnio?.call()

      criteriaForPuerto?.delegate = delegate
      criteriaForPuerto?.call()

      criteriaForLibreta?.delegate = delegate
      criteriaForLibreta?.call()
    }

    conteo(resultados, relacion, propiedad)
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
