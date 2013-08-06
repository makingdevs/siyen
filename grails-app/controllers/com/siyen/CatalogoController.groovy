package com.siyen

class CatalogoController {

  def catalogoService

  def obtenerDatosDeCatalogos() {

    def instructoresDisponibles = catalogoService.obtenerInstructores()
    def cursosDisponibles = catalogoService.obtenerCursos()
    def puertosDisponibles = catalogoService.obtenerPuertos()

    render(contentType:"text/json") {
      [instructoresDisponibles : instructoresDisponibles,
            cursosDisponibles : cursosDisponibles,
            puertosDisponibles : puertosDisponibles]
    }

  }

}
