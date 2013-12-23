package com.siyen

class InformePeriodicoService {

  // params.meses
  // params.puerto
  // params.libreta
  // params.anio

  def obtenerDatosDeGraficacion(anio, closurePuerto = null) {
    def cursoProgramadoCriteria = CursoProgramado.createCriteria()
    def resultados = cursoProgramadoCriteria.list {
      sqlRestriction "year(fecha_de_inicio) = ${anio}"

      closurePuerto?.delegate = delegate
      closurePuerto?.call()
    }

    resultados
  }

  def agrupar(anio, relacion, propiedad) {
    def data = obtenerDatosDeGraficacion(anio)
    def agrupamiento = [:]
    data.each { cursoProgramado ->
      if(!agrupamiento.(cursoProgramado."$relacion"."$propiedad")) {
        agrupamiento.(cursoProgramado."$relacion"."$propiedad") = 0
      }
      agrupamiento.(cursoProgramado."$relacion"."$propiedad") += 1
    }

    agrupamiento
  }

  def agrupar(anio, claveDelPuerto, relacion, propiedad) {
    def puerto = Puerto.findByClave(claveDelPuerto)
    def puertoCriteria = {
      eq "puerto", puerto
    }
    def data = obtenerDatosDeGraficacion(anio, puertoCriteria)

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
