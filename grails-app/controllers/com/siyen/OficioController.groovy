package com.siyen

import grails.plugin.rendering.pdf.*

class OficioController {

  def springSecurityService

  def index() {
    def puerto = Puerto.get(1)
    def desde = Date.parse('dd/MMMM/yyyy', (new Date() - 2).format('dd/MMMM/yyyy'))
    def hasta = Date.parse('dd/MMMM/yyyy', (new Date()).format('dd/MMMM/yyyy'))

    def data = [:]
    data.dirigidoA = "CAP. ALT. ANTONIO BURGUEÑO GUARDADO"
    data.puesto = "CAPITAN DE PUERTO"
    data.direccion = "CALZ. DIEGO MTZ. CORONA ZONA FRANCA EDIF. S.C.T. SEGUNDO PISO GUAYMAS, SON C.P. 85400"
    data.deParteDe = "Cap. Alt. Sergio Rolando Osuna Osuna"

    data.fechaActual = new Date().format("dd 'de' MMMM 'del' yyyy")
    data.puertoFechaAbbr = "GYS_${new Date().format('ddMMyy')}"
    data.puerto = "Guaymas, Sonora"
    data.desde = desde.format("dd 'de' MMMM 'del' yyyy")
    data.hasta = hasta.format("dd 'de' MMMM 'del' yyyy")
    data.cursos = CursoProgramado.findAllByFechaDeInicioBetween(desde, hasta)

    render(template: "/pdfs/oficio", model: [data:data])
  }

  def generarOficio() {
    def puerto = Puerto.get(params.puertoDeEnvio.toLong())
    def desde = Date.parse('dd/MMMM/yyyy', params.desde)
    def hasta = Date.parse('dd/MMMM/yyyy', params.hasta)

    def data = [:]
    data.dirigidoA = params.dirigidoA
    data.puesto = params.puesto
    data.direccion = params.direccion
    data.deParteDe = Instructor.get(params.deParteDe.toLong()).nombre

    data.fechaActual = new Date().format("dd 'de' MMMM 'del' yyyy")
    data.puertoFechaAbbr = "${puerto.clave}_${new Date().format('ddMMyy')}"
    data.puerto = "${puerto.puerto}, ${puerto.estado}"
    data.desde = desde.format("dd 'de' MMMM 'del' yyyy")
    data.hasta = hasta.format("dd 'de' MMMM 'del' yyyy")
    data.cursos = CursoProgramado.findAllByFechaDeInicioBetween(desde, hasta)

    renderPdf(template: "/pdfs/oficio", model: [data:data], filename: "oficio")
  }

}
